import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
  Outlet,
} from "react-router-dom";
import { useEffect } from "react";

import StaticPage from "@/pages/static/StaticPage";
import LoginPage from "@/pages/auth/LoginPage";
import { Toaster } from "@/components/ui/Sonner";
import useAuthStore from "@/storage/useAuthStore";
import useSocketStore from "./storage/useSocketStore";
import usePresenceStore from "./storage/usePresenceStore";

/* PrivateRoutes: Routet that require user to auth. */
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
  const { authToken, fullName, verifySession } = useAuthStore();
  const { subscribeSocket, unsubscribeSocket } = useSocketStore();
  const { subscribeChannel, subscribePresence, unsubscribePresence } =
    usePresenceStore();

  const prepareSockets = async () => {
    const verifiedSession = await verifySession();
    if (!verifiedSession || !authToken || !fullName) return;

    subscribeSocket(authToken);
    subscribeChannel(fullName);
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
        <Route element={<PrivateRoutes />}></Route>
        <Route element={<PublicRoutes />}>
          <Route path="/login" element={<LoginPage />} />
        </Route>
        <Route path="/" element={<StaticPage />} />
      </Routes>
      <Toaster />
    </Router>
  );
}

export default App;
