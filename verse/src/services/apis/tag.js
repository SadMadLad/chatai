import { RailsRoutes } from "@/services/routes";
import { useFetch } from "@/services/utils";

function getTags() {
  const { url, method } = RailsRoutes.tags;

  return useFetch(url(), method);
}

export { getTags };
