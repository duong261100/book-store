<template>
  <div class="w-full bg-blue-soft text-white">
    <div class="container relative flex flex-col pt-[30px] pb-[50px]">
      <h2 class="m-auto mb-[20px]">Book store gift card</h2>
      <div class="break-line-custom double-break-line-custom !mb-[30px] text-white" />

      <!-- Laptop Background -->
      <div class="absolute left-[50%] bottom-[-25px] w-[890px]">
        <img src="~/assets/image/gift-card.png" alt="" />
      </div>

      <!-- Gift Cards -->
      <div v-for="giftCard in giftCards">
        <div class="float-left w-[50%]">
          <div class="w-full px-[20px] py-[20px] hover:bg-blue-soft-hover">
            <font-awesome-icon :icon="giftCard.icon" class="text-[25px]" />
            <h4 class="
                  inline-block
                  ml-[10px] mb-[10px]
                  uppercase text-[25px] font-bold
                ">
              {{ giftCard.title }}
            </h4>
            <p>
              {{ giftCard.description }}
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      giftCards: [
        {
          icon: 'fa-solid fa-gift',
          title: 'Any occasion',
          description:
            'The great philosopher Blaise Pascal believed that human misfortune was the result of other people’s inability “to sit quietly in one’s room”',
        },
        {
          icon: 'fa-solid fa-graduation-cap',
          title: 'Special occasion',
          description:
            'Here are many special occasions in the lives of our friends, family and colleagues, and each offers an opportunity to commemorate the day with a unique and personalised book.',
        },
        {
          icon: 'fa-solid fa-face-smile',
          title: 'Cards for kids',
          description:
            'The thrill of double war. The excitement of shouting "Gin!" Every kid knows at least a handful of card classics, and every grown up kid remembers the fun of playing them.',
        },
      ],
    }
  },
}
</script>