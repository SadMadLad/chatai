import { Presence, Channel } from "phoenix";
import { create } from "zustand";
import useSocketStore from "@/storage/useSocketStore";

interface PresenceStoreState {
  presence: Presence | null;
  channel: Channel | null;
  subscribeChannel: (fullName: string) => void;
  subscribePresence: () => void;
  unsubscribePresence: () => void;
}

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

export default usePresenceStore;
