import { Link } from "react-router-dom";

import { Button } from "@/components/ui/Button";
import {
  Command,
  CommandInput,
  CommandEmpty,
  CommandGroup,
  CommandItem,
  CommandList,
} from "@/components/ui/Command";
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/Popover";
import UserAvatar from "@/components/shared/UserAvatar";

import { UserPresence } from "@/types/StoreTypes";

function LiveUserSearch({ liveUsers }: { liveUsers: UserPresence[] }) {
  return (
    <Popover>
      <PopoverTrigger asChild>
        <Button variant="secondary">Search Users</Button>
      </PopoverTrigger>
      <PopoverContent className="p-0" side="right">
        <Command>
          <CommandInput placeholder="Find Live User" />
          <CommandEmpty>No User Found</CommandEmpty>
          <CommandList>
            <CommandGroup>
              {liveUsers.map(({ username, name }) => (
                <CommandItem
                  key={username}
                  value={name}
                  onSelect={(u) => {
                    liveUsers.find((user) => u === user.name);
                  }}
                >
                  <Link to={`/accounts/${username}/public`}>{name}</Link>
                </CommandItem>
              ))}
            </CommandGroup>
          </CommandList>
        </Command>
      </PopoverContent>
    </Popover>
  );
}

export default function LiveUsers({
  liveUsers,
}: {
  liveUsers: UserPresence[];
}) {
  const n = 3;
  const firstNUsers = liveUsers.slice(0, n);
  const remainingUsersCount = liveUsers.length - n;

  return (
    <div className="flex flex-row items-center gap-8">
      <div className="group flex items-center gap-0 transition-all hover:gap-4">
        {firstNUsers.map(({ avatar_url, name, username }) => (
          <UserAvatar
            key={username}
            avatarUrl={avatar_url}
            fullName={name}
            hasPopover={true}
            className="-mr-4"
          />
        ))}{" "}
        {remainingUsersCount > 0 && (
          <span className="ml-5 transition-all group-hover:ml-3">
            + {remainingUsersCount}
          </span>
        )}
      </div>
      <div>
        {liveUsers.length > 0 && <LiveUserSearch liveUsers={liveUsers} />}
      </div>
    </div>
  );
}
