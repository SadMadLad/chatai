import { useForm } from "react-hook-form";
import { useParams } from "react-router-dom";
import { useState, useEffect } from "react";
import { Channel, Presence } from "phoenix";
import { toast } from "sonner";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";
import useFetch from "@/hooks/useFetch";

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
import WentWrong from "@/pages/errors/WentWrong";

import { Chat, Message } from "@/types/data/ChatTypes";
import MessageSchema from "@/schemas/MessageSchema";
import { RailsRoutes } from "@/services/routes";
import { UserPresence } from "@/types/StoreTypes";

export default function ChatPage() {
  const { authToken, fullName, avatarUrl } = useAuthStore();
  const { socket } = useSocketStore();

  const [chatChannel, setChatChannel] = useState<Channel | null>(null);
  const [liveUsers, setLiveUsers] = useState<UserPresence[]>([]);
  const [chatMessages, setChatMessages] = useState<Message[]>([]);

  const { id } = useParams();
  const { method, url } = RailsRoutes.chats;
  const { fetchedData, isLoading, isSuccess } = useFetch(
    `${url}/${id}`,
    method,
  );

  const defaultValues = { content: "" };
  const form = useForm<z.infer<typeof MessageSchema>>({
    resolver: zodResolver(MessageSchema),
    defaultValues: defaultValues,
  });

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
      setChatMessages((prevMessages) => [...prevMessages, newMessage]),
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

  useEffect(() => {
    if (!socket) return;
    if (fetchedData && isSuccess) {
      const { messages }: { messages: Message[] } = fetchedData;
      setChatMessages(messages);
    }

    const chatChannel = subscribeToSockets();

    return () => {
      chatChannel?.leave();
      setChatChannel(null);
    };
  }, [fetchedData, socket]);

  if (isLoading)
    return (
      <ApplicationLayout>
        <ChatPageSkeleton />
      </ApplicationLayout>
    );

  if (isSuccess) {
    const { chat }: { chat: Chat } = fetchedData;

    return (
      <ApplicationLayout>
        <ChatHero chat={chat} liveUsers={liveUsers} />
        <MessagesSection messages={chatMessages} />
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
      </ApplicationLayout>
    );
  } else {
    return <WentWrong />;
  }
}
