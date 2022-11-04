<template>
  <div class="content">
    <buy-section />
    <service-section />
    <best-sellers-section />
    <div class="ads-section w-full h-auto">
      <img src="~/assets/image/ads-section-2.png" alt="" class="object-cover m-auto">
    </div>
    <new-products-section />
    <gift-card-section />
    <top-rate-product-section />
    <count-up-section />
  </div>
</template>

<script lang="ts">

export default ({
  layout: 'home-layout',
  name: 'IndexPage',
  meta: {
    auth: { authority: 0 }
  }
})
</script>
