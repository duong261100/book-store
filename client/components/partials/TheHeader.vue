<template>
  <div class="text-white">

    <!-- Cart - Login - Register - Logout - Profile -->
    <div class="py-[10px]">
      <div class="container">
        <div class="
            flex
            justify-end
            space-x-[20px]
            transition-none
          ">
          <nuxt-link to="/cart" tag="button" class="mt-[3px] text-[20px] hover:text-blue-soft">
            <font-awesome-icon icon="fa-solid fa-cart-shopping" />
          </nuxt-link>
          <!-- logout - profile -->
          <span v-if="this.$auth.loggedIn" class="flex items-center">
            <button @click="logout()" class="text-[20px] hover:text-blue-soft">
              <font-awesome-icon icon="fa-solid fa-arrow-right-from-bracket" />
            </button>
            <nuxt-link to="/users/profile">
              <img class="min-w-[35px] max-w-[35px] max-h-[35px] rounded-full ml-[20px] -mr-[30px] cursor-pointer"
                :src="this.$auth.user.image || '../../_nuxt/assets/image/default-avatar.jpg'"
                alt="" />
            </nuxt-link>
          </span>
          <!-- login - register -->
          <span v-else class="flex items-center space-x-[10px]">
            <nuxt-link to="/login" tag="button" class="btn btn-default hover:text-blue-soft">Login</nuxt-link>
            <nuxt-link to="/login" tag="button" class="btn btn-default hover:text-blue-soft">Register</nuxt-link>
          </span>
        </div>
      </div>
    </div>

    <!-- Logo - Navbar -->
    <div>
      <div class="container flex place-content-between items-center">
        <!-- Logo -->
        <div>
          <nuxt-link to="/" class="cursor-pointer" tag="img" :src="require('~/assets/image/logo.png')" />
        </div>

        <!-- Navbar-->
        <div>
          <ul class="
              flex
              mr-[15px]
              space-x-[30px]
              [&>li>a]:py-[15px] [&>li>a]:relative
            ">
            <li>
              <nuxt-link to="/" class="underline-animation">Home</nuxt-link>
            </li>
            <li class="relative group">
              <a href="#" class="underline-animation">Languages</a>
              <ul class="
                  dropdown-custom
                  grid grid-cols-1
                  invisible
                  w-[150px]
                  opacity: 0
                  group-hover:opacity-100 group-hover:visible group-hover:top-[37px]
                ">
                <nuxt-link v-for="(language, index) in languages" :key="index"
                  :to="{ name: 'books-search-params', params: { searchData: { languageSelected: language.language_name } } }">
                  <li>
                    {{ language.language_name }}
                  </li>
                </nuxt-link>
              </ul>
            </li>
            <li class="relative group">
              <a href="#" class="underline-animation">Genres</a>
              <ul class="
                  dropdown-custom
                  grid grid-cols-5
                  invisible
                  w-[600px]
                  opacity-0
                  group-hover:opacity-100 group-hover:visible group-hover:top-[37px]
                ">
                <nuxt-link v-for="(category, index) in categories" :key="index"
                  :to="{ name: 'books-search-params', params: { searchData: { categoriesSelectedId: [category.category_id] } } }">
                  <li>
                    {{ category.name }}
                  </li>
                </nuxt-link>
              </ul>
            </li>
            <li>
              <nuxt-link :to="{ name: 'books-search-params' }" class="underline-animation">
                Filter Search</nuxt-link>
            </li>
            <li>
              <nuxt-link to="/authors" class="underline-animation">
                Authors</nuxt-link>
            </li>
            <li><a href="#" class="underline-animation">About Us</a></li>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import categoryAPI from '../../apis/categories'
import languageAPI from '../../apis/languages'
export default {
  data() {
    return {
      categories: [],
      languages: [],
    }
  },
  async fetch() {
    this.categories = await categoryAPI.getAllCategories()
    this.languages = await languageAPI.getAllLanguages()
  },
  methods: {
    async logout() {
      await this.$auth.logout()
      this.$toast.success("Log out successfully")
    }
  }
}
</script>

<style scoped>

</style>