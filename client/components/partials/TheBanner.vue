<template>
  <div class="swiper text-white">
    <div class="swiper-wrapper">
      <div v-for="(caption, i) in captions" :key="i" class="swiper-slide" :class="`slide--${i+1}`">
        <div class="slider-content z-[9999]">
          <div class="
              content-container
              absolute
              top-[35%] left-0
              w-full
              text-center
            ">

            <!-- Slide Content -->
            <h1>{{ caption.title }}</h1>
            <h2 class="dash-decoration relative inline-block px-[15px]">
              {{ caption.subTitle }}
            </h2>
            <p class="w-[500px] m-[auto] mb-[10px] text-[15px]">
              {{ caption.description }}
            </p>

            <!-- Search Input -->
            <div class="input-container relative inline-block mt-[20px]">
              <input v-model="searchData.titleSearch" @focus="delay = 100000" @blur="delay = 5000" type="text" class="
                  bg-black/[.5]
                  h-[50px] w-[580px]
                  px-[35px] py-[6px]
                  rounded-[30px]
                " placeholder="Enter Your Book Title Here" />
              <!-- <nuxt-link :to="{ path: `/books/search/${searchData.titleSearch}` }" tag="button" class=" -->
              <nuxt-link :to="{ name: 'books-search-params', params: { searchData }}" tag="button" class="
                  absolute
                  top-0 right-0
                  h-full
                  px-[20px] py-[10px]
                  rounded-r-[30px]
                  bg-blue-soft
                  text-[20px]
                ">
                <font-awesome-icon icon="fa-solid fa-magnifying-glass" />
              </nuxt-link>
            </div>

          </div>
        </div>
      </div>
    </div>
    <div class="swiper-pagination"></div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
  </div>
</template>

<script>
// import Swiper JS
// add or remove unused modules
import { Swiper, Navigation, Pagination, Autoplay } from 'swiper'
import 'swiper/swiper-bundle.min.css'
export default {
  data() {
    return {
      delay: 5000,
      searchData: {
        titleSearch: "",
      },
      captions: [
        {
          title: 'Book reading',
          subTitle: 'Best book available',
          description:
            'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium dolor emque laudantium, totam rem aperiam.ipsam voluptatem.',
        },
        {
          title: 'Book store',
          subTitle: 'Books guiders',
          description:
            'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium dolor emque laudantium, totam rem aperiam.ipsam voluptatem.',
        },
        {
          title: 'Book guide',
          subTitle: 'Online book store',
          description:
            'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium dolor emque laudantium, totam rem aperiam.ipsam voluptatem.',
        },
      ],
    }
  },
  mounted() {
    // configure Swiper to use modules. The modules were tested with SwiperJS v6.8.4 with NuxtJS v2.15.7
    // previously it was before export default. Moved here for performance issues. Move back in case of problems.
    // add or remove unused modules
    Swiper.use([Navigation, Pagination, Autoplay])

    // init Swiper:
    /* eslint-disable no-unused-vars */
    let swiper = new Swiper('.swiper', {
      // Optional parameters
      // @see https://swiperjs.com/swiper-api#parameters
      direction: 'horizontal',
      loop: true,
      // remove unused modules if needed
      modules: [Navigation, Pagination, Autoplay],
      // Pagination if needed
      pagination: {
        el: '.swiper-pagination',
        type: 'bullets',
        clickable: true,
      },
      // Autoplay if needed
      autoplay: {
        delay: this.delay,
      },
      // Navigation arrows if needed
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      // Configure other options. Not tested
    })
  },
}
</script>

<style scoped>
.swiper {
  position: relative;
  overflow: hidden;
  width: 100%;
  height: 650px;
}

.swiper-slide {
  display: flex;
  justify-content: center;
  align-items: center;
  background-size: 100%;
  background-repeat: no-repeat;
}

.swiper-slide::before {
  content: '';
  position: absolute;
  z-index: 999;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
}

.slide--1 {
  background-image: url('../../assets/image/banner-1.png');
}

.slide--2 {
  background-image: url('../../assets/image/banner-2.png');
}

.slide--3 {
  background-image: url('../../assets/image/banner-3.png');
}

.swiper-button-prev,
.swiper-button-next {
  color: #fff;
  font-weight: bold;
}
</style>