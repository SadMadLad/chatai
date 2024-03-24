# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  FLASH_COLORS = {
    alert: { bg: 'bg-red-500', text: 'text-red-500', bg_light: 'bg-red-100' },
    notice: { bg: 'bg-green-500', text: 'text-green-500', bg_light: 'bg-green-100' }
  }.freeze

  DIALOG_FRAME_ATTRIBUTES = {
    class: 'p-0 rounded-xl',
    data: { controller: 'dialog', dialog_target: 'dialog', action: 'click->dialog#removeDialog' }
  }.freeze

  NAVIGATION_LINKS = {
    'Chats' => {
      route: %i[chats],
      controller: 'chats',
      action: 'index'
    },
    'Group Chats' => {
      route: %i[group chats],
      controller: 'chats',
      action: 'group'
    },
    'AI Chats' => {
      route: %i[ai_chats chats],
      controller: 'chats',
      action: 'ai_chats'
    }
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

  def dialog_frame(attributes: {}, &block)
    turbo_frame_tag('dialog') do
      content_tag(:dialog, **DIALOG_FRAME_ATTRIBUTES.deep_merge(attributes)) { content_tag(:div, class: 'p-6', &block) }
    end
  end

  def turbo_frame_with_flash_message(id, &block)
    turbo_frame_tag(id) do
      concat turbo_stream.append('flash', partial: 'shared/flash')
      concat capture(&block) if block
    end
  end

  def random_bg_color
    %w[bg-blue-500 bg-red-500 bg-green-500 bg-purple-500 bg-cyan-500].sample
  end
end
