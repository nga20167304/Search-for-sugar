<template>
  <td class="cell" data-title="food-name">
    <input v-model="food.name" v-if="editing"/>
    <span v-else>{{ food.name }}</span>
  </td>
  <td class="cell" data-title="amount-of-sugar">
    <input v-model="food.amount_of_sugar" v-if="editing"/>
    <span v-else>{{ food.amount_of_sugar }}</span>
  </td>
  <td class="cell" data-title="category">
    <select id="select-category" v-model="food.category_name" v-select2 v-if="editing">
      <option v-for='category in categories' :selected='category.name' :key='category.id' :value='category.name'>
        {{ category.name }}
      </option>
    </select>
    <span v-else>{{ food.category_name }}</span>
  </td>
  <td class="cell" data-title="action">
    <button v-show='!editing' @click='editFood'>編集</button>
    <button v-show='editing' @click='updateFood'>保存する</button>
    <button @click='deleteFood'>削除</button>
  </td>
</template>
<script>
export default {
  props: {
    food: { type: Object, required: true }
  },
  directives: {
    select2: {
      mounted(el) {
        el.select2
      }
    }
  },
  data() {
    return {
      editing: false,
      categories: ""
    }
  },
  created() {
    this.getCategories()
  },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    editFood() {
      this.editing = !this.editing
    },
    deleteFood: function () {
      if (window.confirm('削除してよろしいですか？')) {
        this.$emit('delete', this.food.id)
      }
    },
    updateFood: function() {
      const updateElement = document.querySelectorAll(`#food_${this.food.id} > td.cell > input`)
      const selected = document.getElementById('select-category').value
      const selectedCategory = this.categories.find((category) => {
        return category.name === selected
      })
      const params = {
        food: {
          name: updateElement[0].value,
          amount_of_sugar: updateElement[1].value,
          category_id: selectedCategory.id
          }
        }
      fetch(`/foods/${this.food.id}.json`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'X-Requested-With': 'XMLHttpRequest',
          'X-CSRF-Token': this.token()
        },
        body: JSON.stringify(params)
      })
      .then(() => {
        this.$emit('update', this.food.name, this.food.amount_of_sugar, this.food.category_id, this.food.id)
        this.editing = false
      })
        .catch((error) => {
          console.warn('Failed to parsing', error)
        })
    },
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
