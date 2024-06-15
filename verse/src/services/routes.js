const Rails = `${import.meta.env.VITE_RAILS_URL}/api/v1`;

const RailsRoutes = {
  login: { url: `${Rails}/sessions`, method: "POST" },
  quizzes: { url: `${Rails}/quizzes`, method: "GET" },
};

export { RailsRoutes };
