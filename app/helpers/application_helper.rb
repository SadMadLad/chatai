# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  FLASH_COLORS = {
    alert: { bg: 'bg-red-500', text: 'text-red-500', bg_light: 'bg-red-100' },
    notice: { bg: 'bg-green-500', text: 'text-green-500', bg_light: 'bg-green-100' }
  }.freeze

  def spread_record(record, except: [])
    content_tag(:div) do
      record.attributes.except(*except).map do |attribute, value|
        content_tag(:div, "#{attribute}: #{value}")
      end.join.html_safe
    end
  end

  def flash_color(color_type)
    FLASH_COLORS[flash[:alert] ? :alert : :notice][color_type]
  end
end
