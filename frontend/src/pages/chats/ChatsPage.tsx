import { useEffect, useState } from "react";
import { Link } from "react-router-dom";

import useAuthStore from "@/storage/useAuthStore";
import ApplicationLayout from "@/layouts/ApplicationLayout";
import ChatsPageSkeleton from "@/components/chats/ChatsPageSkeleton";

import { client } from "@/services/clients";
import { Chat } from "@/types/data/ChatTypes";
import { RailsRoutes } from "@/services/routes";

function ChatCard({ id, chat_title, chat_description, photo_url }: Chat) {
  return (
    <Link to={`${id}`}>
      <div className="flex gap-2.5 rounded-lg border p-5">
        {photo_url ? (
          <img className="h-16 w-16 rounded-lg object-cover" src={photo_url} />
        ) : (
          <div className="flex-center h-16 w-16 rounded-lg bg-gray-100">
            {chat_title.substring(0, 2)}
          </div>
        )}
        <div>
          <h6 className="font-bold">{chat_title}</h6>
          <hr className="my-2" />
          <p>{chat_description}</p>
        </div>
      </div>
    </Link>
  );
}

export default function ChatsPage() {
  const { authToken } = useAuthStore();

  const [chats, setChats] = useState<Array<Chat>>([]);
  const [isLoading, setIsLoading] = useState<boolean>(true);

  useEffect(() => {
    const abortController = new AbortController();
    fetchChats();

    return () => abortController.abort();
  }, []);

  async function fetchChats() {
    const { url, method } = RailsRoutes.chats;
    const response = await fetch(client(url, method, { authToken: authToken }));
    const chats = await response.json();

    if (response.ok) setChats(chats);
    setIsLoading(false);
  }

  return (
    <ApplicationLayout>
      <h1 className="pb-12 pt-20 text-center text-3xl font-black md:text-5xl">
        Visit all the Cool Chat Rooms
      </h1>
      {!isLoading && (
        <section className="flex flex-row flex-wrap justify-center gap-6 pb-12">
          {chats.map((chat) => (
            <ChatCard key={chat.id} {...chat} />
          ))}
        </section>
      )}
      {isLoading && <ChatsPageSkeleton />}
    </ApplicationLayout>
  );
}
