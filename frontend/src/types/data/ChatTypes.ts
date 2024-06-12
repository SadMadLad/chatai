export interface Chat {
  id: number;
  chat_title: string;
  chat_description: string;
  photo_url?: string;
}

export interface Message {
  id: number;
  content: string;
  created_at: string;
  sender?: string;
  sender_username?: string;
  avatar_url?: string;
  chat_title?: string;
}
