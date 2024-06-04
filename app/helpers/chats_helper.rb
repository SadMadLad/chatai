# frozen_string_literal: true

# Module for rendering chats.
module ChatsHelper
  # The ChatStyleBuilder is render the inline styling for the chat and its messages styling.
  class ChatStyleBuilder
    class << self
      def build(account, color: '#0ea5e9')
        message_direction(account) +
          message_color(account, color) +
          message_text(account) +
          message_ellipsis(account) +
          message_alignment(account)
      end

      def message_direction(account)
        ".msg-#{account.id} { flex-direction: row-reverse !important; }"
      end

      def message_color(account, color)
        ".msg-color-#{account.id} { background-color: #{color} !important; }"
      end

      def message_text(account)
        <<-TEXT
        .msg-text-#{account.id} {
          color: white !important;
          text-align: right !important;
        }
        TEXT
      end

      def message_ellipsis(account)
        ".msg-ellipsis-#{account.id} { display: block !important; }"
      end

      def message_alignment(account)
        <<-TEXT
        .created-at-alignment-#{account.id} {
          right: 0 !important;
          left: auto !important;
        }
        TEXT
      end
    end
  end
end
