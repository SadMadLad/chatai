const Rails = `${import.meta.env.VITE_RAILS_URL}/api/v1`;

// TODO: (Probably,) use qs.stringify() here instead of in other components
const RailsRoutes = {
  // Sessions
  login: { url: () => `${Rails}/sessions`, method: "POST" },

  // CollectableMaps
  collectableMaps: {
    url: (params) => `${Rails}/collectable_maps?${params}`,
    method: "GET",
  },
  createCollectableMap: {
    url: () => `${Rails}/collectable_maps`,
    method: "POST",
  },
  destroyCollectableMap: {
    url: () => `${Rails}/collectable_maps`,
    method: "DELETE",
  },

  // Dashboards

  // Collections
  collections: { url: () => `${Rails}/collections`, method: "GET" },
  collection: { url: (id) => `${Rails}/collections/${id}`, method: "GET" },

  // Favorites
  createFavorite: { url: () => `${Rails}/favorites`, method: "POST" },
  destroyFavorite: { url: () => `${Rails}/favorites`, method: "DELETE" },

  // Flash Card
  flashCards: { url: () => `${Rails}/flash_cards`, method: "GET" },

  // Quiz
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

  // Searches
  searches: {
    url: (params = null) => `${Rails}/searches?${params ? params : ""}`,
    method: "GET",
  },

  // Tags
  tags: { url: () => `${Rails}/tags`, method: "GET" },
};

export { RailsRoutes };
