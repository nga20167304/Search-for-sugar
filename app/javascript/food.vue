<template>
  <div class="category">
    <span>{{ food.category_name }}</span>
  </div>
  <div class="food-name">
    <span>{{ food.name }}</span>
  </div>
  <div class="amount-of-sugar">
    <span>{{ food.amount_of_sugar }}<p>/100g</p></span>
  </div>
</template>
<script>
export default {
  props: {
    food: { type: Object, required: true }
  }
}
</script>
