import { create } from "zustand";
import { persist, createJSONStorage } from "zustand/middleware";
import { Socket, Presence, Channel } from "phoenix";

import { PhoenixRoutes } from "@/services/routes";

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

interface SocketStoreState {
  socket: Socket | null;
  subscribeSocket: (token: string) => void;
  unsubscribeSocket: () => void;
}

interface PresenceStoreState {
  presence: Presence | null;
  channel: Channel | null;
  subscribeChannel: (fullName: string) => void;
  subscribePresence: () => void;
  unsubscribePresence: () => void;
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

const useSocketStore = create<SocketStoreState>((set, get) => ({
  socket: null,
  subscribeSocket: (token: string) => {
    const newSocket = new Socket(PhoenixRoutes.socket, {
      params: { token: token },
    });
    set({ socket: newSocket });
    get().socket?.connect();
  },
  unsubscribeSocket: () => get().socket?.disconnect(),
}));

const usePresenceStore = create<PresenceStoreState>((set, get) => ({
  channel: null,
  presence: null,
  subscribeChannel: (fullName: string) => {
    const socket = useSocketStore.getState().socket;
    if (!socket) return;

    const newChannel = socket.channel("active:lobby", { name: fullName });
    newChannel.join();

    set({ channel: newChannel });
  },
  subscribePresence: () => {
    const presenceChannel = get().channel;
    if (!presenceChannel) return;

    const newPresence = new Presence(presenceChannel);

    newPresence.onSync(() => {
      let response = "";

      newPresence.list((id, { metas: [_first, ...rest] }) => {
        console.log("First: ", _first);
        console.log("Rest: ", rest);
        console.log("Id:", id);

        let count = rest.length + 1;
        response += `<br>${id} (count: ${count})</br>`;

        console.log(response);
      });
    });

    set({ presence: newPresence });
  },
  unsubscribePresence: () => get().channel?.leave()
}))

export { useAuthStore, useSocketStore, usePresenceStore };
