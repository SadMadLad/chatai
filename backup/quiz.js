import { client } from "@/services/clients";
import { RailsRoutes } from "@/services/routes";
import { requestHelper } from "@/services/utils";
import { useAuthStore } from "@/storage/auth";

function getQuiz(id) {
  const { url, method } = RailsRoutes.quiz;

  return requestHelper(url(id), method);
}

function getQuizzes() {
  const { url, method } = RailsRoutes.quizzes;

  return requestHelper(url(), method);
}

async function getNewQuizUndertaking(id) {
  const { token } = useAuthStore();
  const { url, method } = RailsRoutes.newQuizUndertaking;

  const response = await fetch(client(url(id), method), { authToken: token });
  const { quiz } = await response.json();

  return { response, quiz: quiz, questions: quiz.questions, timer: quiz.timer };
}

async function createQuizUndertaking(id, payload) {
  const { token } = useAuthStore();
  const { url, method } = RailsRoutes.createQuizUndertaking;

  const response = await fetch(
    client(url(id), method, { body: payload, authToken: token }),
  );

  return response;
}

export { getQuiz, getQuizzes, getNewQuizUndertaking, createQuizUndertaking };
