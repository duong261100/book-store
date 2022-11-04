import { RequestHandler } from 'express'
import { User } from '../models/User'

export const createUser: RequestHandler = async (req, res, next) => {
  try {
    const user: User | null = await User.findOne({ where: { email: req.body.email } } as Object)
    if (user) {
      return res.status(400).send('Tên đăng nhập đã tồn tại')
    }

    const newUser = new User(req.body)
    await newUser.save()
    const accessToken = await newUser.generateAccessToken(newUser)
    const refreshToken = await newUser.generateRefreshToken(newUser)
    res.status(201).send({ newUser, accessToken, refreshToken })
  } catch (error) {
    res.send(error)
  }
  return
}

export const getUserDetail: RequestHandler = async (req, res, next) => {
  res.send(req.user)
}

export const updateUser: RequestHandler = async (req, res, next) => {
  const user: User = req.body
  const findUser: User | null = await User.findByPk(user.user_id)
  if (!findUser) return res.status(400).send('Something went wrong')
  try {
    await findUser.update({
      fullname: user.fullname,
      image: user.image,
      address: user.address,
    })
    return res.status(200).json(user)
  } catch (error) {
    return res.status(400).send(error)
  }
}
