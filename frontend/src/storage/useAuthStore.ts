import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";

interface AuthTokenState {
  authToken: string | null;
  fullName: string | null;
  avatarUrl: string | null;
  setAuthToken: (
    newToken: string,
    newName: string,
    newAvatarUrl: string,
  ) => void;
  removeAuthToken: () => void;
}

const useAuthStore = create<AuthTokenState>()(
  persist(
    (set) => ({
      authToken: null,
      fullName: null,
      avatarUrl: null,
      removeAuthToken: () =>
        set({ authToken: null, fullName: null, avatarUrl: null }),
      setAuthToken: (newToken: string, newName: string, newAvatarUrl: string) =>
        set({
          authToken: newToken,
          fullName: newName,
          avatarUrl: newAvatarUrl,
        }),
    }),
    {
      name: "auth-storage",
      storage: createJSONStorage(() => localStorage),
    },
  ),
);

export default useAuthStore;
