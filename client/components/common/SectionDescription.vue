<template>
  <div class="px-[100px] pb-[30px] text-center">
    <h2 class="text-black uppercase">
      {{ description.title }}
    </h2>
    <div class="break-line-custom double-break-line-custom border-blue-soft !mb-[20px]" />
    <p class="text-grey">
      {{ description.content }}
    </p>
  </div>
</template>

<script>
export default {
  props: {
    description: {
      type: Object,
      required: true,
    }
  }
}
</script>