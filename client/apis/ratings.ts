import axios, { AxiosResponse } from 'axios'

export default class API {
  static async addRating(dataRating: any) {
    const res: AxiosResponse = await axios.post(
      '/rating',
      dataRating
    )
    return res.data
  }
}
