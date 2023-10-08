class Builders::LoadWordpressContent < SiteBuilder
  BASE_URL = "http://wp.darkavenuephotography.com"
  IMAGE_DETAILS = Data.define(:width, :height, :medium_url, :medium_large_url, :large_url)

  def build
    # get the categories
    params = {
      headers: { "Accept" => "application/json" },
      rest_route: "/wp/v2/categories/"
    }
    get BASE_URL, **params do |categories|
      categories.each do |category|
        add_posts_from_category category
      end
    end
  end

  private

  def add_posts_from_category(category)
    params = {
      headers: { "Accept" => "application/json" },
      rest_route: "/wp/v2/posts",
      orderby: "slug",
      categories: category[:id],
      _embed: true
    }
    get BASE_URL, **params do |data|
      data.each do |post|
        image_details = parse_image_details(post)
        if image_details.nil?
          puts "Invalid image for #{post[:slug]}"
          next
        end
        add_resource category[:slug], "#{post[:id]}.md" do
          name post[:slug]
          width image_details.width
          height image_details.height
          medium_url image_details.medium_url
          medium_large_url image_details.medium_large_url
          large_url image_details.large_url
        end
      end
    end
  end

  def parse_image_details(post)
    image = post.dig(:_embedded, :"wp:featuredmedia", 0)
    return nil unless image[:media_details]
    details = {}

    details[:width] = image.dig(:media_details, :width)
    details[:height] = image.dig(:media_details, :height)
    %i[medium medium_large large].each do |size|
      details[:"#{size}_url"] = image.dig(:media_details, :sizes, size, :source_url)
    end
    IMAGE_DETAILS.new(**details)
  end
end
