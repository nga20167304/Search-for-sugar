const { environment } = require("@rails/webpacker");
const { VueLoaderPlugin } = require("vue-loader");
const vue = require("./loaders/vue");

environment.config.merge({
  resolve: {
    alias: {
      vue: "@vue/compat",
    },
  },
});

environment.plugins.prepend("VueLoaderPlugin", new VueLoaderPlugin());
environment.loaders.prepend("vue", vue);
module.exports = environment;
