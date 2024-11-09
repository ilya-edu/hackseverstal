import { defineStore } from "pinia";

export default defineStore("offset", {
  state: () => ({
    time: null,
  }),
  getters: {},
  actions: {
    setTime(time) {
      this.time = time;
    },
  },
  persist: {
    enabled: true,
  },
});
