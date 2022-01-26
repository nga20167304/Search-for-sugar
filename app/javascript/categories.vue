<template>
  <div class="grid-item" v-for="category in categories">
    <span> {{ category.name }} </span>
  </div>
</template>
<script>
export default {
  data() {
    return {
      categories: "",
    };
  },
  created() {
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
</script>
<style scoped>

</style>
