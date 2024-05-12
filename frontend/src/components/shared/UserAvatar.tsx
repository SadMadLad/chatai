import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/Avatar";

interface UserAvatarProps {
  avatarUrl: string | null;
  fullName: string | null;
}

export default function UserAvatar({ avatarUrl, fullName }: UserAvatarProps) {
  const [first, last] = (fullName ?? "").split(" ");

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
