import { RailsRoutes } from "@/services/routes";
import { useFetch } from "@/services/utils";

function getDashboardStatistics() {
  const { url, method } = RailsRoutes.dashboard;

  return useFetch(url(), method);
}

export { getDashboardStatistics };
