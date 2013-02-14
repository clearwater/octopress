module Jekyll
  class Youtube < Liquid::Tag
    @@width = 640
    @@height = 390

    def initialize(name, id, tokens)
      super
      @id = id.strip
    end

    def render(context)
      %(<iframe width="#{@@width}" height="#{@@height}" src="http://www.youtube.com/embed/#{@id}" frameborder="0" webkitAllowFullScreen="webkitAllowFullScreen"  mozallowfullscreen="mozallowfullscreen" allowFullScreen="allowFullScreen"> </iframe>)
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::Youtube)
