import { useNavigate } from "react-router-dom";
import { useForm } from "react-hook-form";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";

import useAuthStore from "@/storage/useAuthStore";
import usePresenceStore from "@/storage/usePresenceStore";
import useSocketStore from "@/storage/useSocketStore";

import { Button } from "@/components/ui/Button";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/Form";
import { Input } from "@/components/ui/Input";
import { toast } from "sonner";

import { client } from "@/services/clients";
import LoginSchema from "@/schemas/LoginSchema";
import { RailsRoutes } from "@/services/routes";

export default function LoginPage() {
  const navigate = useNavigate();
  const defaultValues = { email: "", password: "123456", scope: "frontend" };
  const form = useForm<z.infer<typeof LoginSchema>>({
    resolver: zodResolver(LoginSchema),
    defaultValues: defaultValues,
  });

  const { setAuthToken } = useAuthStore();
  const { subscribeSocket } = useSocketStore();
  const { subscribePresence, subscribeChannel } = usePresenceStore();

  async function handleSubmit(values: z.infer<typeof LoginSchema>) {
    try {
      const { url, method } = RailsRoutes.login;
      const response = await fetch(
        client(url, method, { body: { user: values } }),
      );

      const { error, token, full_name, username, avatar_url } =
        await response.json();

      if (token) {
        setAuthToken(token, full_name, avatar_url, username);
        subscribeSocket(token);
        subscribeChannel(full_name, token, avatar_url);
        subscribePresence();

        navigate("/");
      } else {
        toast(error);
      }
    } catch (err) {
      toast("Something went wrong. Please try again later.");
    }
  }

  return (
    <div className="h-screen w-screen lg:grid lg:grid-cols-2">
      <main className="flex items-center justify-center py-12">
        <div className="mx-auto grid w-[350px] gap-6">
          <div className="grid gap-2 text-center">
            <h1 className="text-3xl font-bold">Login</h1>
            <p className="text-muted-foreground text-balance">
              Enter your email below to login to your account
            </p>
          </div>
          <Form {...form}>
            <form
              onSubmit={form.handleSubmit(handleSubmit)}
              className="grid gap-4"
            >
              <FormField
                control={form.control}
                name="email"
                render={({ field }) => (
                  <FormItem className="grid gap-2">
                    <FormLabel>Email</FormLabel>
                    <FormControl>
                      <Input placeholder="abc@example.com" {...field} />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <FormField
                control={form.control}
                name="password"
                render={({ field }) => (
                  <FormItem className="grid gap-2">
                    <FormLabel>Password</FormLabel>
                    <FormControl>
                      <Input
                        type="password"
                        placeholder="password"
                        {...field}
                      />
                    </FormControl>
                    <FormMessage />
                  </FormItem>
                )}
              />
              <Button type="submit" className="w-full">
                Login
              </Button>
            </form>
          </Form>
        </div>
      </main>
      <aside className="bg-muted hidden min-h-screen lg:block">
        <img
          className="h-full w-full object-cover"
          src="/loop.gif"
          alt="Dark Gif"
        />
      </aside>
    </div>
  );
}
