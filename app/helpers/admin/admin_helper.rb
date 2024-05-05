# frozen_string_literal: true

module Admin
  # Admin Helper for Admin Dashboard.
  module AdminHelper
    ADMIN_LINKS = {
      dashboard: 'fas fa-chart-line',
      accounts: 'fas fa-user-circle',
      account_chat_maps: 'fas fa-link',
      admin_comments: 'fas fa-comment-alt',
      chats: 'fas fa-comments',
      messages: 'fas fa-envelope',
      ml_models: 'fa-solid fa-braille',
      prediction_params: 'fas fa-brain',
      users: 'fas fa-users',
      solid_queues: 'fas fa-users'
    }.freeze
  end

  def spread_record(record, except: [])
    content_tag(:div) do
      record.attributes.except(*except).map do |attribute, value|
        content_tag(:div, "#{attribute}: #{value}")
      end.join.html_safe
    end
  end
end
