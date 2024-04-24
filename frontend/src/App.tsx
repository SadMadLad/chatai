import StaticPage from "@/pages/static/StaticPage";
import LoginPage from "@/pages/auth/LoginPage";
import {
  BrowserRouter as Router,
  Routes,
  Route,
  Navigate,
  Outlet,
} from "react-router-dom";
import { Toaster } from "@/components/ui/Sonner";

import { useAuthStore } from "@/lib/stores";

function PrivateRoutes() {
  const { authToken } = useAuthStore();

  return authToken != null ? <Outlet /> : <Navigate to="/login" />;
}

function PublicRoutes() {
  const { authToken } = useAuthStore();

  return authToken == null ? <Outlet /> : <Navigate to="/" />;
}

function App() {
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
