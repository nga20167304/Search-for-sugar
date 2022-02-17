<template lang="pug">
  <tr v-for='food in foods' :id='"food_" + food.id'>
    <Food :food='food' @delete='deleteFood', @update='updateFood'/>
  </tr>
</template>
<script>
import Food from './food.vue'
export default {
  components: {
    Food
  },
  data() {
    return {
      foods: "",
      editing: false
    };
  },
  created() {
    this.getFoods()
    },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    getFoods() {
      const search_name = document.querySelector("#q_name_cont");
      fetch(`/foods.json?${encodeURI(search_name.name)}=${encodeURI(search_name.value)}`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        })
        .then((response) => {
          return response.json();
        })
        .then((json) => {
          if (json) {
            this.foods = json
            this.loaded = true
          }
        })
        .catch((error) => {
          console.warn("Failed to parsing", error);
        });
      },
    editFood() {
      this.editing = !this.editing
    },
    updateFood(name, amount_of_sugar, category_id, id) {
      const updatedFood = this.foods.find((food) => {
        return food.id === id
      })
      updatedFood.name = name
      updatedFood.amount_of_sugar = amount_of_sugar
      updatedFood.category_id = category_id
    },
    deleteFood: function(id) {
      fetch(`/foods/${id}.json`, {
        method: 'DELETE',
        headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-Token': this.token()
        }
      })
      .then(() => {
        this.foods.forEach((food, i) => {
          if (food.id === id) {
            this.foods.splice(i, 1)
          }
        })
      })
      .catch((error) => {
        console.warn('Failed to parsing', error)
      })
    }
  }
}
</script>
