const Rails = `${import.meta.env.VITE_RAILS_URL}/api/v1`;
const RailsRoutes = {
  login: { url: `${Rails}/sessions`, method: "POST" },
  logout: { url: `${Rails}/sessions`, method: "DELETE" },
  verifySession: {
    url: `${Rails}/sessions/verify_session`,
    method: "POST",
  },
  chats: { url: `${Rails}/chats`, method: "GET" },
};

const PhoenixSocket = import.meta.env.VITE_PHOENIX_SOCKET_URL;
const PhoenixRoutes = {
  socket: `${PhoenixSocket}/socket`,
};

const Fastapi = import.meta.env.VITE_FASTAPI_URL;

export { RailsRoutes, Fastapi, PhoenixRoutes };
