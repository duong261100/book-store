import axios from 'axios'

axios.defaults.baseURL = 'http://localhost:3001'
axios.interceptors.response.use(
  (res) => res,
  async (err) => {
    const code = parseInt(err.response && err.response.status)

    // return other errors
    if (code !== 401) {
      return new Promise((resolve, reject) => {
        reject(err)
      })
    }

    // error on login
    if (err.response.config.url === '/session/login') {
      return new Promise((resolve, reject) => {
        reject(err)
      })
    }

    // error on refresh
    if (err.response.config.url === '/session/refresh') {
      return new Promise((resolve, reject) => {
        reject(err)
      })
    }

    // refresh
    const refreshToken = localStorage.getItem('auth._refresh_token.local')
    return axios
      .post('/session/refresh_token', {
        refresh_token: refreshToken,
      })
      .then((response) => {
        err.response.config.headers['Authorization'] =
          'Bearer ' + response.data.accessToken
        return axios(err.response.config)
      })
      .catch((error) => {
        return Promise.reject(error)
      })
  }
)
