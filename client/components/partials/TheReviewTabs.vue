<template>
  <div class="w-full mb-[30px] text-grey">
    <!-- Nav Tabs -->
    <div>
      <button @click="activeTab = 1" :class="{ active: activeTab == 1 }" class="btn-solid btn-tab-custom">
        Description
      </button>
      <button @click="activeTab = 2" :class="{ active: activeTab == 2 }" class="btn-solid btn-tab-custom">
        Reviews
      </button>
    </div>

    <!-- Tab Content -->
    <div class="p-[30px] border-[1px] border-solid border-grey-soft">

      <!-- Description Tab -->
      <div v-if="activeTab == 1">
        <p>
          {{ book.description }}
          <br />
          {{ book.description }}
          <br />
          {{ book.description }}
        </p>
      </div>

      <!-- Reviews Tab -->
      <div v-if="activeTab == 2">
        <!-- Review -->
        <div v-for="(review, index) in reviews" :key="index" class="flex mb-[20px]">
          <!-- Avatar -->
          <div class="min-w-[80px] max-w-[80px]">
            <img class="rounded-full"
            :src="review.image || '../../_nuxt/assets/image/default-avatar.jpg'" />
          </div>
          <!-- Detail -->
          <div class="ml-[20px] -mt-[3px]">
            <h4 class="mb-0 text-black uppercase font-semibold">{{ review.fullname }}</h4>
            <p class="-my-[5px] text-[12px] italic">{{ datetimeReview(review.Rating.date_time) }}</p>
            <base-star-rate :rate=review.Rating.rating />
            <p>
              {{ review.Rating.review }}
            </p>
          </div>
        </div>

        <div class="flex items-center mt-[70px] space-x-[20px]">
          <input v-model="review"
            class="w-1/2 pt-[8px] pl-[20px] pb-[10px] border-[1px] border-solid border-[#ddd] rounded-full" type="text"
            maxlength="200" value="" placeholder="Write some review...">
          <div class="pt-[8px] pb-[10px] px-[20px] border-[1px] border-solid border-[#ddd] rounded-full text-[#ccc]">
            <ul id='stars' class="[&>li]:inline-block [&>li]:cursor-pointer">
              <li id='star-1' title='Poor' @mouseover="hoverStar(1)" @mouseleave="removeHoverStar()"
                @click="selectStar(1)">
                <i class='fa fa-star fa-fw'></i>
              </li>
              <li id='star-2' title='Fair' @mouseover="hoverStar(2)" @mouseleave="removeHoverStar()"
                @click="selectStar(2)">
                <i class='fa fa-star fa-fw'></i>
              </li>
              <li id='star-3' title='Good' @mouseover="hoverStar(3)" @mouseleave="removeHoverStar()"
                @click="selectStar(3)">
                <i class='fa fa-star fa-fw'></i>
              </li>
              <li id='star-4' title='Excellent' @mouseover="hoverStar(4)" @mouseleave="removeHoverStar()"
                @click="selectStar(4)">
                <i class='fa fa-star fa-fw'></i>
              </li>
              <li id='star-5' title='WOW!!!' @mouseover="hoverStar(5)" @mouseleave="removeHoverStar()"
                @click="selectStar(5)">
                <i class='fa fa-star fa-fw'></i>
              </li>
            </ul>
          </div>
          <button @click="addReview()"
            class="btn-solid !px-[35px] rounded-full bg-blue-soft text-white">Review</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import ratingAPI from "../../apis/ratings"
export default {
  props: {
    book: {
      type: Object,
      required: true,
    }
  },
  data() {
    return {
      reviews: [],
      activeTab: 1,
      review: '',
      starSelected: 0,
    }
  },
  fetch() {
    this.book.users.forEach(review => {
      this.reviews.push({ fullname: review.fullname, image: review.image, Rating: review.Rating })
    })
  },
  methods: {
    datetimeReview(isoDatetime) {
      return isoDatetime.substring(0, 10) + " " + isoDatetime.substring(11, 19)
    },
    hoverStar(num) {
      for (var i = 1; i <= num; i++) {
        let star = document.getElementById("star-" + i)
        star.classList.add("hoverStar")
      }
      for (var i = 5; i > num; i--) {
        let star = document.getElementById("star-" + i)
        star.classList.remove("hoverStar")
      }
    },
    removeHoverStar() {
      for (var i = 5; i > 0; i--) {
        let star = document.getElementById("star-" + i)
        star.classList.remove("hoverStar")
      }
    },
    selectStar(num) {
      this.starSelected = num
      for (var i = 1; i <= num; i++) {
        let star = document.getElementById("star-" + i)
        star.classList.add("selectedStar")
      }
      for (var i = 5; i > num; i--) {
        let star = document.getElementById("star-" + i)
        star.classList.remove("selectedStar")
      }
    },
    async addReview() {
      if (!this.$auth.loggedIn) {
        this.$toast.warning("Bạn cần đăng nhập trước")
        this.$router.push("/login")
      }
      else {
        try {
          const dataRating = {
            user_id: this.$auth.user.user_id,
            book_id: this.book.book_id,
            rating: this.starSelected,
            review: this.review
          }
          const res = await ratingAPI.addRating(dataRating)
          if (res) {
            this.reviews.push({
              fullname: this.$auth.user.fullname,
              image: this.$auth.user.image,
              Rating: res
            })
          }
        } catch (error) {
          console.log(error)
          this.$toast.error(error.response.data)
        }
      }
    }
  }
}
</script>

<style scoped>
button.btn-tab-custom {
  margin: 0;
  border-radius: 5px 5px 0 0;
}

.active {
  background-color: #32b5f3;
  color: white;
}

button.btn-tab-custom:not(.active):hover {
  background-color: #ddd;
  color: #666;
}

.hoverStar {
  color: #FFCC36;
}

.selectedStar {
  color: tomato;
}
</style>