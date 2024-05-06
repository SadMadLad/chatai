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
    set({ socket: newSocket });
    get().socket?.connect();
  },
  unsubscribeSocket: () => get().socket?.disconnect(),
}));

export default useSocketStore;
