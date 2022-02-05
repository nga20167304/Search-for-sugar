<template>
  <div v-for='food in foods' :id='"food_" + food.id'>
    <div class="cell" data-title="food-name">
      <input v-model="food.name" v-if="editing"/>
      <span v-else>{{ food.name }}</span>
    </div>
    <div class="cell" data-title="amount-of-sugar">
      <input v-model="food.amount_of_sugar" v-if="editing"/>
      <span v-else>{{ food.amount_of_sugar }}</span>
    </div>
    <div class="cell" data-title="category">
      <input v-model="food.category_id" v-if="editing"/>
      <span v-else>{{ food.category_id }}</span>
    </div>
    <div class="cell" data-title="action">
      <button v-show='!editing' @click='editFood(food.id)'>編集</button>
      <button v-show='editing' @click='updateFood(food.id)'>保存する</button>
      <button @click='deleteFood(food.id)'>削除</button>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      foods: "",
      editing: false
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
        }
      })
      .catch((error) => {
        console.warn("Failed to parsing", error);
      });
    },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    editFood() {
      this.editing = true
      },
    updateFood(id) {
      const update_element = document.querySelectorAll(`#food_${id} > div.cell > input`)
      const params = {
        food: {
          name: update_element[0].value,
          amount_of_sugar: update_element[1].value,
          category_id: update_element[2].value
          }
        }
      fetch(`/foods/${id}.json`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        body: JSON.stringify(params)
      })
      .then(() => {
        this.foods.forEach((food) => {
          if(food.id === id) {
            food.name = update_element[0].value,
            food.amount_of_sugar = update_element[1].value,
            food.category_id = update_element[2].value
          }
        })
        this.editing = false
      })
      .catch((error) => {
        console.warn('Failed to parsing', error)
      })
    },
    deleteFood(id) {
      if (window.confirm('削除してよろしいですか？')) {
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
}
</script>
