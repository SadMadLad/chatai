import UserAvatar from "@/components/shared/UserAvatar";

import { AccountData } from "@/types/data/UserTypes";

export default function AccountsHeaderSection({
  accountData,
}: {
  accountData: AccountData | null;
}) {
  if (!accountData) return null;

  const { active, avatar_url, name, tagline } = accountData;

  return (
    <aside className="flex flex-shrink-0 flex-col gap-4 rounded-lg border p-4 shadow">
      <b className="text-center">{name}</b>
      <div className="flex flex-col items-center justify-center gap-2.5">
        <UserAvatar
          className="h-40 w-40"
          fullName={name}
          avatarUrl={avatar_url}
        />
        {active && (
          <span className="rounded-full border border-green-500 px-2 py-1 text-xs text-green-500">
            Currently Active
          </span>
        )}
      </div>
      <p className="text-center">
        {tagline ? tagline : <i>No Description Yet</i>}
      </p>
    </aside>
  );
}
