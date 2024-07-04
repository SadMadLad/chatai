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
  setAuthToken: (
    newToken: string,
    newName: string,
    newAvatarUrl: string,
    newUsername: string,
  ) => void;
  removeAuthToken: () => void;
}

const useAuthStore = create<AuthTokenState>()(
  persist(
    (set, get) => ({
      authToken: null,
      fullName: null,
      avatarUrl: null,
      username: null,
      isAuthed: false,
      setAuthToken: (
        newToken: string,
        newName: string,
        newAvatarUrl: string,
        newUsername: string,
      ) =>
        set({
          authToken: newToken,
          fullName: newName,
          avatarUrl: newAvatarUrl,
          username: newUsername,
          isAuthed: true,
        }),
      removeAuthToken: () =>
        set({
          authToken: null,
          fullName: null,
          avatarUrl: null,
          username: null,
          isAuthed: false,
        }),
    }),
    {
      name: "auth-storage",
      storage: createJSONStorage(() => localStorage),
    },
  ),
);

export default useAuthStore;
