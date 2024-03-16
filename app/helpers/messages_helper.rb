# frozen_string_literal: true

module MessagesHelper
  def chat_tab_stream(account, chat_type: :two_person)
    "#{dom_id(account)}_chat_sidebar#{'_group' unless chat_type == :two_person}"
  end

  def chat_tab_id(chat)
    "#{dom_id(chat)}_tab"
  end
end
