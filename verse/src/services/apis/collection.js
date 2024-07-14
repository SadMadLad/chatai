import { RailsRoutes } from "@/services/routes";
import { useFetch } from "@/services/utils";

function getCollections() {
  const { url, method } = RailsRoutes.collections;

  return useFetch(url(), method);
}

function getCollection(id) {
  const { url, method } = RailsRoutes.collection;

  return useFetch(url(id), method);
}

export { getCollections, getCollection };
