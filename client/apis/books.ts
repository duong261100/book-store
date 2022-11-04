import axios, { AxiosResponse } from 'axios'

export default class API {
  static async getAllBooks() {
    const res:AxiosResponse = await axios.get('/books')
    return res.data
  }

  static async getBookById(id: number) {
    const res:AxiosResponse = await axios.get(`/books/${id}`)
    return res.data
  }

  static async getBookByAuthorId(id: number) {
    const res:AxiosResponse = await axios.get(`/books/authors/${id}`)
    return res.data
  }

  static async getBookWithRatingById(id: number) {
    const res:AxiosResponse = await axios.get(`/books/ratings/${id}`)
    return res.data
  }
}