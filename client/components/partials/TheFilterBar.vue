<template>
  <div class="
      w-full
      px-[15px]
      text-black
      space-y-[30px]
      [&>div>h3]:underline-static [&>div>h3]:pb-[15px] [&>div>h3]:mb-[20px]
    ">
    <!-- Search Filter -->
    <div>
      <h3>Search</h3>
      <div class="
          relative
          flex
          items-center
          w-full
          text-grey
          leading-[26px]
        ">
        <input v-model="titleSearch" type="text" class="
            w-full h-[44px]
            border-solid border-[1px] border-grey-soft
            pl-[10px] pr-[40px] py-[2px]
          " placeholder="Enter Keyword" />
        <font-awesome-icon icon="fa-solid fa-magnifying-glass" class="absolute right-[15px]" />
      </div>
    </div>

    <!-- Price Filter -->
    <div>
      <h3>Price</h3>
      <ul>
        <li v-for="priceRange in priceRangeFilter" :key="priceRange.id">
          <label class="text-grey text-[16px]">
            <input v-model="priceRange.isSelected" name="checkbox" @change="uniqueCheck($event, priceRange.id)" type="checkbox"
              class="radio mr-[5px] " />
            {{ priceRange.label }}
          </label>
        </li>
      </ul>
    </div>

    <!-- Categories Filter -->
    <div>
      <h3>Categories</h3>
      <button v-for="(category, index) in categories" :key="index" class="tag-custom"
        :class="{ active: category.isActive }" @click="category.isActive = !category.isActive">
        {{ category.name }}
      </button>
    </div>

    <!-- Languages Filter -->
    <div>
      <h3>Language</h3>
      <select v-model="languageSelected" class="
          w-full h-[44px]
          pl-[10px] pr-[40px] py-[2px]
          border-solid border-[1px] border-grey-soft
        ">
        <option v-for="language in languages" :key="language.language_name">
          {{ language.language_name }}
        </option>
      </select>
    </div>

    <button @click="search()"
      class="btn-solid border-transparent !mx-0 bg-red-600 text-white hover:border-red-600 hover:text-red-600">Search</button>
  </div>
</template>

<script>
import languageAPI from '../../apis/languages'
import categoryAPI from '../../apis/categories'
export default {
  data() {
    return {
      titleSearch: '',
      priceRangeFilter: [
        {
          id: 1,
          label: '0đ - 50,000đ',
          fromValue: 0,
          toValue: 50000,
          isSelected: false,
        },
        {
          id: 2,
          label: '50,000đ - 100,000đ',
          fromValue: 50000,
          toValue: 100000,
          isSelected: false,
        },
        {
          id: 3,
          label: '100,000đ - 200,000đ',
          fromValue: 100000,
          toValue: 200000,
          isSelected: false,
        },
        {
          id: 4,
          label: '200,000đ - 350,000đ',
          fromValue: 200000,
          toValue: 350000,
          isSelected: false,
        },
        {
          id: 5,
          label: 'Trên 350,000đ',
          fromValue: 350000,
          toValue: 999999999,
          isSelected: false,
        },
      ],
      categories: [],
      languages: [],
      languageSelected: '',
    }
  },
  async fetch() {
    const res = await categoryAPI.getAllCategories()
    this.categories = res.map((obj) => ({ ...obj, isActive: false }))
    this.languages = await languageAPI.getAllLanguages()
  },
  methods: {
    uniqueCheck(e, checkboxId) {
      if (e.target.checked) {
        this.priceRangeFilter.forEach(priceRange => {
          if (priceRange.id !== checkboxId) {
            priceRange.isSelected = false
          }
        })
      }
    },
    async search() {
      const categoriesSelected = this.categories.filter(obj => obj.isActive)
      let categoriesSelectedId
      if (categoriesSelected.length === 0) {
        categoriesSelectedId = this.categories.map(obj => obj.category_id)
      }
      else {
        categoriesSelectedId = categoriesSelected.map(obj => obj.category_id)
      }

      const priceRangeSelected = this.priceRangeFilter.find(obj => obj.isSelected)
      const priceRange = priceRangeSelected ? [priceRangeSelected.fromValue, priceRangeSelected.toValue] : [0, 9999999]

      const searchData = {
        titleSearch: this.titleSearch,
        languageSelected: this.languageSelected,
        categoriesSelectedId,
        priceRange
      }
      await this.$emit('search', searchData)
    }
  }
}
</script>
