import Vue from "vue";
import Foods from "./foods.vue";

document.addEventListener("DOMContentLoaded", () => {
  const selector = "#js-foods";
  const foods = document.querySelector(selector);
  if (foods) {
    const search_name = document.querySelector("#q_name_cont");
    new Vue({
      render: (h) =>
        h(Foods, {
          props: { search_name: search_name.value },
        }),
    }).$mount(selector);
  }
});
