import Vue from "vue";
import Categories from "./categories.vue";

document.addEventListener("DOMContentLoaded", () => {
  const selector = "#js-categories";
  const categories = document.querySelector(selector);
  if (categories) {
    new Vue({
      render: (h) =>
        h(Categories),
    }).$mount(selector);
  }
});
