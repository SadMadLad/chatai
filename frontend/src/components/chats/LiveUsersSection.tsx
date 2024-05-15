import { UserPresence } from "@/types/StoreTypes";

export default function LiveUsersSection({
  liveUsers,
}: {
  liveUsers: UserPresence[];
}) {
  return <>{liveUsers[0]}</>;
}
