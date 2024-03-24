# frozen_string_literal: true

module MessagesHelper
  def markdown_render(message)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(sanitize(message))
  end
end
