import axios, { AxiosResponse } from 'axios'

export default class API {
  static async getAllLanguages() {
    const res:AxiosResponse = await axios.get('/languages')
    return res.data
  } 
}