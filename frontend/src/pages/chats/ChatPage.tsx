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
import ChatPageSkeleton from "@/components/skeletons/ChatPageSkeleton";
import { CornerDownLeft } from "lucide-react";
import { Form, FormControl, FormField, FormItem } from "@/components/ui/Form";
import { Label } from "@/components/ui/Label";
import MessagesSection from "@/components/chats/MessagesSection";
import { Textarea } from "@/components/ui/Textarea";

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
    const signal = abortController.signal;

    fetchChatAndMessages(signal);

    const chatChannel = subscribeToSockets();

    return () => {
      abortController.abort();
      chatChannel?.leave();
      setChatChannel(null);
      setMessages([]);
    };
  }, [socket]);

  async function fetchChatAndMessages(signal: AbortSignal): Promise<boolean> {
    const { method, url } = RailsRoutes.chats;
    const response = await fetch(
      client(`${url}/${id}`, method, { authToken: authToken }),
      { signal },
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

    chatChannel.on("create:message", (newMessage: Message) => {
      setMessages((prevMessages) => [...prevMessages, newMessage]);
    });

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
            <Form {...form}>
              <div className="p-8">
                <form
                  className="bg-background focus-within:ring-ring relative overflow-hidden rounded-lg border focus-within:ring-1"
                  onSubmit={form.handleSubmit(handleSubmit)}
                >
                  <Label htmlFor="message" className="sr-only">
                    Message
                  </Label>
                  <FormField
                    control={form.control}
                    name="content"
                    render={({ field }) => (
                      <FormItem>
                        <FormControl>
                          <Textarea
                            className="min-h-12 resize-none border-0 p-3 shadow-none focus-visible:ring-0"
                            id="message"
                            placeholder="Type your message here"
                            {...field}
                          />
                        </FormControl>
                      </FormItem>
                    )}
                  />
                  <div className="flex items-center p-3 pt-0">
                    <Button type="submit" size="sm" className="ml-auto gap-1.5">
                      Send Message
                      <CornerDownLeft className="size-3.5" />
                    </Button>
                  </div>
                </form>
              </div>
            </Form>
          </>
        ) : (
          <>No Chat Found</>
        ))}
    </ApplicationLayout>
  );
}
