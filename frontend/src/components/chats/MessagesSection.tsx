import { Message as MessageType } from "@/types/data/ChatTypes";

function Message({ content, sender }: MessageType) {
  return (
    <div className="bg-blue-200">
      {content} {sender}
    </div>
  );
}

export default function MessagesSection({
  messages,
}: {
  messages: MessageType[];
}) {
  return messages.map((message) => <Message key={message.id} {...message} />);
}
