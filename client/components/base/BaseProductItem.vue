<template>
  <div class="w-full h-full mb-[15px] text-black">
    <div class="grid grid-cols-5 h-full py-[15px]">

      <!-- left 2/5 - product image -->
      <div class="col-span-2 relative">
        <!-- hover background -->
        <div @click="addItemToCart(book)" class="
            absolute
            flex
            justify-center items-center
            w-full h-full
            bg-blue-soft
            opacity-0
            hover:opacity-100 hover:cursor-pointer
            transition-product-card
          ">
          <font-awesome-icon icon="fa-solid fa-cart-plus" class="text-[30px] text-white font-bold" />
        </div>
        <!-- product image -->
        <img :src="`${book.image}`" alt="~/assets/image/book-2.png" class="w-full h-full object-cover" />
      </div>

      <!-- right 3/5 - product details -->
      <div class="relative col-span-3 px-[20px]">
        <h4 class="mb-0 uppercase font-bold">{{ book.title }}</h4>
        <p class="text-[14px]">{{ book.author.name }}</p>
        <base-star-rate :rate="book.rating" />
        <p>
          <span class="text-yellow-400 text-[17px]">{{ book.rating }}
            <span class="text-[21px] ml-[2px]">★</span>
          </span>
          | {{ book.rating_count }} vote
        </p>
        <p class="text-[14px]">{{ categories }}</p>
        <p class="text-red-600 text-[16px]">{{ price }}đ</p>
        <button class="
            absolute
            left-[20px] bottom-[5px]
            px-[10px] py-[5px]
            rounded-sm
            bg-blue-soft text-white
          " @click="viewDetails()">
          View details
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
    },
    viewDetails() {
      this.$router.push({ name: 'books-id', params: { id: this.book.book_id } })
    },
  },
  computed: {
    categories() {
      const categories = this.book.categories.map((el) => el.name)
      return categories.slice().join(', ')
    },
    price() {
      return this.$formatPrice(this.book.price)
    },
  },
}
</script>

<style scoped>
h4 {
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  /* number of lines to show */
  line-clamp: 3;
  -webkit-box-orient: vertical;
}

p {
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  /* number of lines to show */
  line-clamp: 1;
  -webkit-box-orient: vertical;
}
</style>