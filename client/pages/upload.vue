<template>
  <div>
    <input type="file" ref="file" v-on:change="handleUpload()" />
    <button v-on:click="uploadFile()">Upload</button> <br>
    <p>{{ message }}</p>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  meta: {
    auth: { authority: 0 }
  },
  data() {
    return {
      file: '',
      message: ''
    }
  },
  methods: {
    handleUpload() {
      this.file = this.$refs.file.files[0]
    },
    uploadFile() {
      const formData = new FormData()
      formData.append("file", this.file)
      axios.post('/upload', formData, {
        headers: {
          "Content-Type": "multipart/form-data"
        }
      }).then(response => {
        this.message = response.data
      }).catch(error => {
        this.message = error
      })
      console.log(this.message)
    }
  }
}
</script>

<style>

</style>