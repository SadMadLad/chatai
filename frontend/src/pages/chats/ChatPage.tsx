import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { Presence } from "phoenix";

import useAuthStore from "@/storage/useAuthStore";
import useSocketStore from "@/storage/useSocketStore";

import ApplicationLayout from "@/layouts/ApplicationLayout";
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

    fetchChatAndMessages();
    const chatChannel = subscribeToSockets();

    return () => {
      abortController.abort();
      chatChannel?.leave();
    };
  }, [socket]);

  async function fetchChatAndMessages() {
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
      {liveUsers.map(({ avatar_url, name, unique_identifier }) => (
        <div key={unique_identifier}>
          <UserAvatar avatarUrl={avatar_url} fullName={name} />
        </div>
      ))}
      <hr />
      {!isLoading ? (
        chat ? (
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
          <p>Chat Not Found</p>
        )
      ) : (
        <Skeleton className="h-20 w-40" />
      )}
    </ApplicationLayout>
  );
}
