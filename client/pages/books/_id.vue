<template>
  <div class="container grid grid-cols-4">
    <the-side-bar />

    <!-- Loading -->
    <div v-if="$fetchState.pending" class="col-span-3 px-[20px]">
      <v-loading />
    </div>

    <!-- Book Details -->
    <div v-else class="col-span-3 px-[20px]">
      <div class="grid grid-cols-12 mb-[30px]">
        <div class="col-span-5 p-[15px] bg-[#f4f4f4]">
          <img class="w-full h-full object-cover" :src="`${book.image}`" alt="~/assets/image/book-2.png" />
        </div>
        <div class="col-span-7 px-[30px] space-y-[10px]">
          <h3 class="mb-0">{{ book.title }}</h3>
          <base-star-rate :rate="book.rating" class="inline-block" />
          | <span>{{ book.rating_count }} reviews</span>
          <h3 class="text-[30px] text-blue-soft lowercase">{{ price }}đ</h3>
          <p>
            Author:
            <span class="text-blue-soft">{{ book.author.name }}</span>
          </p>
          <div class="break-line-custom !w-full border-[#ddd]"></div>
          <div class="space-y-[5px]">
            <p>Categories: {{ categories }}</p>
            <p>Publisher: {{ book.publisher.name }}</p>
            <p>Language: {{ book.language.language_name }}</p>
            <p>Stock: {{ book.stock }}</p>
            <p>Publication date: {{ book.publication_date }}</p>
          </div>
          <div class="break-line-custom !w-full border-[#ddd]"></div>
          <p>
            Sed ut perspiciatis unde omnis iste natus error sit voluptatem
            accusantium doloremque laudantium, totam rem aperiam, eaque ipsa
            quae ab illo inventore veritatis et quasi architecto.
          </p>
          <div class="break-line-custom !w-full border-[#ddd]"></div>
          <div class="buttons !mt-[20px]">
            <button @click="addItemToCart(book)" class="btn-bordered">Add to cart</button>
            <button class="btn-bordered">Reviews</button>
            <button class="btn-bordered">Related books</button>
          </div>
        </div>
      </div>

      <the-review-tabs :book="book" />

      <!-- Ralated Books -->
      <div>
        <h3 class="my-[20px]">Related books</h3>
        <div class="grid grid-cols-3 gap-[30px]">
          <base-product-card v-for="(book, index) in relatedBooks" :book="book" :key="index"
            class="border-[1px] border-solid border-[#ddd]" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import bookAPI from '../../apis/books'
export default {
  layout: 'default',
  meta: {
    auth: { authority: 0 }
  },
  data() {
    return {
      book: {
        type: Object,
        required: true,
      },
      relatedBooks: {
        type: Object,
        required: true,
      },
    }
  },
  async fetch() {
    const id = this.$route.params.id

    this.book = await bookAPI.getBookWithRatingById(id)
    const books = await bookAPI.getAllBooks()

    this.relatedBooks = await books.slice(0, 3)
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
  methods: {
    addItemToCart(book) {
      this.$store.dispatch('cart/addItemToCart', book)
      this.$toast.success("Add to cart succcessfully!");
    }
  },
}
</script>

<style>

</style>