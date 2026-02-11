import axios from "axios";

export default axios.create({
  baseURL: "http://eos-gateway-api-service.eos-dev.svc.cluster.local:5555",
});
