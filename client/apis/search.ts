import axios, { AxiosResponse } from 'axios'

interface searchData {
  titleSearch: string,
  languageSelected: string,
  categoriesSelectedId: number,
  priceRange: Array<number>
}

export default class API {
  static async searchBooks(searchData: searchData) {
    const res: AxiosResponse = await axios.post('/search', {
      data: searchData
    })
    return res.data
  }
}