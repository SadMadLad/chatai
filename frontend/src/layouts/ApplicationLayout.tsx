import NavBar from "@/components/shared/NavBar";
import Footer from "@/components/shared/Footer";
import { LayoutProps } from "@/types/LayoutTypes";

export default function ApplicationLayout({ children }: LayoutProps) {
  return (
    <>
      <NavBar />
      {children}
      <Footer />
    </>
  );
}
