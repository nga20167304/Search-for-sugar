<template>
  <div class="row">
    <div v-for="food in foods">
      <div classs="food-name">{{ food.name }}</div>
      <div classs="amount-of-sugar">{{ food.amount_of_sugar }}</div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      foods: ""
    };
  },
  created() {
    const search_name = document.querySelector("#q_name_cont");
    fetch(`/foods.json?${encodeURI(search_name.name)}=${encodeURI(search_name.value)}`, {
      method: "GET",
    })
      .then((response) => {
        return response.json();
      })
      .then((json) => {
        if (json) {
          this.foods = json
          console.log(json)
        }
      })
      .catch((error) => {
        console.warn("Failed to parsing", error);
      });
    }
  }
</script>
