<template>
  <div class="container">
    <div class="grid grid-cols-3 gap-[30px]">
      <base-author-card v-for="author in showedAuthor" :author="author" :key="author.author_id" />
    </div>
    <base-paginator class="my-[30px] mr-[30px]" :total-pages="totalPages" :total="totalAuthors" :per-page="perPage"
      :current-page="currentPage" :has-more-pages="hasMorePages" @pagechanged="showMore" />
  </div>
</template>

<script>
import authorAPI from "../../apis/authors"
export default {
  meta: {
    auth: { authority: 0 }
  },
  data() {
    return {
      authors: [],
      page: 1,
      perPage: 9,
      currentPage: 1,
    }
  },
  async fetch() {
    this.authors = await authorAPI.getAllAuthors()
  },
  computed: {
    totalAuthors() {
      return this.authors.length
    },
    totalPages() {
      return Math.ceil(this.authors.length / this.perPage)
    },
    showedAuthor() {
      const start = (this.currentPage - 1) * this.perPage
      return this.authors.slice(start, start + this.perPage)
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
  }
}
</script>

<style>

</style>