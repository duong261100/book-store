<template>
  <div class="container py-[50px]">
    <section-description :description="description" />
    <div class="grid grid-cols-4 gap-[30px]">
      <base-service-card
        v-for="(serviceCard, i) in serviceCards"
        :key="i"
        :service-card="serviceCard"
      />
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      description: {
        title: 'The book guide online book store',
        content:
          'The Online Books Guide is the biggest big store and the biggest books library in the world that has alot of the popular and the most top category books presented here. Top Authors are here just subscribe your email address and get updated with us.',
      },
      serviceCards: [
        {
          icon: 'fa-solid fa-gift',
          title: 'Free gift wrap',
          description:
            'Free gift wrapping on all purchases. Wrapping includes a blue box with your choice with Ribbon.',
        },
        {
          icon: 'fa-solid fa-book',
          title: 'Buy selling used books',
          description:
            'We provide you the best selling of the used books. You can sell them to us if you have read them once.',
        },
        {
          icon: 'fa-solid fa-truck-fast',
          title: 'Free shipping',
          description:
            'We provide free shipping over the $1000 purchase from one country to another with extra discount.',
        },
        {
          icon: 'fa-solid fa-calculator',
          title: 'Returns & exchange',
          description:
            'Return and Exchange is possible in 5 days. In case of lost or damage Return & Exchange is not possible.',
        },
      ],
    }
  },
}
</script>