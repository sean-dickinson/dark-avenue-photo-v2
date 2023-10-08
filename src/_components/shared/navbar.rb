class Shared::Navbar < Bridgetown::Component
  def initialize(metadata:, resource:)
    @metadata, @resource = metadata, resource
  end

  def links
    [
      { name: "People", href: "/people" },
      { name: "Places", href: "/places" },
      { name: "Things", href: "/things" },
    ]
  end
end
