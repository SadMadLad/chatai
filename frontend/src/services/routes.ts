const Rails = `${import.meta.env.VITE_RAILS_URL}/api/v1`;
const RailsRoutes = {
  loginRoute: { url: `${Rails}/sessions`, method: "POST" },
  logoutRoute: { url: `${Rails}/sessions`, method: "DELETE" },
};

const PhoenixSocket = import.meta.env.VITE_PHOENIX_SOCKET_URL;
const PhoenixRoutes = {
  socket: `${PhoenixSocket}/socket`,
};

const Fastapi = import.meta.env.VITE_FASTAPI_URL;

export { RailsRoutes, Fastapi, PhoenixRoutes };
