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
    <div className="flex items-center gap-2.5 rounded-lg border p-4 shadow-sm">
      <UserAvatar fullName={name} avatarUrl={avatar_url} />
      <div>
        <p className="text-xl font-bold">{name}</p>
        <p className="text-sm text-gray-500">{username}</p>
      </div>
    </div>
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
                <UserCard key={onlineUser.unique_identifier} {...onlineUser} />
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
