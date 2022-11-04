<template>
  <div class="
      w-full
      px-[15px]
      space-y-[30px]
      text-black
      [&>div>h3]:underline-static [&>div>h3]:pb-[15px] [&>div>h3]:mb-[20px]
    ">

    <!-- Widget Search -->
    <div>
      <h3>Search</h3>
      <div class="
          relative
          flex
          items-center
          w-full
          text-[#989898]
          leading-[26px]
        ">
        <input type="text" class="
            w-full h-[44px]
            border-solid border-[1px] border-grey-soft
            pl-[10px] pr-[40px] py-[2px]
          " placeholder="Enter Keyword" />
        <font-awesome-icon icon="fa-solid fa-magnifying-glass" class="absolute right-[15px]" />
      </div>
    </div>

    <!-- Widget New Arrival -->
    <div>
      <h3>New arrival</h3>
      <ul class="w-full">
        <li v-for="(book, index) in newArrivalBooks" :key="index" :book="book">
          <div class="
              new-arrival
              w-full
              p-[10px]
              border-solid border-[1px] border-[#ccc]
              mt-[-1px]
            ">
            <div class="grid grid-cols-12 overflow-hidden w-full h-[130px]">
              <div class="col-span-4 max-h-[130px]">
                <img :src="`${book.image}`" alt="~/assets/image/book-2.png" class="w-full h-full object-cover" />
              </div>
              <div class="col-span-8 ml-[10px] relative">
                <h5 class="
                    mb-[10px]
                    text-[14px] leading-[16px]
                    uppercase
                    font-bold
                  ">
                  {{ book.title.slice(0, 30) }}
                </h5>
                <p class="text-[13px] leading-[20px]">
                  {{ book.description.slice(0, 60) }}...
                </p>
                <nuxt-link :to="`/books/${book.book_id}`" class="underline
                    absolute
                    bottom-0
                    text-[14px] italic text-blue-soft">Details</nuxt-link>
              </div>
            </div>
          </div>
        </li>
      </ul>
    </div>

    <!-- Widget Categories-->
    <div class="widget-categories">
      <h3>Categories</h3>
      <ul class="footer-ul">
        <nuxt-link v-for="(category, index) in categories" :key="index"
          :to="{ name: 'books-search-params', params: { searchData: { categoriesSelectedId: [category.category_id] } } }"
          class="block not-last:border-b-[1px] border-solid !border-grey-soft transition-product-card">
          <li>
            {{ category.name }}
          </li>
        </nuxt-link>
      </ul>
    </div>
  </div>
</template>

<script>
import bookAPI from '../../apis/books'
import categoryAPI from '../../apis/categories'
export default {
  data() {
    return {
      categories: [],
      newArrivalBooks: [],
    }
  },
  async fetch() {
    this.categories = await categoryAPI.getAllCategories()
    const res = await bookAPI.getAllBooks()
    this.newArrivalBooks = res.slice(0, 4)
  },
}
</script>