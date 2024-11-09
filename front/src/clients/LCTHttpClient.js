import axios from "axios";

export default () => {
  const baseUrl = "https://lct-api.kovalev.team/api/";

  return axios.create({
    baseURL: baseUrl,
    headers: {
      "Content-Type": "application/json",
    },
  });
};
