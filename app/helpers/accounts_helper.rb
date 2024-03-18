# frozen_string_literal: true

module AccountsHelper
  def account_avatar(
    account, size_classes: 'w-10 h-10', display_classes: 'flex-center',
    text_size_class: 'text-lg', other_classes: '', other_options: {}
  )
    tailwind_classes = <<-TAILWIND
        #{size_classes} #{display_classes} rounded-full flex-shrink-0
        overflow-hidden text-white bg-primary-400 #{other_classes}
    TAILWIND
    content_tag(:div, class: tailwind_classes, **other_options) do
      if account.avatar.attached?
        image_tag(account.avatar.variant(:thumb), class: 'w-full h-full object-cover')
      else
        content_tag(:b, account.initials, class: "#{text_size_class} tracking-tighter")
      end
    end
  end
end
