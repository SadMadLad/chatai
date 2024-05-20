import LiveUsers from "@/components/chats/LiveUsers";

import { UserPresence } from "@/types/StoreTypes";
import { Chat } from "@/types/data/ChatTypes";

export default function ChatHero({
  chat,
  liveUsers,
}: {
  chat: Chat;
  liveUsers: UserPresence[];
}) {
  const { photo_url, chat_title, chat_description } = chat;

  return (
    <section className="container flex flex-col gap-6 bg-black py-16 text-white">
      <div className="flex items-center gap-4">
        {photo_url ? (
          <img src={photo_url} className="h-20 w-20 rounded-lg object-cover" />
        ) : (
          <div className="h-20 w-20 rounded-lg">
            {chat_title.substring(0, 2)}
          </div>
        )}
        <h1 className="text-4xl font-black">{chat_title}</h1>
      </div>
      <LiveUsers liveUsers={liveUsers} />
      <p>{chat_description}</p>
    </section>
  );
}
