import { useParams } from "react-router-dom";

export default function PublicAccountPage() {
  const { uniqueIdentifier } = useParams();

  return (
    <div>Visiting Unique Identifier {uniqueIdentifier}</div>
  )
}
