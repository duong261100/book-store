import axios, { AxiosResponse } from 'axios'

interface dataRegister {
  email: string
  password: string
  fullname: string
}

export default class API {
  static async createUser(dataRegister: dataRegister) {
    const res: AxiosResponse = await axios.post(
      '/users',
      dataRegister
    )
    return res.data
  }

  static async getUserDetail() {
    const res: AxiosResponse = await axios.get('/users/me')
    return res.data
  }

  static async updateUser(user: any) {
    const res: AxiosResponse = await axios.put(
      `/users/${user.user_id}`,
      user
    )
    return res.data
  }
}
