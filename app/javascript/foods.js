import Vue from "vue";
import Foods from "./foods.vue";

document.addEventListener("DOMContentLoaded", () => {
  const selector = "#js-foods";
  const foods = document.querySelector(selector);
  if (foods) {
    new Vue({
      render: (h) =>
        h(Foods)
    }).$mount(selector);
  }
});
