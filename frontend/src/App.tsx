import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
  Outlet,
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

/* PublicRoutes: Routes that are for unauthed users only. Like the /login one. */
function PublicRoutes() {
  const { isAuthed } = useAuthStore();

  return !isAuthed ? <Outlet /> : <Navigate to="/" />;
}

function App() {
  const { authToken, fullName, avatarUrl, isAuthed, verifySession } =
    useAuthStore();
  const { subscribeSocket, unsubscribeSocket } = useSocketStore();
  const { subscribeChannel, subscribePresence, unsubscribePresence } =
    usePresenceStore();

  const prepareSockets = async (signal: AbortSignal): Promise<boolean> => {
    const verifiedSession = await verifySession(signal);
    if (!verifiedSession || !authToken || !fullName) return false;

    subscribeSocket(authToken);
    subscribeChannel(fullName, authToken, avatarUrl);
    subscribePresence();

    return verifiedSession;
  };

  const removeSockets = () => {
    unsubscribePresence();
    unsubscribeSocket();
  };

  useEffect(() => {
    const abortController = new AbortController();
    const signal = abortController.signal;

    prepareSockets(signal).then((isVerified) => {
      if (!isVerified) removeSockets();
    });

    return () => {
      removeSockets();
      abortController.abort();
    };
  }, [authToken, isAuthed]);

  return (
    <Router>
      <Routes>
        <Route element={<PrivateRoutes />}>
          <Route path="/chats" element={<ChatsPage />} />
          <Route path="/chats/:id" element={<ChatPage />} />
        </Route>
        <Route element={<PublicRoutes />}>
          <Route path="/login" element={<LoginPage />} />
        </Route>
        <Route path="/" element={<StaticPage />} />
        <Route
          path="/accounts/:username/public"
          element={<PublicAccountPage />}
        />
      </Routes>
      <Toaster />
    </Router>
  );
}

export default App;
