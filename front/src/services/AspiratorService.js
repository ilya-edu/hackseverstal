import httpClient from "../clients/LCTHttpClient";

export default class AspiratorService {
  static async getAspirator(id, time_machine_offset = null) {
    let params = {};
    if (time_machine_offset) {
      params = new URLSearchParams([["batch_time", time_machine_offset]]);
    }
    if (!id) return null;
    const response = await httpClient()
      .get(`aspirators/${id}`, { params })
      .catch((err) => {
        return err;
      });
    return response;
  }
}
