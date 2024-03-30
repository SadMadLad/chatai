import StaticPage from "@/pages/static/StaticPage";
import LoginPage from "./pages/auth/LoginPage";
import { BrowserRouter } from "react-router-dom";

function App() {

  return (
    <BrowserRouter>
      <StaticPage />
    </BrowserRouter>
  );
}

export default App;
