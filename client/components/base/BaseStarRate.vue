<template>
  <div class="text-[20px] text-yellow-400">
    <span v-for="i in Math.round(rate)"> ★ </span>
    <span v-for="i in 5 - Math.round(rate)"> ☆ </span>
  </div>
</template>

<script>
export default {
  props: {
    rate: {
      type: Number,
      default: 0,
    },
  }
}
</script>