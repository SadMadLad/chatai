import { Label } from "@/components/ui/Label";
import { Input } from "@/components/ui/Input";

export default function Newsletter() {
  return (
    <section className="flex items-center justify-center p-12 sm:p-20">
      <div className="container bg-black rounded-xl p-8 flex items-center justify-center">
        <form>
          <Label className="text-white font-bold text-xl mb-2">Subscribe to our Newsletter</Label>
          <div className="relative mt-2.5">
            <Input
              type="search"
              placeholder="Search products..."
              className="pl-8 sm:w-[300px] md:w-[200px] lg:w-[300px]"
            />
          </div>
        </form>
      </div>
    </section>
  )
}
