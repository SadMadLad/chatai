import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";
import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";

interface AuthTokenState {
  authToken: string | null;
  fullName: string | null;
  avatarUrl: string | null;
  username: string | null;
  isAuthed: boolean;
  isAdmin: boolean | null;
  setAuthToken: (
    newToken: string,
    newName: string,
    newAvatarUrl: string,
    newUsername: string,
    newIsAdmin: boolean,
  ) => void;
  removeAuthToken: () => void;
  verifySession: (signal: AbortSignal) => Promise<boolean>;
}

const useAuthStore = create<AuthTokenState>()(
  persist(
    (set, get) => ({
      authToken: null,
      fullName: null,
      avatarUrl: null,
      username: null,
      isAuthed: false,
      isAdmin: false,
      setAuthToken: (
        newToken: string,
        newName: string,
        newAvatarUrl: string,
        newUsername: string,
        newIsAdmin: boolean,
      ) =>
        set({
          authToken: newToken,
          fullName: newName,
          avatarUrl: newAvatarUrl,
          username: newUsername,
          isAuthed: true,
          isAdmin: newIsAdmin,
        }),
      removeAuthToken: () =>
        set({
          authToken: null,
          fullName: null,
          avatarUrl: null,
          username: null,
          isAuthed: false,
          isAdmin: null,
        }),
      verifySession: async (signal: AbortSignal) => {
        const token = get().authToken;
        if (!token) return false;

        const { method, url } = RailsRoutes.verifySession;
        const response = await fetch(
          client(url, method, { authToken: token }),
          { signal },
        );

        if (!response.ok) {
          get().removeAuthToken();
        } else {
          const { full_name, avatar_url, username, is_admin } =
            await response.json();

          set({
            fullName: full_name,
            avatarUrl: avatar_url,
            username: username,
            isAuthed: true,
            isAdmin: is_admin,
          });
        }

        return response.ok;
      },
    }),
    {
      name: "auth-storage",
      storage: createJSONStorage(() => localStorage),
    },
  ),
);

export default useAuthStore;
