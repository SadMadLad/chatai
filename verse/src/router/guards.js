import useAuthStore from "@/storage/auth";

export default function isAuthed(_to, _from, next) {
  const { isAuthenticated } = useAuthStore();

  isAuthenticated ? next() : next("/login");
}
