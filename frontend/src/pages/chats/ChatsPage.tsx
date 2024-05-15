import { useEffect, useState } from "react";
import { Link } from "react-router-dom";

import useAuthStore from "@/storage/useAuthStore";
import ApplicationLayout from "@/layouts/ApplicationLayout";
import { Skeleton } from "@/components/ui/Skeleton";

import { client } from "@/services/clients";
import { Chat } from "@/types/data/ChatTypes";
import { RailsRoutes } from "@/services/routes";

function ChatCard({ id, chat_title, photo_url }: Chat) {
  return (
    <Link to={`${id}`}>
      {photo_url && <img src={photo_url} />}
      <p>
        {id} {chat_title}
      </p>
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
      {!isLoading && chats.map((chat) => <ChatCard key={chat.id} {...chat} />)}
      {isLoading && <Skeleton className="h-10 w-10" />}
    </ApplicationLayout>
  );
}
