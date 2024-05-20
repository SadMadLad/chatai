import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";
import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";

interface AuthTokenState {
  authToken: string | null;
  fullName: string | null;
  avatarUrl: string | null;
  uniqueIdentifier: string | null;
  isAuthed: boolean;
  setAuthToken: (
    newToken: string,
    newName: string,
    newAvatarUrl: string,
    newUniqueIdentifier: string,
  ) => void;
  removeAuthToken: () => void;
  verifySession: () => Promise<boolean>;
}

const useAuthStore = create<AuthTokenState>()(
  persist(
    (set, get) => ({
      authToken: null,
      fullName: null,
      avatarUrl: null,
      uniqueIdentifier: null,
      isAuthed: false,
      setAuthToken: (
        newToken: string,
        newName: string,
        newAvatarUrl: string,
        newUniqueIdentifier: string,
      ) =>
        set({
          authToken: newToken,
          fullName: newName,
          avatarUrl: newAvatarUrl,
          uniqueIdentifier: newUniqueIdentifier,
          isAuthed: true,
        }),
      removeAuthToken: () =>
        set({
          authToken: null,
          fullName: null,
          avatarUrl: null,
          uniqueIdentifier: null,
          isAuthed: false,
        }),
      verifySession: async () => {
        const token = get().authToken;
        if (!token) return false;

        const { method, url } = RailsRoutes.verifySession;
        const response = await fetch(client(url, method, { authToken: token }));

        if (!response.ok) {
          get().removeAuthToken();
        } else {
          const { full_name, avatar_url, unique_identifier } =
            await response.json();

          set({
            fullName: full_name,
            avatarUrl: avatar_url,
            uniqueIdentifier: unique_identifier,
            isAuthed: true,
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
