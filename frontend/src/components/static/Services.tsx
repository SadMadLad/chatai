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
      content: "Lorem ipsum dolor sit amet consectetur adipisicing elit.",
    },
    {
      icon: <AccessibilityIcon />,
      title: "Accessibility Icon",
      content: "Lorem ipsum dolor sit amet consectetur adipisicing elit.",
    },
    {
      icon: <AirVentIcon />,
      title: "Air Vent Icon",
      content:
        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Lorem ipsum dolor sit amet.",
    },
    {
      icon: <AlarmClockOffIcon />,
      title: "Alarm Clock Off Icon",
      content: "Lorem ipsum dolor sit amet consectetur adipisicing elit.",
    },
  ];

  return (
    <section className="flex flex-wrap bg-black pb-28 pt-24">
      <h3 className="mb-8 w-full text-center text-4xl font-black text-white">
        Our Service
      </h3>
      <div className="container flex flex-wrap justify-center gap-4 px-8">
        {cardsData.map((cardData) => (
          <Card
            key={cardData.title}
            className="flex w-72 flex-col justify-center"
          >
            <CardHeader className="flex items-center">
              <CardTitle>{cardData.icon}</CardTitle>
              <CardDescription className="text-lg">
                {cardData.title}
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-center">{cardData.content}</p>
            </CardContent>
          </Card>
        ))}
      </div>
    </section>
  );
}
