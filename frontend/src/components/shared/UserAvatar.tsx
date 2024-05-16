import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/Avatar";
import {
  Popover,
  PopoverTrigger,
  PopoverContent,
} from "@/components/ui/Popover";

interface UserAvatarProps {
  avatarUrl: string | null;
  fullName: string | null;
  hasPopover: boolean;
  className?: string;
}

export default function UserAvatar({
  avatarUrl,
  fullName,
  hasPopover,
  className,
}: UserAvatarProps) {
  const [first, last] = (fullName ?? "").split(" ");

  function UserAvatarComponent() {
    return (
      <div className={className}>
        <Avatar>
          {avatarUrl && <AvatarImage src={avatarUrl} />}
          <AvatarFallback>
            {first[0]}
            {last[0]}
          </AvatarFallback>
        </Avatar>
      </div>
    );
  }

  return (
    <>
      {hasPopover && (
        <Popover>
          <PopoverTrigger asChild className="cursor-pointer">
            {UserAvatarComponent()}
          </PopoverTrigger>
          <PopoverContent className="inline p-1.5 text-xs">
            {first} {last}
          </PopoverContent>
        </Popover>
      )}
      {!hasPopover && UserAvatarComponent()}
    </>
  );
}
