<template>
  <div class="pb-[20px]">
    <h2
      class="inline-block w-[400px] py-[8px] border-b-[1px] border-b-solid border-b-grey-dark text-black uppercase font-light ">
      {{ title }}
    </h2>
  </div>
</template>
<script>
export default {
  props: {
    title: {
      type: String,
      required: true,
    }
  }
}
</script>