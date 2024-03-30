import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/Card";
import {
  ActivityIcon,
  AccessibilityIcon,
  AirVentIcon,
  AlarmClockOffIcon,
} from "lucide-react";

export default function Services() {
  const cardsData = [
    {
      icon: <ActivityIcon />,
      title: "Activity Icon",
      content: "Lorem ipsum dolor sit amet consectetur adipisicing elit."
    },
    {
      icon: <AccessibilityIcon />,
      title: "Accessibility Icon",
      content: "Lorem ipsum dolor sit amet consectetur adipisicing elit."
    },
    {
      icon: <AirVentIcon />,
      title: "Air Vent Icon",
      content: "Lorem ipsum dolor sit amet consectetur adipisicing elit. Lorem ipsum dolor sit amet."
    },
    {
      icon: <AlarmClockOffIcon />,
      title: "Alarm Clock Off Icon",
      content: "Lorem ipsum dolor sit amet consectetur adipisicing elit."
    }
  ];

  return (
    <section className="bg-black flex flex-wrap pt-24 pb-28">
      <h3 className="text-white text-4xl font-black text-center mb-8 w-full">Our Service</h3>
      <div className="container px-8 flex flex-wrap gap-4 justify-center">
        {cardsData.map(cardData =>
          <Card key={cardData.title} className="w-72 flex flex-col justify-center">
            <CardHeader className="flex items-center">
              <CardTitle>{cardData.icon}</CardTitle>
              <CardDescription className="text-lg">{cardData.title}</CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-center">{cardData.content}</p>
            </CardContent>
          </Card>)}
      </div>
    </section>
  )
}
