import { useForm } from "react-hook-form";
import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { Channel, Presence } from "phoenix";
import { toast } from "sonner";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";

import useAuthStore from "@/storage/useAuthStore";
import useSocketStore from "@/storage/useSocketStore";

import ApplicationLayout from "@/layouts/ApplicationLayout";
import { Button } from "@/components/ui/Button";
import ChatHero from "@/components/chats/ChatHero";
import ChatPageSkeleton from "@/components/chats/ChatPageSkeleton";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormMessage,
} from "@/components/ui/Form";
import { Input } from "@/components/ui/Input";
import MessagesSection from "@/components/chats/MessagesSection";

import { Chat, Message } from "@/types/data/ChatTypes";
import { client } from "@/services/clients";
import MessageSchema from "@/schemas/MessageSchema";
import { RailsRoutes } from "@/services/routes";
import { UserPresence } from "@/types/StoreTypes";

export default function ChatPage() {
  const { authToken, fullName, avatarUrl } = useAuthStore();
  const { socket } = useSocketStore();

  const [chat, setChat] = useState<Chat | null>(null);
  const [chatChannel, setChatChannel] = useState<Channel | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [liveUsers, setLiveUsers] = useState<UserPresence[]>([]);
  const [messages, setMessages] = useState<Message[]>([]);

  const { id } = useParams();

  const defaultValues = { content: "" };
  const form = useForm<z.infer<typeof MessageSchema>>({
    resolver: zodResolver(MessageSchema),
    defaultValues: defaultValues,
  });

  useEffect(() => {
    if (!socket) return;
    const abortController = new AbortController();

    fetchChatAndMessages();

    const chatChannel = subscribeToSockets();

    return () => {
      abortController.abort();
      chatChannel?.leave();
      setChatChannel(null);
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
    setChatChannel(chatChannel);

    const chatPresence = new Presence(chatChannel);

    chatPresence.onSync(() => {
      const presentUsers = Object.values(
        chatPresence.list((_, { metas: [presentUser] }) => presentUser),
      ).filter((presentUser) => !!presentUser.unique_identifier);

      setLiveUsers(presentUsers);
    });

    chatChannel.on("create:message", (newMessage: Message) =>
      setMessages((prevMessages) => [...prevMessages, newMessage]),
    );

    chatChannel.join();
    return chatChannel;
  }

  async function handleSubmit(values: z.infer<typeof MessageSchema>) {
    try {
      if (!chatChannel) return;

      chatChannel.push("create:message", values);
      form.reset();
    } catch {
      toast("Something went wrong. Please try again later.");
    }
  }

  return (
    <ApplicationLayout>
      {isLoading && <ChatPageSkeleton />}
      {!isLoading &&
        (chat ? (
          <>
            <ChatHero chat={chat} liveUsers={liveUsers} />
            <MessagesSection messages={messages} />
            <br />
            <Form {...form}>
              <form onSubmit={form.handleSubmit(handleSubmit)}>
                <FormField
                  control={form.control}
                  name="content"
                  render={({ field }) => (
                    <FormItem>
                      <FormControl>
                        <Input placeholder="Send the message" {...field} />
                      </FormControl>
                      <FormMessage />
                    </FormItem>
                  )}
                />

                <Button type="submit" className="w-full">
                  Send
                </Button>
              </form>
            </Form>
          </>
        ) : (
          <>No Chat Found</>
        ))}
    </ApplicationLayout>
  );
}
