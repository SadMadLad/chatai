# frozen_string_literal: true

module ChatsHelper
  class ChatStyleBuilder
    attr_reader :account, :color

    def initialize(account, color: '#8b5cf6')
      @account = account
      @color = color
    end

    def build
      message_direction + message_color + message_text + message_ellipsis + message_alignment
    end

    private

    def message_direction
      ".msg-#{account.id} { flex-direction: row-reverse !important; }"
    end

    def message_color
      ".msg-color-#{account.id} { background-color: #{color} !important; }"
    end

    def message_text
      <<-TEXT
      .msg-text-#{account.id} {
        color: white !important;
        text-align: right !important;
      }
      TEXT
    end

    def message_ellipsis
      ".msg-ellipsis-#{account.id} { display: block !important; }"
    end

    def message_alignment
      <<-TEXT
      .created-at-alignment-#{account.id} {
        right: 0 !important;
        left: auto !important;
      }
      TEXT
    end
  end
end
