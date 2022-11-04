import axios, { AxiosResponse } from 'axios'

export default class API {
  static async login() {
    const res:AxiosResponse = await axios.post('/session')
    return res.data
  }

  static async logout() {
    const res:AxiosResponse = await axios.delete('/session')
    return res.data
  }

  static async refreshToken() {
    const res:AxiosResponse = await axios.post('/session/refresh_token')
    return res.data
  } 
}