import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";
import { useFetch } from "@/services/utils";
import { useAuthStore } from "@/storage/auth";

function getQuiz(id) {
  const { url, method } = RailsRoutes.quiz;

  return useFetch(url(id), method);
}

function getNewQuizUndertaking(id) {
  const { url, method } = RailsRoutes.newQuizUndertaking;

  return useFetch(url(id), method);
}

async function createQuizUndertaking(id, payload) {
  const { token } = useAuthStore();
  const { url, method } = RailsRoutes.createQuizUndertaking;

  const response = await fetch(
    client(url(id), method, { body: payload, authToken: token }),
  );

  return response;
}

export { getQuiz, getNewQuizUndertaking, createQuizUndertaking };
