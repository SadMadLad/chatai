import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";
import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";

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
  verifySession: () => Promise<boolean>;
}

const useAuthStore = create<AuthTokenState>()(
  persist(
    (set, get) => ({
      authToken: null,
      fullName: null,
      avatarUrl: null,
      setAuthToken: (newToken: string, newName: string, newAvatarUrl: string) =>
        set({
          authToken: newToken,
          fullName: newName,
          avatarUrl: newAvatarUrl,
        }),
      removeAuthToken: () =>
        set({ authToken: null, fullName: null, avatarUrl: null }),
      verifySession: async () => {
        const token = get().authToken;
        if (!token) return false;

        const { method, url } = RailsRoutes.verifySessionRoute;
        const response = await fetch(client(url, method, null, { "Authorization": `Bearer ${token}` }));

        if (!response.ok) return false;

        const { full_name, avatar_url } = await response.json();
        set({ fullName: full_name, avatarUrl: avatar_url });
        
        return true;
      }
    }),
    {
      name: "auth-storage",
      storage: createJSONStorage(() => localStorage),
    },
  ),
);

export default useAuthStore;
