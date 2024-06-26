import { Link } from "react-router-dom";

import usePresenceStore from "@/storage/usePresenceStore";

import { Button } from "@/components/ui/Button";
import {
  Drawer,
  DrawerTrigger,
  DrawerContent,
  DrawerHeader,
  DrawerTitle,
  DrawerDescription,
  DrawerFooter,
  DrawerClose,
} from "@/components/ui/Drawer";
import { ScrollArea, ScrollBar } from "@/components/ui/ScrollArea";
import { UserPresence } from "@/types/StoreTypes";
import UserAvatar from "@/components/shared/UserAvatar";

function UserCard({ name, avatar_url, username }: UserPresence) {
  return (
    <DrawerClose asChild>
      <Link
        className="flex items-center gap-2.5 rounded-lg border p-4 shadow-sm"
        to={`/accounts/${username}/public`}
      >
        <UserAvatar fullName={name} avatarUrl={avatar_url} hasPopover={false} />
        <div>
          <p className="text-xl font-bold">{name}</p>
          <p className="text-sm text-gray-500">{username}</p>
        </div>
      </Link>
    </DrawerClose>
  );
}

export default function ActiveUsersDrawer() {
  const { onlineUsers } = usePresenceStore();

  return (
    <Drawer>
      <DrawerTrigger asChild>
        <Button variant="link">Active Users</Button>
      </DrawerTrigger>
      <DrawerContent>
        <section className="mx-auto w-full max-w-sm">
          <DrawerHeader>
            <DrawerTitle>Active Users</DrawerTitle>
            <DrawerDescription>
              These are the live users right now.
            </DrawerDescription>
          </DrawerHeader>
          <ScrollArea className="h-56">
            <div className="flex flex-col gap-4">
              {onlineUsers.map((onlineUser) => (
                <UserCard key={onlineUser.username} {...onlineUser} />
              ))}
            </div>
            <ScrollBar orientation="vertical" />
          </ScrollArea>
          <DrawerFooter className="mt-4">
            <DrawerClose asChild>
              <Button variant="outline">Close</Button>
            </DrawerClose>
          </DrawerFooter>
        </section>
      </DrawerContent>
    </Drawer>
  );
}
