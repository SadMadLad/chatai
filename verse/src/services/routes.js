const Rails = `${import.meta.env.VITE_RAILS_URL}/api/v1`;

const RailsRoutes = {
  login: { url: () => `${Rails}/sessions`, method: "POST" },

  quizzes: { url: () => `${Rails}/quizzes`, method: "GET" },
  quiz: { url: (id) => `${Rails}/quizzes/${id}`, method: "GET" },
  quizUndertaking: {
    url: (id) => `${Rails}/quizzes/${id}/undertaking`,
    method: "GET",
  },
};

export { RailsRoutes };
