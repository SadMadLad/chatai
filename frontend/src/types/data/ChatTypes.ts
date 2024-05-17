export interface Chat {
  id: number;
  chat_title: string;
  chat_description: string;
  photo_url?: string;
  messages_count?: number;
}

export interface Message {
  id: number;
  content: string;
  created_at: string;
  sender: string;
  sender_identifier: string;
  avatar_url: string;
}
