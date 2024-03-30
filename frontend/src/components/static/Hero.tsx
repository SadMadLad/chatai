import { Button } from "@/components/ui/Button";

export default function Hero() {
  return (
    <section className="flex flex-col items-center justify-center px-4 py-32">
      <div className="flex max-w-3xl flex-col text-center">
        <h1 className="max-w-3xl px-4 text-3xl font-black leading-none drop-shadow md:text-5xl">
          The Best Coolest Stuff That You Will Ever See
        </h1>
        <p className="text-primary-800 mb-4 mt-8 text-lg md:text-xl">
          Lorem, ipsum dolor sit amet consectetur adipisicing elit. Voluptate
          totam ea rerum laboriosam ut quae vitae suscipit mollitia temporibus
          nobis.
        </p>
        <div className="flex items-center justify-center gap-2.5">
          <Button>Login</Button>
          <Button variant="ghost">Sign Up</Button>
        </div>
      </div>
    </section>
  );
}
