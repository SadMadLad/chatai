# frozen_string_literal: true

module AccountsHelper
  def account_avatar(account, width_class: 'w-10', height_class: 'h-10', other_classes: '', other_options: {})
    tailwind_classes = <<-TAILWIND
        #{width_class} #{height_class} flex-center rounded-full
        flex-shrink-0 overflow-hidden text-white #{random_bg_color} #{other_classes}
    TAILWIND
    content_tag(:div, class: tailwind_classes, **other_options) do
      if account.avatar.attached?
        image_tag(account.avatar, class: 'w-full h-full object-cover')
      else
        content_tag(:b, account.initials, class: 'text-lg tracking-tighter')
      end
    end
  end
end
