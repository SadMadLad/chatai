import { Link, To, useNavigate } from "react-router-dom";
import { Key } from "react";

import useAuthStore from "@/storage/useAuthStore";
import usePresenceStore from "@/storage/usePresenceStore";
import useSocketStore from "@/storage/useSocketStore";

import ActiveUsersDrawer from "@/components/shared/ActiveUsersDrawer";
import { Button } from "@/components/ui/Button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/DropdownMenu";
import { Menu, Apple } from "lucide-react";
import { Sheet, SheetContent, SheetTrigger } from "@/components/ui/Sheet";
import { toast } from "sonner";
import UserAvatar from "@/components/shared/UserAvatar";

import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";

interface NavBarLink {
  text: String;
  to: To;
  key: Key;
}

export default function NavBar() {
  const { authToken, fullName, isAuthed, avatarUrl, removeAuthToken } =
    useAuthStore();
  const { unsubscribeSocket } = useSocketStore();
  const { unsubscribePresence } = usePresenceStore();

  const navigate = useNavigate();

  const authedLinks: Array<NavBarLink> = [
    {
      text: "Dashboard",
      to: "/",
      key: "Dashboard",
    },
    {
      text: "Chats",
      to: "/chats",
      key: "Chats",
    },
    {
      text: "Weather",
      to: "#",
      key: "Weather",
    },
  ];

  const handleLogout = async () => {
    const { url, method } = RailsRoutes.logout;
    const response = await fetch(client(url, method, { authToken: authToken }));

    if (response.ok) {
      removeAuthToken();
      unsubscribePresence();
      unsubscribeSocket();

      navigate("/");
    } else {
      const { error } = await response.json();
      toast(error || "Something went wrong. Please try again later");
    }
  };

  return (
    <header className="sticky top-0 z-50 flex h-16 items-center gap-4 border-b bg-white px-4 md:px-6">
      <nav className="hidden flex-col gap-6 text-lg font-medium md:flex md:flex-row md:items-center md:gap-5 md:text-sm lg:gap-6">
        <Link
          to="#"
          className="flex items-center gap-2 text-lg font-semibold md:text-base"
        >
          <Apple className="h-6 w-6" />
          <span className="sr-only">Acme Inc</span>
        </Link>
        <Link
          to="#"
          className="text-muted-foreground hover:text-foreground transition-colors"
        >
          Blog
        </Link>
        {isAuthed && (
          <>
            {authedLinks.map((link) => (
              <Link
                to={link.to}
                key={link.key}
                className="text-muted-foreground hover:text-foreground transition-colors"
              >
                {link.text}
              </Link>
            ))}
          </>
        )}
      </nav>
      <Sheet>
        <SheetTrigger asChild>
          <Button variant="outline" size="icon" className="shrink-0 md:hidden">
            <Menu className="h-5 w-5" />
            <span className="sr-only">Toggle navigation menu</span>
          </Button>
        </SheetTrigger>
        <SheetContent side="left">
          <nav className="grid gap-6 text-lg font-medium">
            <Link
              to="#"
              className="flex items-center gap-2 text-lg font-semibold"
            >
              <Apple className="h-6 w-6" />
              <span className="sr-only">Acme Inc</span>
            </Link>
            <Link
              to="#"
              className="text-muted-foreground hover:text-foreground"
            >
              Blog
            </Link>
            {isAuthed && (
              <>
                {authedLinks.map((link) => (
                  <Link
                    to={link.to}
                    key={link.key}
                    className="text-muted-foreground hover:text-foreground"
                  >
                    {link.text}
                  </Link>
                ))}
              </>
            )}
          </nav>
        </SheetContent>
      </Sheet>
      <div className="flex w-full items-center gap-4 md:ml-auto md:gap-2 lg:gap-4">
        <div className="ml-auto flex items-center">
          {isAuthed && (
            <>
              <ActiveUsersDrawer />
              <DropdownMenu>
                <DropdownMenuTrigger asChild>
                  <Button
                    variant="secondary"
                    size="icon"
                    className="rounded-full"
                  >
                    {isAuthed && (
                      <UserAvatar fullName={fullName} avatarUrl={avatarUrl} />
                    )}
                    <span className="sr-only">Toggle user menu</span>
                  </Button>
                </DropdownMenuTrigger>
                <DropdownMenuContent align="end">
                  <DropdownMenuLabel>{fullName}</DropdownMenuLabel>
                  <DropdownMenuSeparator />
                  <DropdownMenuItem>Settings</DropdownMenuItem>
                  <DropdownMenuItem>Support</DropdownMenuItem>
                  <DropdownMenuSeparator />
                  <DropdownMenuItem onClick={handleLogout}>
                    Logout
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </>
          )}
        </div>
      </div>
    </header>
  );
}
