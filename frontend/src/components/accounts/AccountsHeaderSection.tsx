import UserAvatar from "@/components/shared/UserAvatar";

import { AccountData } from "@/types/data/UserTypes";

export default function AccountsHeaderSection({ accountData } : { accountData: AccountData | null }) {
  if (!accountData) return null;

  const { active, avatar_url, name, tagline } = accountData;

  return <aside className="p-4 flex-shrink-0 rounded-lg shadow border flex flex-col gap-4">
    <b className="text-center">{name}</b>
    <div className="flex flex-col gap-2.5 items-center justify-center">
      <UserAvatar className="h-40 w-40" fullName={name} avatarUrl={avatar_url} />
      { active && <span className="text-green-500 border border-green-500 rounded-full px-2 py-1 text-xs">Currently Active</span>}
    </div>
    <p className="text-center">{tagline ? tagline : <i>No Description Yet</i>}</p>
  </aside>
}
