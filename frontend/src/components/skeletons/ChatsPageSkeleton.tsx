import { Skeleton } from "@/components/ui/Skeleton";

export default function ChatsPageSkeleton() {
  const FiltersSkeleton = () => (
    <div className="flex flex-row justify-center gap-2.5">
      {[...Array(4)].map((_, i) => (
        <Skeleton className="h-20 w-60" key={i} />
      ))}
    </div>
  );

  const ChatCardSkeleton = () => (
    <div className="flex flex-col justify-center gap-4">
      {[...Array(4)].map((_, i) => (
        <Skeleton className="h-32 w-80" key={i} />
      ))}
    </div>
  );

  return (
    <section className="flex flex-col gap-8 p-8">
      <FiltersSkeleton />
      <ChatCardSkeleton />
    </section>
  );
}
