import httpClient from "../clients/LCTHttpClient";

export default class AuthorArticleService {
  static async getMachines(time_machine_offset = null) {
    let params;
    if (time_machine_offset) {
      params = new URLSearchParams([["batch_time", time_machine_offset]]);
    }
    const response = await httpClient()
      .get("sinter_machines", { params })
      .catch((err) => {
        return err;
      });
    return response.data;
  }

  static async getExhauserStatById(id, time_machine_offset = null) {
    if (time_machine_offset) {
      params = new URLSearchParams([["batch_time", time_machine_offset]]);
    }
    if (id) {
      const response = await httpClient()
        .get(`sinter_machines/${id}`)
        .catch((err) => {
          return err;
        });
      return response;
    }
    return null;
  }
}
