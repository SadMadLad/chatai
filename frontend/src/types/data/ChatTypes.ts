export interface Chat {
  id: number;
  title: string;
  photo_url: string;
}

export interface Message {
  id: number;
  content: string;
  created_at: string;
  sender: string;
}
