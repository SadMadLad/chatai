import { useAuthStore } from "@/storage/auth";
import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";

async function createFavorite(body) {
  const { token } = useAuthStore();
  const { url, method } = RailsRoutes.createFavorite;

  return fetch(client(url(), method, { body: { favorite: body }, authToken: token }));
}

async function destroyFavorite(body) {
  const { token } = useAuthStore();
  const { url, method } = RailsRoutes.destroyFavorite;

  return fetch(client(url(), method, { body: { favorite: body }, authToken: token }));
}

export { createFavorite, destroyFavorite }

