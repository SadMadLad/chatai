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

function getNewQuizUndertaking(id) {
  const { url, method } = RailsRoutes.newQuizUndertaking;

  return requestHelper(url(id), method);
}

function createQuizUndertaking(id, payload) {
  const { url, method } = RailsRoutes.createQuizUndertaking;

return requestHelper(url(id), method, { body: payload })
}


export { getQuiz, getQuizzes, getNewQuizUndertaking, createQuizUndertaking };
