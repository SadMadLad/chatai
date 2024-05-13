import React, { useState, useEffect } from "react";
import { useParams } from "react-router-dom";
import { Presence, Channel } from "phoenix";

import ApplicationLayout from "@/layouts/ApplicationLayout";
import { RailsRoutes } from "@/services/routes";
import { Chat, Message } from "@/types/data/ChatTypes";
import { client } from "@/services/clients";
import { Skeleton } from "@/components/ui/Skeleton";
import { UserPresence } from "@/types/UserPresence";
import useAuthStore from "@/storage/useAuthStore";
import useSocketStore from "@/storage/useSocketStore";

export default function ChatPage() {
  const { id } = useParams();
  const { authToken, fullName, avatarUrl } = useAuthStore();
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [chat, setChat] = useState<Chat | null>(null);
  const [liveUsers, setLiveUsers] = useState<Array<UserPresence>>([]);
  const [messages, setMessages] = useState<Array<Message>>([]);
  const { socket } = useSocketStore();

  // Subscribe to sockets and fetch chat and messages
  useEffect(() => {
    if (!socket) return;

    const abortController = new AbortController();
    fetchChatAndMessages();
    subscribeToSockets();

    return () => {
      abortController.abort();
    };
  }, [socket]); // Ensure useEffect runs only when `socket` changes

  async function fetchChatAndMessages() {
    try {
      const { method, url } = RailsRoutes.chats;
      const response = await fetch(client(`${url}/${id}`, method, null, {
        Authorization: `Bearer ${authToken}`,
      }));
      const { chat, messages } = await response.json();
      if (response.ok) {
        setChat(chat);
        setMessages(messages);
      }
      setIsLoading(false);
    } catch (error) {
      console.error("Error fetching chat and messages:", error);
    }
  }

  function subscribeToSockets() {
    if (!socket) return;

    const chatChannel = socket.channel(`chat:${id}`, {
      token: authToken,
      name: fullName,
      avatar_url: avatarUrl
    });
    const chatPresence = new Presence(chatChannel);
    chatPresence.onSync(() => {
      const presentUsers = Object.values(
        chatPresence.list((_, { metas: [presentUser] }) => presentUser)
      ).filter((presentUser) => !!presentUser.unique_identifier);
      setLiveUsers(presentUsers);
    });

    chatChannel.join();
  }

  return (
    <ApplicationLayout>
      {liveUsers.map((liveUser) => (
        <div key={liveUser.unique_identifier}>
          {liveUser.avatar_url} {liveUser.name}
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
