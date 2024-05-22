# frozen_string_literal: true

# Generic Helpers
module ApplicationHelper
  include Pagy::Frontend

  FLASH_STYLES = {
    alert: { bg: 'bg-red-500', text: 'text-red-500', bg_light: 'bg-red-100', icon: 'fas fa-times-circle' },
    notice: { bg: 'bg-green-500', text: 'text-green-500', bg_light: 'bg-green-100', icon: 'fas fa-check-circle' }
  }.freeze

  DIALOG_FRAME_ATTRIBUTES = {
    class: 'p-0 rounded-xl',
    data: { controller: 'dialog', dialog_target: 'dialog', action: 'click->dialog#removeDialog' }
  }.freeze

  NAVIGATION_LINKS = {
    'Feed' => {
      route: %i[dashboard],
      controller: 'dashboard',
      action: 'index',
      auth: :auth_only
    },
    'Chats' => {
      route: %i[chats],
      controller: 'chats',
      action: 'index',
      auth: :auth_only
    },
    'Group Chats' => {
      route: %i[group chats],
      controller: 'chats',
      action: 'group',
      auth: :auth_only
    },
    'AI Chats' => {
      route: %i[ai_chats chats],
      controller: 'chats',
      action: 'ai_chats',
      auth: :auth_only
    },
    'Blogs' => {
      route: %i[pages],
      controller: 'static',
      action: 'pages',
      auth: :both
    }
  }.freeze

  def flash_style(color_type)
    FLASH_STYLES[flash[:alert] ? :alert : :notice][color_type]
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

  def authed_routes
    filter_routes(%i[auth_only both])
  end

  def unauthed_routes
    filter_routes(%i[unauth_only both])
  end

  def both_routes
    filter_routes(:both)
  end

  def filter_routes(auth)
    return NAVIGATION_LINKS if auth.blank?

    NAVIGATION_LINKS.select do |_, info|
      auth.is_a?(Array) ? info[:auth].in?(auth) : info[:auth] == auth
    end
  end
end
