import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";
import { stringify } from "qs";
import { useAuthStore } from "@/storage/auth";

function getCollectableMaps(body) {
  const { token } = useAuthStore();
  const { url, method } = RailsRoutes.collectable_maps;

  return fetch(
    client(url(stringify({ collectable_map: body })), method, {
      authToken: token,
    }),
  );
}

export { getCollectableMaps };
