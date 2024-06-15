import { RailsRoutes } from "@/services/routes";
import { requestHelper } from "@/services/utils";

function getQuiz(id) {
  const { url, method } = RailsRoutes.quiz;

  return requestHelper(url(id), method);
}

function getQuizzes() {
  const { url, method } = RailsRoutes.quizzes;

  return requestHelper(url(), method);
}

function getQuizUndertaking(id) {
  const { url, method } = RailsRoutes.quizUndertaking;

  return requestHelper(url(id), method);
}

export { getQuiz, getQuizzes, getQuizUndertaking };
