import { RailsRoutes } from "@/services/routes";
import { useFetch } from "@/services/utils";

function getFlashCards() {
  const { url, method } = RailsRoutes.flashCards;

  return useFetch(url(), method);
}

export { getFlashCards };
