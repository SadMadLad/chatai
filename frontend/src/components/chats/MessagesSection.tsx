import useAuthStore from "@/storage/useAuthStore";

import { Message as MessageType } from "@/types/data/ChatTypes";
import { ScrollArea } from "@/components/ui/ScrollArea";
import UserAvatar from "@/components/shared/UserAvatar";

function Message({
  content,
  sender,
  avatar_url,
  created_at,
  sender_username,
}: MessageType) {
  const { username } = useAuthStore();

  return (
    <div className="mb-4">
      {sender_username !== username ? (
        <div className="flex flex-row gap-2.5">
          <UserAvatar
            className="flex-shrink-0"
            avatarUrl={avatar_url ?? null}
            fullName={sender ?? null}
            hasPopover={false}
          />
          <div>
            <p className="rounded-lg border p-4 text-sm">{content}</p>
            <p className="text-xs text-gray-600">{created_at}</p>
          </div>
        </div>
      ) : (
        <div className="flex flex-row justify-end gap-2.5">
          <div>
            <p className="rounded-lg border bg-black p-4 text-sm text-white">
              {content}
            </p>
            <p className="text-right text-xs text-gray-600">{created_at}</p>
          </div>
          <UserAvatar
            className="flex-shrink-0"
            avatarUrl={avatar_url ?? null}
            fullName={sender ?? null}
            hasPopover={false}
          />
        </div>
      )}
    </div>
  );
}

export default function MessagesSection({
  messages,
}: {
  messages: MessageType[];
}) {
  return (
    <ScrollArea className="flex flex-col border-b p-8">
      {messages.map((message) => (
        <Message key={message.id} {...message} />
      ))}
    </ScrollArea>
  );
}
