import { Link } from "react-router-dom";
import { useNavigate } from "react-router-dom";

import { Button } from "@/components/ui/Button";
import { Input } from "@/components/ui/Input";
import {
  Form,
  FormControl,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/Form";
import { toast } from "sonner";

import { useForm } from "react-hook-form";
import loginSchema from "@/schemas/loginSchema";
import { z } from "zod";
import { zodResolver } from "@hookform/resolvers/zod";

import { loginRoute } from "@/services/routes";
import client from "@/services/client";

export default function LoginPage() {
  const navigate = useNavigate();
  const defaultValues = { email: "", password: "123456", scope: "ai_showcase" };
  const form = useForm<z.infer<typeof loginSchema>>({
    resolver: zodResolver(loginSchema),
    defaultValues: defaultValues,
  });

  async function onSubmit(values: z.infer<typeof loginSchema>) {
    try {
      const response = await fetch(
        client(
          loginRoute.url,
          loginRoute.method,
          { user: values },
        ),
      )
      const responseJson = await response.json();

      if(response.ok) {
        navigate('/')
      } else {
        toast(responseJson.error)
      }
    }
    catch (err) {
      toast('Something went wrong. Please try again later.')
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
            <form onSubmit={form.handleSubmit(onSubmit)} className="grid gap-4">
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
          <div className="mt-4 text-center text-sm">
            Don&apos;t have an account?{" "}
            <Link to="#" className="underline">
              Sign up
            </Link>
          </div>
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
