<template>
  <div class="container">
    <!-- Loading -->
    <div v-if="$fetchState.pending">
      <v-loading />
    </div>

    <div v-else>
      <!-- Author Details -->
      <div class="grid grid-cols-12 gap-[30px] mb-[50px]">
        <div class="col-span-3">
          <img :src="`${author.image}`" alt="~/assets/image/book-2.png" class="w-full h-[350px] object-cover" />
        </div>
        <div class="col-span-9">
          <h2 class="mb-0">{{ author.name }}</h2>
          <h4 class="text-gray-600 font-medium">Author</h4>
          <p>{{ author.description }}</p>
          <p>{{ author.description }}</p>
        </div>
      </div>

      <!-- Published Books -->
      <div>
        <h3>Published books</h3>
        <div class="break-line-custom !w-full border-[#ddd]" />
        <div class="grid grid-cols-3 gap-[20px] mt-[20px] mb-[100px]">
          <base-product-item v-for="(book, index) in books" :book="book" :key="index" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import authorAPI from '../../apis/authors'
import bookAPI from '../../apis/books'
export default {
  meta: {
    auth: { authority: 0 }
  },
  data() {
    return {
      author: {
        type: Object,
      },
      books: {
        type: Array,
      },
    }
  },
  async fetch() {
    const id = this.$route.params.id

    this.author = await authorAPI.getAuthorById(id)
    this.books = await bookAPI.getBookByAuthorId(id)
  },
}
</script>

<style>

</style>