import { Socket } from "phoenix";
import { create } from "zustand";
import { PhoenixRoutes } from "@/services/routes";

interface SocketStoreState {
  socket: Socket | null;
  subscribeSocket: (token: string) => void;
  unsubscribeSocket: () => void;
}

const useSocketStore = create<SocketStoreState>((set, get) => ({
  socket: null,
  subscribeSocket: (token: string) => {
    const newSocket = new Socket(PhoenixRoutes.socket, {
      params: { token: token },
    });
    newSocket.connect();
    set({ socket: newSocket });
  },
  unsubscribeSocket: () => {
    const socket = get().socket;

    if (socket) {
      socket.disconnect();
      set({ socket: null });
    }
  },
}));

export default useSocketStore;
