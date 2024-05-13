import { useEffect, useState } from "react";

import ApplicationLayout from "@/layouts/ApplicationLayout";
import useAuthStore from "@/storage/useAuthStore";
import { client } from "@/services/clients";
import { Chat } from "@/types/data/ChatTypes";
import { RailsRoutes } from "@/services/routes";
import { Skeleton } from "@/components/ui/Skeleton";

function ChatCard({ id, title, photo_url }: Chat) {
  return (
    <>
      {photo_url && <img src={photo_url} />}
      <p>
        {id} {title}
      </p>
    </>
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
    const response = await fetch(
      client(url, method, null, { Authorization: `Bearer ${authToken}` }),
    );
    const chats = await response.json();

    if (response.ok) {
      setChats(chats);
      setIsLoading(false);
    }
  }

  return (
    <ApplicationLayout>
      {!isLoading && chats.map((chat) => <ChatCard key={chat.id} {...chat} />)}
      {isLoading && <Skeleton className="h-10 w-10" />}
    </ApplicationLayout>
  );
}
