import axios, { AxiosResponse } from 'axios'

export default class API {
  static async getAllCategories() {
    const res:AxiosResponse = await axios.get('/categories')
    return res.data
  } 
}