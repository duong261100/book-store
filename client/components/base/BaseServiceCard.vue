<template>
  <div class="
      w-full h-auto
      px-[20px] py-[30px]
      border-solid border-[1px] border-[#cfcfcf]
      mb-[15px]
      hover:bg-blue-soft
      group
      transition-product-card
    ">
    <div class="flex flex-col items-center text-center">
      <font-awesome-icon :icon="serviceCard.icon" class="
          inline-block
          w-[90px] h-[90px]
          py-[25px]
          rounded-[50%]
          mb-[15px]
          bg-[#efeff0] text-grey-dark
          text-[40px]
          group-hover:text-blue-soft
        " style="transition: all ease-in-out 0.2s" />
      <div class="break-line-custom double-break-line-custom border-[#cbcbcd] !mb-[12px] group-hover:border-white">
      </div>
      <h4 class="text-[#4a454b] group-hover:text-white">
        {{ serviceCard.title }}
      </h4>
      <p class="
          overflow-hidden
          h-[100px]
          mb-[20px]
          text-[#9a9a9a]
          group-hover:text-white
        ">
        {{ serviceCard.description }}
      </p>
      <button class="
          px-[15px] py-[5px]
          border-solid border-[1px] border-[#9a9a9a]
          text-[#9a9a9a]
          hover:bg-blue-soft-hover
          group-hover:text-white group-hover:border-white
        ">
        Read More
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    serviceCard: {
      require: true,
      type: Object,
    },
  },
}
</script>