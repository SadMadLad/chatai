# frozen_string_literal: true

module MessagesHelper
  RENDERER = Redcarpet::Markdown.new(RougeHelper::HTML, fenced_code_blocks: true, highlight: true)

  def markdown_render(message)
    RENDERER.render(sanitize(message))
  end
end
