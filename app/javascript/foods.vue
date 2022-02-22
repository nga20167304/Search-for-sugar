<template lang="pug">
  <div class="wrapper">
    <table class="table">
      <thead>
        <tr class="row header blue">
          <th class="cell">名前</th>
          <th class="cell">糖質</th>
          <th class="cell">種類</th>
          <th class="cell">操作</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for='food in foods' :id='"food_" + food.id'>
          <Food :food='food' @delete='deleteFood' @update='updateFood'/>
        </tr>
      </tbody>
    </table>

    <nav class="page-pagination" v-if='totalPages > 1'>
      <Pager v-bind='pagerProps'/>
    </nav>
  </div>
</template>
<script>
import Food from './food.vue'
import Pager from './pager.vue'
export default {
  components: {
    Food,
    Pager
  },
  data() {
    return {
      foods: "",
      editing: false,
      totalPages: 0,
      currentPage: this.getCurrentPage()
    };
  },
  computed: {
    url() {
      const search_name = document.querySelector("#q_name_cont")
      var url = ''
      if(search_name === null)
        url = `${window.location.pathname}.json?page=${this.currentPage}`
      else
        url = `/foods.json?${encodeURI(search_name.name)}=${encodeURI(search_name.value)}&page=${this.currentPage}`
      return url
    },
    pagerProps() {
      return {
        initialPageNumber: this.currentPage,
        pageCount: this.totalPages,
        pageRange: 5,
        clickHandle: this.paginateClickCallback
      }
    }
  },
  created() {
    window.onpopstate = () => {
      this.currentPage = this.getCurrentPage()
      this.getFoods()
    }
    this.getFoods()
    },
  methods: {
    token() {
      const meta = document.querySelector('meta[name="csrf-token"]')
      return meta ? meta.getAttribute('content') : ''
    },
    getFoods() {
      fetch(this.url, {
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
            this.foods = json.foods
            this.totalPages = json.total_pages
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
    },
    getCurrentPage() {
      const params = new URLSearchParams(location.search)
      const page = params.get('page')
      return parseInt(page) || 1
    },
    paginateClickCallback(pageNumber) {
      this.currentPage = pageNumber
      this.getFoods()

      const url = new URL(location.href)
      if (pageNumber === 1) {
        url.searchParams.delete('page')
      } else {
        url.searchParams.set('page', pageNumber)
      }
      history.pushState(history.state, '', url)
    }
  }
}
</script>
