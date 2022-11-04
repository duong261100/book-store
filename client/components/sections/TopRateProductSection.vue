<template>
  <div>
    <div class="container py-[50px]">
      <section-title title="Top Rate Products" />
      <div class="grid grid-cols-3 gap-x-[30px] w-[105%]">
        <base-product-item
          v-for="(book, index) in books"
          :key="index"
          :book="book"
        />
      </div>
    </div>
  </div>
</template>

<script>
import bookAPI from '../../apis/books'
export default {
  data() {
    return {
      books: [],
    }
  },
  async fetch() {
    this.books = await bookAPI.getAllBooks()
    this.books = this.books.slice(0, 6)
  },
}
</script>