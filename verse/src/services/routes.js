const Rails = `${import.meta.env.VITE_RAILS_URL}/api/v1`;

const RailsRoutes = {
  // Sessions Routes
  login: { url: () => `${Rails}/sessions`, method: "POST" },

  // Flash Card Routes
  flash_cards: { url: () => `${Rails}/flash_cards`, method: "GET" },

  // Quiz Routes
  quizzes: {
    url: (params = null) => `${Rails}/quizzes?${params ? params : ""}`,
    method: "GET",
  },
  quiz: { url: (id) => `${Rails}/quizzes/${id}`, method: "GET" },
  newQuizUndertaking: {
    url: (id) => `${Rails}/quizzes/${id}/quiz_undertakings/new`,
    method: "GET",
  },
  createQuizUndertaking: {
    url: (id) => `${Rails}/quizzes/${id}/quiz_undertakings`,
    method: "POST",
  },

  // Tags Routes
  tags: { url: () => `${Rails}/tags`, method: "GET" },
};

export { RailsRoutes };
