import { Presence, Channel } from "phoenix";
import { create } from "zustand";
import useSocketStore from "@/storage/useSocketStore";

interface UserPresence {
  id: number,
  name: string,
  phx_ref: string,
  online_at: string
}

interface PresenceStoreState {
  presence: Presence | null;
  channel: Channel | null;
  onlineUsers: Array<UserPresence>;
  subscribeChannel: (fullName: string, token: string) => void;
  subscribePresence: () => void;
  unsubscribePresence: () => void;
}

const usePresenceStore = create<PresenceStoreState>((set, get) => ({
  channel: null,
  presence: null,
  onlineUsers: [],

  subscribeChannel: (fullName: string, token: string) => {
    const channelIsPresent = !!get().channel;
    if(channelIsPresent) return;

    const socket = useSocketStore.getState().socket;
    if (!socket) return;

    const newChannel = socket.channel("active:lobby", {
      name: fullName,
      token: token,
    });
    newChannel.join();

    set({ channel: newChannel });
  },

  subscribePresence: () => {
    const presenceIsPresent = !!get().presence;
    if (presenceIsPresent) return;
    const presenceChannel = get().channel;
    if (!presenceChannel) return;

    const newPresence = new Presence(presenceChannel);

    newPresence.onSync(() => {
      let presentUsers: Array<UserPresence> = [];

      newPresence.list((_, { metas: [presentUser, ...__] }: { metas: UserPresence[] }) => presentUsers.unshift(presentUser));
      presentUsers.filter(presentUser => !!presentUser.id);
      presentUsers = Object.values(presentUsers.reduce((acc, obj) => ({ ...acc, [obj.id]: obj }), {}));
      
      set({ onlineUsers: presentUsers })
    });

    set({ presence: newPresence });
  },

  unsubscribePresence: () => {
    const channel = get().channel;

    if (channel) {
      channel.leave();
      set({ channel: null, presence: null })
    }
    get().channel?.leave();
  } ,
}));

export default usePresenceStore;
