import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { Channel, Presence } from "phoenix";

import useAuthStore from "@/storage/useAuthStore";
import useSocketStore from "@/storage/useSocketStore";

import ApplicationLayout from "@/layouts/ApplicationLayout";
import ChatPageSkeleton from "@/components/chats/ChatPageSkeleton";
import UserAvatar from "@/components/shared/UserAvatar";
import { Skeleton } from "@/components/ui/Skeleton";

import { Chat, Message } from "@/types/data/ChatTypes";
import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";
import { UserPresence } from "@/types/StoreTypes";

export default function ChatPage() {
  const { authToken, fullName, avatarUrl } = useAuthStore();
  const { socket } = useSocketStore();

  const [chat, setChat] = useState<Chat | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [liveUsers, setLiveUsers] = useState<Array<UserPresence>>([]);
  const [messages, setMessages] = useState<Array<Message>>([]);

  const { id } = useParams();

  useEffect(() => {
    if (!socket) return;
    const abortController = new AbortController();

    let chatChannel: Channel | undefined = undefined;
    fetchChatAndMessages().then((success) => {
      if (success) chatChannel = subscribeToSockets();
    });

    return () => {
      abortController.abort();
      chatChannel?.leave();
    };
  }, [socket]);

  async function fetchChatAndMessages(): Promise<boolean> {
    const { method, url } = RailsRoutes.chats;
    const response = await fetch(
      client(`${url}/${id}`, method, { authToken: authToken }),
    );
    const { chat, messages } = await response.json();

    if (response.ok) {
      setChat(chat);
      setMessages(messages);
    }

    setIsLoading(false);
    return response.ok;
  }

  function subscribeToSockets() {
    if (!socket) return;

    const chatChannel = socket.channel(`chat:${id}`, {
      token: authToken,
      name: fullName,
      avatar_url: avatarUrl,
    });

    const chatPresence = new Presence(chatChannel);

    chatPresence.onSync(() => {
      const presentUsers = Object.values(
        chatPresence.list((_, { metas: [presentUser] }) => presentUser),
      ).filter((presentUser) => !!presentUser.unique_identifier);

      setLiveUsers(presentUsers);
    });

    chatChannel.join();
    return chatChannel;
  }

  return (
    <ApplicationLayout>
      {isLoading && <ChatPageSkeleton />}
      {!isLoading &&
        (chat ? (
          <section>
            <img
              src={chat.photo_url}
              className="h-20 w-20 rounded-full object-cover"
            />
            <h1 className="text-4xl font-black">{chat.chat_title}</h1>
          </section>
        ) : (
          <>No Chat Found</>
        ))}
    </ApplicationLayout>
  );
}
