import { Skeleton } from "@/components/ui/Skeleton";

export default function ChatPageSkeleton() {
  const AvatarSkeleton = () => <Skeleton className="h-10 w-10 rounded-full" />;
  const MessageSkeleton = () => <Skeleton className="h-16 w-80" />;

  return (
    <div className="flex flex-col gap-6 p-4">
      <Skeleton className="h-24 w-96" />
      <div className="flex flex-row gap-1">
        {[...Array(5)].map((_, i) => (
          <AvatarSkeleton key={i} />
        ))}
      </div>
      <Skeleton className="h-32 w-60" />
      <div className="flex flex-col gap-2.5">
        {[...Array(4)].map((_, i) => (
          <MessageSkeleton key={i} />
        ))}
      </div>
    </div>
  );
}
