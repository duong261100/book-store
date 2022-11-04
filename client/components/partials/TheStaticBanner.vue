<template>
  <div class="
      relative
      flex flex-col
      justify-center items-center
      w-full
      text-white text-center
    ">
    <img class="h-[450px]" src="../../assets/image/static-banner.png" alt="~/assets/image/book-2.png" />

    <!-- Bread Scrumb -->
    <div class="absolute">
      <h2>Book Detail</h2>
      <p class="text-[16px] tracking-[2px]">Home / Books / Harry Potter</p>
    </div>

    <!-- Search Bar -->
    <div class="container absolute bottom-0 bg-grey-darker bg-clip-content">
      <div class="
          grid grid-cols-6
          w-full
          p-[30px]
          border-t-[3px] border-solid border-blue-soft
          [&>*]:px-[15px]
        ">
        <div class="px-[15px] leading-[22px] text-left">
          <h3 class="mb-0">Search your books</h3>
        </div>
        <div class="col-span-3 px-[15px]">
          <input v-model="searchData.titleSearch" type="text" placeholder="Enter Your Title" class="w-full h-full p-[10px] text-black" />
        </div>
        <div>
          <nuxt-link :to="{ name: 'books-search-params', params: { searchData }}" tag="button" class="btn-solid w-full h-full border-transparent bg-blue-soft hover:text-black">
            Search
          </nuxt-link>
        </div>
        <div>
          <nuxt-link :to="{ name: 'books-search-params', params: { searchData }}" tag="button" class="btn-solid w-full h-full border-transparent bg-grey-dark hover:text-black">
            Filter
          </nuxt-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      searchData: {
        titleSearch: "",
      }
    }
  }
}
</script>

<style>

</style>