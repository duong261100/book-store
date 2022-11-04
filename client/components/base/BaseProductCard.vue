<template>
  <div class="
      relative
      overflow-hidden
      w-full h-full
      mb-[15px]
      bg-white text-white
      group
    ">

    <div class="flex w-full h-full px-[30px] py-[15px]">
      <!-- blue background -->
      <div class="
          absolute
          left-0 top-0
          h-full w-full
          bg-blue-soft
          opacity-0
          group-hover:opacity-100
          transition-product-card">
      </div>

      <!-- front-side: image and author -->
      <div class="flex flex-col w-full h-full">
        <img :src="`${book.image}`" alt="~/assets/image/book-2.png" class="w-full h-full object-cover" />
        <h4 class="pt-[15px] m-auto text-black">{{ book.author.name }}</h4>
      </div>

      <!-- back-side: details  -->
      <div class="
          absolute
          flex flex-col
          justify-center items-center
          left-0 top-[50%]
          h-full w-full
          opacity-0
          group-hover:opacity-100 group-hover:top-0
          transition-product-card
        ">
        <h4 class="mb-[8px] text-[22px] text-center font-bold">
          <nuxt-link :to="`/books/${book.book_id}`">{{ book.title }}</nuxt-link>
        </h4>
        <base-star-rate class="mb-[12px] !text-white" :rate="book.rating" />
        <p>{{ book.author.name }}</p>
        <h3 class="mb-[16px] text-[30px] font-medium lowercase">
          {{ price }}đ
        </h3>
        <button @click="addItemToCart(book)" class="
            btn-solid
            px-[20px] py-[10px]
            border-[2px] border-solid border-white
            !text-[14px]
            hover:bg-blue-soft-hover
          ">
          ADD TO CART
        </button>
      </div>
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
  methods: {
    addItemToCart(book) {
      this.$store.dispatch('cart/addItemToCart', book)
      this.$toast.success("Add to cart succcessfully!");
    }
  },
  computed: {
    price() {
      return this.$formatPrice(this.book.price)
    },
  },
}
</script>