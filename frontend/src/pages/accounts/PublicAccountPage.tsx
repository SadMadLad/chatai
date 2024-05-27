import { useState, useEffect } from "react";
import { useParams } from "react-router-dom";

import useAuthStore from "@/storage/useAuthStore";

import ApplicationLayout from "@/layouts/ApplicationLayout";
import AccountsHeaderSection from "@/components/accounts/AccountsHeaderSection";
import AccountChatsSection from "@/components/accounts/AccountChatsSection";
import ChatPageSkeleton from "@/components/skeletons/ChatPageSkeleton";

import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";
import { AccountData } from "@/types/data/UserTypes";
import { Chat, Message } from "@/types/data/ChatTypes";

export default function PublicAccountPage() {
  const { identifier } = useParams();
  const { authToken } = useAuthStore();

  const [accountData, setAccountData] = useState<AccountData | null>(null);
  const [isLoading, setIsLoading] = useState<boolean>(true);
  const [messages, setMessages] = useState<Message[]>([]);
  const [chats, setChats] = useState<Chat[]>([]);

  useEffect(() => {
    const abortController = new AbortController();
    const signal = abortController.signal;

    fetchPublicAccountDetails(signal);

    return () => {
      abortController.abort();
    };
  }, [identifier]);

  async function fetchPublicAccountDetails(signal: AbortSignal) {
    setIsLoading(true);

    const { method, url } = RailsRoutes.accounts;
    const response = await fetch(
      client(`${url}/${identifier}/public`, method, { authToken: authToken }),
      { signal },
    );

    if (response.ok) {
      const {
        account,
        messages,
        chats,
      }: { account: AccountData; messages: Message[]; chats: Chat[] } =
        await response.json();

      setAccountData(account);
      setMessages(messages);
      setChats(chats);
    }

    setIsLoading(false);
  }

  return (
    <ApplicationLayout>
      <>
        {isLoading && <ChatPageSkeleton />}
        {!isLoading && (
          <section className="container flex flex-col gap-8 py-12 md:flex-row">
            <AccountsHeaderSection accountData={accountData} />
            <AccountChatsSection chats={chats} messages={messages} />
          </section>
        )}
      </>
    </ApplicationLayout>
  );
}
