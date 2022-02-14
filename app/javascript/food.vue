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
      <input v-model="food.category_name" v-if="editing"/>
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
  data() {
    return {
      editing: false
    }
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
      const update_element = document.querySelectorAll(`#food_${this.food.id} > td.cell > input`)
      const params = {
        food: {
          name: update_element[0].value,
          amount_of_sugar: update_element[1].value
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
        this.$emit('update', this.food.name, this.food.amount_of_sugar, this.food.id)
        this.editing = false
      })
        .catch((error) => {
          console.warn('Failed to parsing', error)
        })
    }
  }
}
</script>
