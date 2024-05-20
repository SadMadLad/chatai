import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
  Outlet,
  useParams,
} from "react-router-dom";
import { useEffect } from "react";

import { Toaster } from "@/components/ui/Sonner";
import StaticPage from "@/pages/static/StaticPage";
import useAuthStore from "@/storage/useAuthStore";
import useSocketStore from "@/storage/useSocketStore";
import usePresenceStore from "@/storage/usePresenceStore";

import ChatsPage from "@/pages/chats/ChatsPage";
import ChatPage from "@/pages/chats/ChatPage";
import LoginPage from "@/pages/auth/LoginPage";
import PublicAccountPage from "@/pages/accounts/PublicAccountPage";

/* PrivateRoutes: Routes that require user to auth. */
function PrivateRoutes() {
  const { isAuthed } = useAuthStore();

  return isAuthed ? <Outlet /> : <Navigate to="/login" />;
}

/* UserPrivateRoutes: Routes that are specific to the logged in user. */
function UserPrivateRoutes() {
  const { isAuthed, uniqueIdentifier } = useAuthStore();
  const { identifier } = useParams();

  return isAuthed && uniqueIdentifier === identifier ? (
    <Outlet />
  ) : (
    <Navigate to="/" />
  );
}

/* PublicRoutes: Routes that are for unauthed users only. Like the /login one. */
function PublicRoutes() {
  const { isAuthed } = useAuthStore();

  return !isAuthed ? <Outlet /> : <Navigate to="/" />;
}

/* AdminRoutes: Routes that for admins only. */
function AdminRoutes() {
  const { isAdmin } = useAuthStore();

  return isAdmin ? <Outlet /> : <Navigate to="/" />;
}

function App() {
  const { authToken, fullName, avatarUrl, verifySession } = useAuthStore();
  const { subscribeSocket, unsubscribeSocket } = useSocketStore();
  const { subscribeChannel, subscribePresence, unsubscribePresence } =
    usePresenceStore();

  const prepareSockets = async () => {
    const verifiedSession = await verifySession();
    if (!verifiedSession || !authToken || !fullName) return;

    subscribeSocket(authToken);
    subscribeChannel(fullName, authToken, avatarUrl);
    subscribePresence();
  };

  useEffect(() => {
    prepareSockets();

    return () => {
      unsubscribePresence();
      unsubscribeSocket();
    };
  }, []);

  return (
    <Router>
      <Routes>
        <Route element={<AdminRoutes />}></Route>
        <Route element={<PrivateRoutes />}>
          <Route path="/chats" element={<ChatsPage />} />
          <Route path="/chats/:id" element={<ChatPage />} />
          <Route
            path="/accounts/:identifier/public"
            element={<PublicAccountPage />}
          />
        </Route>
        <Route element={<PublicRoutes />}>
          <Route path="/login" element={<LoginPage />} />
        </Route>
        <Route path="/" element={<StaticPage />} />
        <Route element={<UserPrivateRoutes />}></Route>
      </Routes>
      <Toaster />
    </Router>
  );
}

export default App;
