module ApplicationHelper
    def markdown(text)
        renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
        options = {
          autolink: true,
          tables: true,
          fenced_code_blocks: true,
          strikethrough: true,
          lax_spacing: true,
          space_after_headers: true,
          no_intra_emphasis: true
        }
        markdown = Redcarpet::Markdown.new(renderer, options)
        markdown.render(text).html_safe
    end
end
