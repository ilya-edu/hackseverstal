import CoreHTTP from "../clients/LCTHttpClient";

export default {
  async uploadFile(file) {
    const bodyFormData = new FormData();
    bodyFormData.append("file", file);
    return await CoreHTTP().post("ds_files", bodyFormData);
  },
  async getFiless() {
    return await CoreHTTP().get("ds_files");
  },
  async dropFile(id) {
    return await CoreHTTP().delete("ds_files/" + id);
  },
};
