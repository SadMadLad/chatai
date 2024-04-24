import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";

interface AuthTokenState {
  authToken: String | null;
  setAuthToken: (newToken: String) => void;
  removeAuthToken: () => void;
}

const useAuthStore = create<AuthTokenState>()(
  persist(
    (set) => ({
      authToken: null,
      setAuthToken: (newToken: String) => set({ authToken: newToken }),
      removeAuthToken: () => set({ authToken: null }),
    }),
    {
      name: "auth-storage",
      storage: createJSONStorage(() => sessionStorage),
    },
  ),
);

export { useAuthStore };
