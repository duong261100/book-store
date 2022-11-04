<template>
  <div class="container">
    <div class="grid grid-cols-12 gap-[40px]">
      <div class="col-span-4 p-[30px]">
        <img class="w-full border-solid border-[1px] border-[#666]"
          :src="user.image || '../../_nuxt/assets/image/default-avatar.jpg'" alt="" />
      </div>
      <div class="col-span-7 pt-[50px] space-y-[15px]">
        <div>
          <label>Fullname: </label>
          <input type="text" v-model="user.fullname" class="info-input">
        </div>
        <div>
          <label>Email: </label>
          <input type="text" v-model="user.email" disabled class="info-input">
        </div>
        <div>
          <label>Avatar: </label>
          <input id="file" type="file" ref="file" @change="handleUpload()" />
        </div>
        <label class="!block !mb-[5px]">Address: </label>
        <textarea v-model="user.address" cols="60" rows="4" class="px-[10px] py-[5px] rounded-[5px]" />
        <div>
          <button @click="updateProfile"
            class="btn-solid border-[#00c851] rounded-[5px] bg-[#00c851] text-white hover:text-[#00c851] hover:border-[#00c851]">Update</button>
          <nuxt-link :to="{ path: '/' }" tag="button"
            class="btn-solid border-[#ff4444] rounded-[5px] bg-[#ff4444] text-white hover:text-[#ff4444] hover:border-[#ff4444]">
            Cancel</nuxt-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import userAPI from "../../apis/users"
import axios from 'axios'
export default {
  meta: {
    auth: { authority: 1 }
  },
  data() {
    return {
      user: {},
      file: "",
    }
  },
  async fetch() {
    this.user = await userAPI.getUserDetail()
  },
  methods: {
    handleUpload() {
      this.file = this.$refs.file.files[0]
    },
    async updateProfile() {
      if (this.file) {
        const formData = new FormData()
        formData.append("file", this.file)

        if (this.user.image) {
          try {
            await axios.post('/upload/delete', { image: this.user.image })
          } catch (error) {
            console.log(error)
            this.$toast.error(error.message)
          }
        }

        await axios.post('/upload', formData, {
          headers: {
            "Content-Type": "multipart/form-data"
          }
        }).then(response => {
          this.user.image = response.data
        }).catch(error => {
          this.$toast.error(error.message)
        })
      }

      try {
        await userAPI.updateUser(this.user)
        this.$toast.success("Update successfully!")
        this.$router.push({ name: 'index' })
      } catch (error) {
        this.$toast.error(error.message)
      }
    }
  }
}
</script>

<style scoped>
label {
  display: inline-block;
  width: 100px;
  font-weight: bold;
}

.info-input {
  padding: 3px 5px;
  border-bottom: 1px solid #333;
  width: 300px;
}

textarea {
  border: 1px solid #888;
}
</style>