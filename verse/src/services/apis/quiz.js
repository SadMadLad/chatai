import { RailsRoutes } from "@/services/routes";
import { requestHelper } from "@/services/utils";

function getQuiz(id) {
  const { url, method } = RailsRoutes.quizzes;

  return requestHelper(`${url}/${id}`, method);
}

function getQuizzes() {
  const { url, method } = RailsRoutes.quizzes;

  return requestHelper(url, method);
}

export { getQuiz, getQuizzes };
