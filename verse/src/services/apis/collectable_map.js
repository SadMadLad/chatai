import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";
import { stringify } from "qs";
import { useAuthStore } from "@/storage/auth";

function getCollectableMaps(body) {
  const { token } = useAuthStore();
  const { url, method } = RailsRoutes.collectableMaps;

  return fetch(
    client(url(stringify({ collectable_map: body })), method, {
      authToken: token,
    }),
  );
}

function createCollectableMap(body) {
  const { token } = useAuthStore();
  const { url, method } = RailsRoutes.createCollectableMap;

  return fetch(
    client(url(), method, {
      body: { collectable_map: body },
      authToken: token,
    }),
  );
}

function destroyCollectableMap(body) {
  const { token } = useAuthStore();
  const { url, method } = RailsRoutes.destroyCollectableMap;

  return fetch(
    client(url(), method, {
      body: { collectable_map: body },
      authToken: token,
    }),
  );
}

export { getCollectableMaps, createCollectableMap, destroyCollectableMap };
