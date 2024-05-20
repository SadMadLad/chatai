import { useParams } from "react-router-dom";

export default function PublicAccountPage() {
  const { identifier } = useParams();

  return <div>Visiting Public Account Page with Identifier {identifier}</div>;
}
