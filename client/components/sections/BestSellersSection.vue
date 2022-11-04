<template>
  <div class="bg-[#f0f0f0]">
    <div class="container py-[50px]">
      <section-description :description="description" />
      <div class="grid grid-cols-4 gap-[30px]">
        <base-product-card
          v-for="(book, index) in bestSellerBooks"
          :book="book"
          :key="index"
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
      bestSellerBooks: [],
      description: {
        title: 'Best top sellers',
        content:
          'The Book Guide and the Book Library has one of the top sellers books with them. Those books which are sold with in few days and still available in our stock which you can get with us easily.',
      },
    }
  },
  async fetch() {
    const res = await bookAPI.getAllBooks()
    this.bestSellerBooks = res.slice(0, 4)
  },
}
</script>

<style>
</style>