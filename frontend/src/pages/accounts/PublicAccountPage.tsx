import { useParams } from "react-router-dom";
import useFetch from "@/hooks/useFetch";

import ApplicationLayout from "@/layouts/ApplicationLayout";
import AccountChatsSection from "@/components/accounts/AccountChatsSection";
import AccountsHeaderSection from "@/components/accounts/AccountsHeaderSection";
import ChatPageSkeleton from "@/components/skeletons/ChatPageSkeleton";

import { RailsRoutes } from "@/services/routes";

export default function PublicAccountPage() {
  const { identifier } = useParams();

  const { method, url } = RailsRoutes.accounts;
  const [fetchedData, isLoading, isSuccess] = useFetch(
    `${url}/${identifier}/public`,
    method,
  );

  if (isLoading)
    return (
      <ApplicationLayout>
        <ChatPageSkeleton />
      </ApplicationLayout>
    );

  if (isSuccess && fetchedData) {
    const { account, chats, messages }: {
      account: AccountData;
      chats: Chat[];
      messages: Message[];
    } = fetchedData;

    return (
      <ApplicationLayout>
        <section className="container flex flex-col gap-8 py-12 md:flex-row">
          <AccountsHeaderSection accountData={account} />
          <AccountChatsSection chats={chats} messages={messages} />
        </section>
      </ApplicationLayout>
    );
  } else {
    <ApplicationLayout>
      Something Failed. Please try again later.
    </ApplicationLayout>;
  }
}
