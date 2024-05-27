import { cn } from "@/lib/utils";

interface ChatPhotoProps {
  chat_title: string;
  photo_url: string | undefined;
  className?: string;
}

export default function ChatPhoto({
  chat_title,
  photo_url,
  className,
}: ChatPhotoProps) {
  return (
    <>
      {photo_url ? (
        <img
          className={cn("h-20 w-20 rounded-lg object-cover", className)}
          src={photo_url}
        />
      ) : (
        <div
          className={cn(
            "h-20 w-20 rounded-lg bg-gray-50 object-cover",
            className,
          )}
        >
          {chat_title.substring(0, 3)}
        </div>
      )}
    </>
  );
}
