<template>
  <div class="w-screen h-screen bg-[#080710]">
    <div class="absolute translate-x-[-50%] translate-y-[-50%] top-[50%] left-[50%] w-[400px] h-[550px] transition-all"
      :class="{ 'h-[480px]': isLoginPage }">

      <!-- Background -->
      <div class="w-full h-full">
        <div class="shape-custom shape-top-left-custom" />
        <div class="shape-custom shape-bottom-right-custom" />
      </div>

      <!-- Form -->
      <div class="absolute top-0 w-full h-full px-[35px] py-[25px]
      border-[2px] border-solid border-white/[.1] rounded-[10px]
      bg-white/[.13] text-white font-poppins tracking-[0.5px]
      backdrop-blur-[10px] shadow-slate-800 shadow-xl">

        <!-- Login Form-->
        <div v-if="isLoginPage">
          <h4 class="mb-[20px] text-[32px] font-medium leading-[42px] text-center">Login Here</h4>

          <div class="relative">
            <label>Email</label>
            <p v-if="errorMessageLogin.email" class="error-message">{{ errorMessageLogin.email }}</p>
          </div>
          <input v-model="dataLogin.email" class="textInput-custom" type="email" required placeholder="Email" />

          <div class="relative">
            <label>Password</label>
            <p v-if="errorMessageLogin.password" class="error-message">{{ errorMessageLogin.password }}</p>
          </div>
          <input v-model="dataLogin.password" class="textInput-custom" type="password" required
            placeholder="Password" />

          <div class="mt-[8px] text-[14px] font-light">Forgot password?</div>

          <button class="login-btn-custom" @click="login()">Log In</button>
          <div class="flex justify-between mt-[20px]">
            <button class="register-btn-custom" @click="isLoginPage = !isLoginPage">Register</button>
            <button class="register-btn-custom" @click="$router.push('/')">Back</button>
          </div>
        </div>

        <!-- Register Form -->
        <div v-if="!isLoginPage">
          <h4 class="mb-[20px] text-[32px] font-medium leading-[42px] text-center">Register</h4>

          <div class="relative">
            <label>Email</label>
            <p v-if="errorMessageRegister.email" class="error-message">{{ errorMessageRegister.email }}</p>
          </div>
          <input v-model="dataRegister.email" class="textInput-custom" type="text" required placeholder="Email" />


          <div class="relative">
            <label>Password</label>
            <p v-if="errorMessageRegister.password" class="error-message">{{ errorMessageRegister.password }}</p>
          </div>
          <input v-model="dataRegister.password" class="textInput-custom" type="password" required
            placeholder="Password" />

          <div class="relative">
            <label>Fullname</label>
            <p v-if="errorMessageRegister.fullname" class="error-message">{{ errorMessageRegister.fullname }}</p>
          </div>
          <input v-model="dataRegister.fullname" class="textInput-custom" type="text" required placeholder="Fullname" />

          <button class="login-btn-custom" @click="register()">Register</button>
          <div class="flex justify-between mt-[20px]">
            <button class="register-btn-custom" @click="isLoginPage = !isLoginPage">Login</button>
            <button class="register-btn-custom" @click="$router.push('/')">Back</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import userAPI from '../apis/users'
import axios from 'axios'
export default {
  layout: "empty",
  meta: {
    auth: { authority: 0 }
  },
  data() {
    return {
      isLoginPage: true,
      dataLogin: {
        email: "",
        password: "",
      },
      errorMessageLogin: {
        email: "",
        password: "",
      },
      dataRegister: {
        email: "",
        password: "",
        fullname: "",
      },
      errorMessageRegister: {
        email: "",
        password: "",
        fullname: "",
      },
    }
  },
  created() {
    if (this.$auth.loggedIn) this.$router.push({ name: 'index' })
  },
  methods: {
    validateLogin() {
      const emailRegex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i
      this.errorMessageLogin.email = this.dataLogin.email.match(emailRegex) ? "" : "Please enter a valid email"
      this.errorMessageLogin.password = this.dataLogin.password ? "" : "This field is required"
    },
    validateRegister() {
      const emailRegex = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i
      this.errorMessageRegister.email = this.dataRegister.email.match(emailRegex) ? "" : "Please enter a valid email"
      this.errorMessageRegister.fullname = this.dataRegister.fullname ? "" : "This field is required"

      const password = this.dataRegister.password
      if (!password) this.errorMessageRegister.password = "This field is required"
      else {
        this.errorMessageRegister.password = (password.length < 6) ? "Password is too short" : ""
        this.errorMessageRegister.password = (password.length > 50) ? "Password is too long" : ""
      }
    },
    async login() {
      this.validateLogin()
      if (this.errorMessageLogin.email || this.errorMessageLogin.password) {
        this.$toast.error("Please enter valid data")
        return
      }

      try {
        let res = await this.$auth.loginWith('local', {
          data: this.dataLogin
        })

        this.$auth.strategy.token.set(res.data.accessToken)
        this.$auth.strategy.refreshToken.set(res.data.user.refresh_token)
        // this.$auth.setUserToken(res.data.accessToken, res.data.user.refresh_token)
        this.$auth.setUser(res.data.user)
        this.$toast.success("Hello, " + res.data.user.fullname);

        axios.defaults.headers.common['Authorization'] = `Bearer ${res.data.accessToken}`
      } catch (error) {
        this.$toast.error(error.response.data)
      }
    },
    async register() {
      this.validateRegister()
      if (this.errorMessageRegister.email || this.errorMessageRegister.password || this.errorMessageRegister.fullname) {
        this.$toast.error("Please enter valid data")
        return
      }
      try {
        const data = await userAPI.createUser({
          email: this.dataRegister.email,
          password: this.dataRegister.password,
          fullname: this.dataRegister.fullname,
        });
        if (data.newUser) {
          this.dataLogin = {
            email: this.dataRegister.email,
            password: this.dataRegister.password,
          }
          this.login()
        }
      } catch (error) {
        this.$toast.error(error.response.data)
      }
    }
  }
}
</script>

<style scoped>
.shape-custom {
  position: absolute;
  width: 200px;
  height: 200px;
  border-radius: 50%;
}

.shape-top-left-custom {
  top: -80px;
  left: -90px;
  background: linear-gradient(#1845ad, #23a2f6);
}

.shape-bottom-right-custom {
  right: -60px;
  bottom: -80px;
  background: linear-gradient(to right, #ff512f, #f09819);
}

label {
  display: block;
  margin-top: 20px;
  font-size: 16px;
  font-weight: 500;
}

.error-message {
  position: absolute;
  top: 0;
  right: 0;
  color: #cc3300;
  font-size: 12px;
  font-style: italic;
}

input.textInput-custom {
  display: block;
  width: 100%;
  height: 50px;
  padding: 0 10px;
  border-radius: 3px;
  margin-top: 8px;
  background-color: rgba(255, 255, 255, 0.07);
  font-size: 14px;
  font-weight: 300;
}

.login-btn-custom {
  width: 100%;
  padding: 12px 0;
  border-radius: 5px;
  margin-top: 20px;
  background-color: #ffffff;
  color: #080710;
  font-size: 18px;
  font-weight: 600;
  cursor: pointer;
}

.register-btn-custom {
  width: 150px;
  padding: 8px 0;
  border-radius: 3px;
  background-color: rgba(255, 255, 255, 0.27);
  text-align: center;
}
</style>