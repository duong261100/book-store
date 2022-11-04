<template>
  <div class="w-full relative overflow-hidden cursor-pointer group">
    <nuxt-link :to="`/authors/${author.author_id}`">
      <!-- Author image background -->
      <div>
        <img :src="`${author.image}`" class="w-full h-[450px] object-cover" />
      </div>

      <!-- Author details -->
      <div class="absolute -bottom-[85px] p-[10px] bg-white/80 text-center transition-product-card
      group-hover:bottom-0 group-hover:bg-blue-soft group-hover:text-white">
        <h3 class="mb-[5px] text-[20px]">{{ author.name }}</h3>
        <p>{{ author.description }}</p>
      </div>
    </nuxt-link>
  </div>
</template>

<script>
export default {
  props: {
    author: {
      required: true,
      type: Object,
    }
  }
}
</script>

<style scoped>
p {
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  /* number of lines to show */
  line-clamp: 3;
  -webkit-box-orient: vertical;
}
</style>