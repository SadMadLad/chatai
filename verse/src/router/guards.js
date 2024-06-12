import { useAuthStore } from "@/storage/auth";

function privateRoute(_to, _from, next) {
  const { isAuthenticated } = useAuthStore();

  isAuthenticated ? next() : next("/login");
}

function publicOnlyRoute(_to, _from, next) {
  const { isAuthenticated } = useAuthStore();

  !isAuthenticated ? next() : next("/");
}

export { privateRoute, publicOnlyRoute };
