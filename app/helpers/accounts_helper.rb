module AccountsHelper
  def account_avatar(account, width_class: 'w-10', height_class: 'h-10')
    content_tag(:div, class: "flex-shrink-0 #{width_class} #{height_class} rounded-full overflow-hidden flex-center text-white #{random_bg_color}") do
      if account.avatar.attached?
        image_tag(account.avatar, class: 'w-full h-full object-cover')
      else
        content_tag(:b, account.initials, class: 'text-lg tracking-tighter')
      end
    end
  end
end
