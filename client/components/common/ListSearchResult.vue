<template>
  <div class="col-span-3 px-[20px]">
    <!-- Sort Filter -->
    <div class="
          w-full
          p-[15px]
          border-b-[1px] border-grey-light border-solid
        ">
      <span>Arrange by:</span>
      <select v-model="sortMethodSelected" @change="sortBooks()" class="
            h-[30px]
            px-[10px]
            border-solid border-[1px] border-grey-light
            rounded-[3px]
            ml-[20px]
            text-[14px]
          ">
        <option value="1">Newest</option>
        <option value="2">Highest rate</option>
        <option value="3">Alphabet</option>
      </select>
    </div>

    <!-- List Books -->
    <div class="grid grid-cols-4 w-full">
      <base-product-details-card v-for="(book, index) in showedBook" :key="index" :book="book" />
    </div>
    <base-paginator class="my-[30px] mr-[30px]" :total-pages="totalPages" :total="totalBooks" :per-page="perPage"
      :current-page="currentPage" :has-more-pages="hasMorePages" @pagechanged="showMore" />
  </div>
</template>

<script>
export default {
  props: {
    books: [],
  },
  data() {
    return {
      booksCustom: [],
      sortMethodSelected: 1,
      page: 1,
      perPage: 12,
      currentPage: 1,
    }
  },
  async fetch() {
    this.booksCustom = this.books
  },
  watch: {
    books: {
      immediate: true,
      handler(val) {
        this.booksCustom = val
      }
    }
  },
  computed: {
    totalBooks() {
      return this.booksCustom.length
    },
    totalPages() {
      return Math.ceil(this.booksCustom.length / this.perPage)
    },
    showedBook() {
      const start = (this.currentPage - 1) * this.perPage
      return this.booksCustom.slice(start, start + this.perPage)
    },
    hasMorePages() {
      return this.currentPage === this.totalPages
    }
  },
  methods: {
    showMore(page) {
      this.page = page
      this.currentPage = page
    },
    sortBooks() {
      if (this.sortMethodSelected == 2) {
        this.booksCustom.sort((a, b) => (a.rating < b.rating) ? 1 : -1);
      } else if (this.sortMethodSelected == 3) {
        this.booksCustom.sort((a, b) => (a.title > b.title) ? 1 : -1);
      } else {
        this.booksCustom.sort((a, b) => (a.publication_date > b.publication_date) ? 1 : -1);
      }
    }
  }
}
</script>

<style>

</style>