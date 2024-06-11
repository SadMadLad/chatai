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
      comments: 'far fa-comment',
      likes: 'far fa-thumbs-up',
      messages: 'fas fa-envelope',
      ml_models: 'fa-solid fa-braille',
      posts: 'fas fa-mail-bulk',
      prediction_params: 'fas fa-brain',
      solid_queues: 'fas fa-user-md',
      subreddit_posts: 'fa-regular fa-envelope',
      subreddits: 'fa-brands fa-reddit',
      users: 'fas fa-users'
    }.freeze

    def spread_record(record, except: [])
      content_tag(:div) do
        record.attributes.except(*except).map do |attribute, value|
          content_tag(:div, "#{attribute}: #{value}")
        end.join.html_safe
      end
    end

    def table_cols(cols, class: '')
      common_cols = %w[created_at updated_at actions]

      cols.map! { |col| content_tag(:th, t(".#{col}"), class:) }
      (common_cols.map! { |col| content_tag(:th, t("admin.common_columns.#{col}"), class:) })

      (cols + common_cols).join
    end
  end
end
