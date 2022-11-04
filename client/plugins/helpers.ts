import Vue from 'vue'

declare module 'vue/types/vue' {
  interface Vue {
    $formatPrice(price: number): string
  }
}

Vue.prototype.$formatPrice = (price: number) => {
  return new Intl.NumberFormat('vi-VN').format(price)
}
