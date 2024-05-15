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
}

export default function UserAvatar({
  avatarUrl,
  fullName,
  hasPopover = true,
}: UserAvatarProps) {
  const [first, last] = (fullName ?? "").split(" ");

  function UserAvatarComponent() {
    return (
      <Avatar>
        {avatarUrl && <AvatarImage src={avatarUrl} />}
        <AvatarFallback>
          {first[0]}
          {last[0]}
        </AvatarFallback>
      </Avatar>
    );
  }

  return (
    <>
      {hasPopover && (
        <Popover>
          <PopoverTrigger asChild className="cursor-pointer">
            {UserAvatarComponent()}
          </PopoverTrigger>
          <PopoverContent className="inline p-2.5 text-sm">
            {first} {last}
          </PopoverContent>
        </Popover>
      )}
      {!hasPopover && UserAvatarComponent()}
    </>
  );
}
