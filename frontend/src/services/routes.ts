import { Method } from "@/types/UtilTypes";

interface Route {
  url: string;
  method: Method;
}

interface RailsRoutes {
  [key: string]: Route;
}

const Rails = `${import.meta.env.VITE_RAILS_URL}/api/v1`;
const RailsSignUpPath = `${import.meta.env.VITE_RAILS_URL}/users/sign_up`;
const RailsDashboardPath = `${import.meta.env.VITE_RAILS_URL}/dashboard`;

const RailsRoutes: RailsRoutes = {
  login: { url: `${Rails}/sessions`, method: "POST" },
  logout: { url: `${Rails}/sessions`, method: "DELETE" },
  verifySession: {
    url: `${Rails}/sessions/verify_session`,
    method: "POST",
  },
  chats: { url: `${Rails}/frontend/chats`, method: "GET" },
  accounts: { url: `${Rails}/frontend/accounts`, method: "GET" },
};

const PhoenixSocket = import.meta.env.VITE_PHOENIX_SOCKET_URL;
const PhoenixRoutes = {
  socket: `${PhoenixSocket}/socket`,
};

const Fastapi = import.meta.env.VITE_FASTAPI_URL;

export {
  RailsDashboardPath,
  RailsSignUpPath,
  RailsRoutes,
  Fastapi,
  PhoenixRoutes,
};
