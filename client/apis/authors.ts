import axios, { AxiosResponse } from 'axios'

export default class API {
  static async getAllAuthors() {
    const res:AxiosResponse = await axios.get('/authors')
    return res.data
  }

  static async getAuthorById(id: number) {
    const res:AxiosResponse = await axios.get(`/authors/${id}`)
    return res.data
  } 
}