import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";

interface AuthTokenState {
  authToken: string | null;
  fullName: string | null;
  setAuthToken: (newToken: string, newName: string) => void;
  removeAuthToken: () => void;
}

const useAuthStore = create<AuthTokenState>()(
  persist(
    (set) => ({
      authToken: null,
      fullName: null,
      removeAuthToken: () => set({ authToken: null, fullName: null }),
      setAuthToken: (newToken: string, newName: string) =>
        set({ authToken: newToken, fullName: newName }),
    }),
    {
      name: "auth-storage",
      storage: createJSONStorage(() => sessionStorage),
    },
  ),
);

export { useAuthStore };
