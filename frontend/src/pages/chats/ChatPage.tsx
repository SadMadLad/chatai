import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";

import ApplicationLayout from "@/layouts/ApplicationLayout";
import { RailsRoutes } from "@/services/routes";
import { Chat, Message } from "@/types/data/ChatTypes";
import { client } from "@/services/clients";
import useAuthStore from "@/storage/useAuthStore";
import { Skeleton } from "@/components/ui/Skeleton";

export default function ChatPage() {
  const { id } = useParams();
  const { authToken } = useAuthStore();
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [chat, setChat] = useState<Chat | null>(null);
  const [messages, setMessages] = useState<Array<Message>>([]);

  useEffect(() => {
    const abortController = new AbortController();
    fetchChatAndMessages();

    return () => abortController.abort();
  }, []);

  async function fetchChatAndMessages() {
    const { method, url } = RailsRoutes.chats;
    const response = await fetch(
      client(`${url}/${id}`, method, null, {
        Authorization: `Bearer ${authToken}`,
      }),
    );
    const { chat, messages } = await response.json();
    if (response.ok) {
      setIsLoading(false);
      setChat(chat);
      setMessages(messages);
    }
  }

  return (
    <ApplicationLayout>
      {!isLoading && chat ? (
        <>
          <p>
            {chat.id} {chat.title}
          </p>
          {messages.map((message) => (
            <p key={message.id} className="bg-orange-500">
              {message.content}
            </p>
          ))}
        </>
      ) : (
        <Skeleton className="h-20 w-40" />
      )}
    </ApplicationLayout>
  );
}
