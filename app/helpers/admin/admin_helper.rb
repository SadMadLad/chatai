# frozen_string_literal: true

module Admin
  module AdminHelper
    ADMIN_LINKS = {
      dashboard: 'fas fa-chart-line',
      users: 'fas fa-users',
      accounts: 'fas fa-user-circle',
      chats: 'fas fa-comments',
      messages: 'fas fa-envelope',
      account_chat_maps: 'fas fa-link',
      admin_comments: 'fas fa-comment-alt',
      ml_models: 'fa-solid fa-braille',
      prediction_params: 'fas fa-brain'
    }.freeze

    def dialog_frame(&block)
      attributes = {
        class: 'p-0 rounded-xl',
        data: {
          controller: 'dialog',
          dialog_target: 'dialog',
          action: 'click->dialog#removeDialog'
        }
      }

      turbo_frame_tag('dialog') do
        content_tag(:dialog, **attributes) do
          content_tag(:div, class: 'p-6', &block)
        end
      end
    end
  end
end
