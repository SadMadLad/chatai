import { Button } from "@/components/ui/Button";

export default function Footer() {
  const helpTabs = ["Support", "Get Started", "Terms of Service", "Privacy of Policy"];
  const navigationTabs = ["About Us", "Settings", "Documentation", "Project", "Features"];

  return (
    <footer className="bg-black text-white pt-24">
      <div className="container">
        <div className="flex flex-col gap-8 md:flex-row justify-between">
          <div className="max-w-96">
            <h5 className="font-extrabold text-xl mb-2.5">Join the community</h5>
            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Culpa obcaecati praesentium nam a cumque fugiat!</p>
            <Button variant="outline" className="text-black mt-4">Join</Button>
          </div>
          <div className="flex flex-wrap gap-8">
            <div>
              <h5 className="font-extrabold text-xl mb-3">Need Help?</h5>
              <ul className="flex flex-col gap-1.5">
                {helpTabs.map(tab => <li key={tab}>{tab}</li>)}
              </ul>
            </div>
            <div>
              <h5 className="font-extrabold text-xl mb-3">Learn More</h5>
              <ul className="flex flex-col gap-1.5">
                {navigationTabs.map(tab => <li key={tab}>{tab}</li>)}
              </ul>
            </div>
            <div className="max-w-72">
              <h5 className="font-extrabold text-xl mb-3">Get In Touch</h5>
              <p>Moonshine St. 14/05 Light City, London, United Kingdom</p>
              <ul className="mt-2.5">
                <li>info@gmail.com</li>
                <li>0331-03310331-01</li>
              </ul>
            </div>
          </div>
        </div>

        <hr className="mt-20" />

        <div className="gap justify-between py-2.5">
          <span>2024 Chatai. All Rights Reserved</span>
        </div>
      </div>
    </footer>
  )
}
