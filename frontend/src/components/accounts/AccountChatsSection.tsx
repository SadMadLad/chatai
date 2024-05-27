import { Link } from "react-router-dom";

import ChatPhoto from "@/components/chats/ChatPhoto";
import { Separator } from "@/components/ui/Separator";

import { Chat, Message } from "@/types/data/ChatTypes";

function ChatCard({ id, chat_title, photo_url }: Chat) {
  return (
    <Link
      className="flex flex-row items-center gap-2.5 rounded-lg border p-4"
      to={`/chats/${id}`}
    >
      <ChatPhoto
        className="h-12 w-12"
        chat_title={chat_title}
        photo_url={photo_url}
      />
      <b>{chat_title}</b>
    </Link>
  );
}

function MessageCard({ content, created_at, chat_title }: Message) {
  return (
    <div className="flex flex-col items-start gap-1 rounded-lg border p-4">
      <p className="max-w-full overflow-ellipsis">{content}</p>
      <p className="text-xs text-gray-500">
        {created_at} in {chat_title}
      </p>
    </div>
  );
}

export default function AccountChatsSection({
  chats,
  messages,
}: {
  chats: Chat[];
  messages: Message[];
}) {
  return (
    <div className="flex-grow rounded-lg border p-8 shadow">
      <section className="flex flex-col gap-2.5">
        <h4 className="text-xl font-bold">Chat Rooms User has joined</h4>
        <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
          {chats.map((chat) => (
            <ChatCard key={chat.id} {...chat} />
          ))}
        </div>
      </section>
      <Separator className="my-4" />
      <section className="flex flex-col gap-2.5">
        <h4 className="text-xl font-bold">Recent Messages</h4>
        <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
          {messages.map((message) => (
            <MessageCard key={message.id} {...message} />
          ))}
        </div>
      </section>
    </div>
  );
}
