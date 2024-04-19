import StaticPage from "@/pages/static/StaticPage";
import LoginPage from "@/pages/auth/LoginPage";
import { createBrowserRouter, RouterProvider } from "react-router-dom";

function App() {
  const routes = [
    { path: "/", element: <StaticPage /> },
    { path: "/login", element: <LoginPage /> },
  ];
  const router = createBrowserRouter(routes);

  return <RouterProvider router={router} />;
}

export default App;
