# frozen_string_literal: true

# Helpers for messages - typically for rendering its markdown.
module MarkdownHelper
  RENDERER = Redcarpet::Markdown.new(RougeHelper::HTML, fenced_code_blocks: true, highlight: true)

  def markdown_render(markdown)
    RENDERER.render(sanitize(markdown)).html_safe
  end
end
