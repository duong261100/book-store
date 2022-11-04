<template>
  <div @click="viewDetails()"
    class="relative overflow-hidden w-full h-full p-[10px] mb-[15px] bg-white text-black cursor-pointer">
    <div class="w-full mb-[10px]">
      <img :src="`${book.image}`" alt="~/assets/image/book-2.png" class="w-full max-h-[190px] object-contain" />
    </div>
    <div>
      <p class="h-[52px]">{{ book.title }}</p>
      <p class="text-red-600 font-bold">{{ price }}đ</p>
      <base-star-rate :rate="book.rating" />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    book: {
      type: Object,
      required: true,
    },
  },
  computed: {
    price() {
      return this.$formatPrice(this.book.price)
    },
  },
  methods: {
    viewDetails() {
      this.$router.push({ name: 'books-id', params: { id: this.book.book_id } })
    },
  }
}
</script>