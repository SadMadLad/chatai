import { create } from "zustand";
import { Presence, Channel } from "phoenix";
import useSocketStore from "@/storage/useSocketStore";
import { UserPresence } from "@/types/StoreTypes";

interface PresenceStoreState {
  presence: Presence | null;
  channel: Channel | null;
  onlineUsers: Array<UserPresence>;
  subscribeChannel: (
    fullName: string,
    token: string,
    avatarUrl: string | null,
  ) => void;
  subscribePresence: () => void;
  unsubscribePresence: () => void;
}

const usePresenceStore = create<PresenceStoreState>((set, get) => ({
  channel: null,
  presence: null,
  onlineUsers: [],

  subscribeChannel: (
    fullName: string,
    token: string,
    avatarUrl: string | null,
  ) => {
    const channelIsPresent = !!get().channel;
    if (channelIsPresent) return;
    const socket = useSocketStore.getState().socket;
    if (!socket) return;

    const newChannel = socket.channel("active:lobby", {
      name: fullName,
      token: token,
      avatar_url: avatarUrl,
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

      newPresence.list(
        (_, { metas: [presentUser, ...__] }: { metas: UserPresence[] }) =>
          presentUsers.unshift(presentUser),
      );
      presentUsers.filter((presentUser) => !!presentUser.unique_identifier);
      presentUsers = Object.values(
        presentUsers.reduce(
          (acc, obj) => ({ ...acc, [obj.unique_identifier]: obj }),
          {},
        ),
      );

      set({ onlineUsers: presentUsers });
    });

    set({ presence: newPresence });
  },

  unsubscribePresence: () => {
    const channel = get().channel;

    if (channel) {
      channel.leave();
      set({ channel: null, presence: null });
    }
    get().channel?.leave();
  },
}));

export default usePresenceStore;
