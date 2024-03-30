import NavBar from "@/components/shared/NavBar";
import Footer from "@/components/static/Footer";
import Hero from "@/components/static/Hero";
import Services from "@/components/static/Services";
import Newsletter from "@/components/static/Newsletter";

export default function StaticPage() {
  return (
    <>
      <NavBar />
      <Hero />
      <Services />
      <Newsletter />
      <Footer />
    </>
  );
}
