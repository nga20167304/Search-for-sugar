<template lang="pug">
  <pager
    :page-count='pageCount'
    :page-range='pageRange'
    :margin-pages="2"
    :click-handler="clickHandle"
    :prev-text="'前'"
    :next-text="'後'"
    container-class='pagination'
    page-class='page-item'
    page-link-class='page-link'
    prev-class='page-item is-prev'
    prev-link-class='page-link is-prev'
    next-class='page-item is-next'
    next-link-class='page-link is-next'>
  </pager>
</template>

<script>
import VuejsPaginate from 'vuejs-paginate'

export default {
  components: {
    pager: VuejsPaginate
  },
  props: {
    initialPageNumber: { type: Number, required: true },
    pageCount: { type: Number, required: true },
    pageRange: { type: Number, required: true },
    clickHandle: { type: Function, required: true }
  }
}
</script>
