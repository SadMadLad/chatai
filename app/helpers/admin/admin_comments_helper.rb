# frozen_string_literal: true

module Admin
  # Admin Comments Helper for admin dashboard.
  module AdminCommentsHelper
    def admin_comment_form_options(model, method, **other_options)
      options = { model:, method:, url: [:admin, model] }
      options[:data] = { turbo_frame: 'admin_comments' } if method == :post
      options.deep_merge(other_options)
    end
  end
end
