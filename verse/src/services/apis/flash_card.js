import { RailsRoutes } from "@/services/routes";
import { useFetch } from "@/services/utils";

function getFlashCards() {
  const { url, method } = RailsRoutes.flash_cards;

  return useFetch(url(), method);
}

export { getFlashCards };
