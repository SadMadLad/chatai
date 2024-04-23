import { create } from "zustand";

const useTokenStore = create((set) => ({
  token: null,
  setToken: (newToken: String) => set({ token: newToken }),
  removeToken: () => set({ token: null }),
}));

export { useTokenStore };
