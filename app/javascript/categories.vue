<template lang="pug">
  <div class="grid-item" v-for="category in categories">
    <span><a v-bind:href="'/categories/'+ category.id"> {{ category.name }} </a></span>
  </div>
</template>
<script>
export default {
  data() {
    return {
      categories: ""
    };
  },
  created() {
    this.getCategories()
    },
  methods: {
    getCategories() {
      fetch(`/categories.json`, {
        method: "GET",
      })
        .then((response) => {
          return response.json();
        })
        .then((json) => {
          if (json) {
            this.categories = json
          }
        })
        .catch((error) => {
          console.warn("Failed to parsing", error);
        });
      }
    }
  }
</script>
