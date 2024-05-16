import { UserPresence } from "@/types/StoreTypes";
import UserAvatar from "@/components/shared/UserAvatar";

export default function LiveUsers({
  liveUsers,
}: {
  liveUsers: UserPresence[];
}) {
  const firstFiveUsers = liveUsers.slice(0, 5);
  const remainingUsersCount = liveUsers.length - 5;

  return (
    <div className="flex gap-0 transition-all hover:gap-4">
      {firstFiveUsers.map(({ avatar_url, name, unique_identifier }) => (
        <UserAvatar
          key={unique_identifier}
          avatarUrl={avatar_url}
          fullName={name}
          hasPopover={true}
          className="-mr-4"
        />
      ))} {remainingUsersCount > 0 && <span>+ ${remainingUsersCount}</span>}
    </div>
  );
}
