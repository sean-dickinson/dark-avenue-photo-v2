class Images::ResponsiveImage < Bridgetown::Component

  SIZED_PHOTO_URLS = %i[medium_url medium_large_url large_url]

  def initialize(image_data:, lazy: false)
    @image_data = image_data
    @lazy = lazy
  end

  def alt
    @image_data.name
  end

  def lazy?
    @lazy
  end

  def src_set
    SIZED_PHOTO_URLS.map do |url_name|
      build_src_from_size(url_name:)
    end.join(', ')
  end

  def src
    @image_data.medium_large_url
  end

  def width
    @image_data.width
  end

  def height
    @image_data.height
  end

  private


  def build_src_from_size(url_name:)
    url = @image_data.send(url_name)
    size = photo_sizes[url_name]
    [url, size].join(' ')
  end

  def photo_sizes
    {
      medium_url: '300w',
      medium_large_url: '768w',
      large_url: '1024w'
    }
  end

end
