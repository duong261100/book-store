<template>
  <div class="container grid grid-cols-4">
    <the-filter-bar @search="search" />

    <!-- Content -->
    <list-search-result :books="books" />
  </div>
</template>

<script>
import searchAPI from '../../../apis/search'
import categoryAPI from '../../../apis/categories'
export default {
  meta: {
    auth: { authority: 0 }
  },
  data() {
    return {
      books: [],
      categories: [],
      searchData: {},
    }
  },
  async fetch() {
    this.categories = await categoryAPI.getAllCategories()
    const params = this.$route.params.searchData || {}
    this.searchData = {
      titleSearch: params.titleSearch || "",
      languageSelected: params.languageSelected || "",
      categoriesSelectedId: params.categoriesSelectedId || this.categories.map(obj => obj.category_id),
    }
    this.books = await searchAPI.searchBooks(this.searchData)
  },
  methods: {
    async search(searchData) {
      const res = await searchAPI.searchBooks(searchData)
      this.books = res
    },
  },
}
</script>

<style>

</style>