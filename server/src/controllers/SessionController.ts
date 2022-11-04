import { RequestHandler } from 'express'
import bcrypt from 'bcrypt'
import jwt, { JwtPayload } from 'jsonwebtoken'
import { User } from '../models/User'

let tokenList: Array<string> = []

export const login: RequestHandler = async (req, res) => {
  try {
    const user: User | null = await User.findOne({ where: { email: req.body.email } } as Object)
    if (!user) {
      return res.status(401).send('Tên đăng nhập không tồn tại')
    }

    const checkPassword = bcrypt.compareSync(req.body.password, user.password)
    if (!checkPassword) {
      return res.status(401).send('Mật khẩu không chính xác')
    }

    const accessToken = await user.generateAccessToken(user)
    tokenList.push(accessToken)
    res.status(201).json({ user, accessToken })
  } catch (error) {
    res.send(error)
  }
  return
}

export const logout: RequestHandler = async (req, res, next) => {
  const accessToken = req.header('Authorization')?.replace('Bearer ', '')
  tokenList = tokenList.filter((token) => token !== accessToken)
  res.sendStatus(204)
}

export const check: RequestHandler = async (req, res, next) => {
  res.send('tokenList: ' + tokenList.length)
}

export const refreshToken: RequestHandler = async (req, res) => {
  const { refresh_token } = req.body
  if (!refresh_token) return res.sendStatus(401)

  try {
    const data: any = jwt.verify(refresh_token, process.env.REFRESH_TOKEN_SECRET as string)
    const user: User | null = await User.findOne({
      where: {
        email: data.email as string | JwtPayload,
      },
    })
    if (user) {
      const accessToken = await user.generateAccessToken(user)
      return res.status(201).json({ accessToken })
    } else {
      return res.status(400).json({ message: 'authen failed' })
    }
  } catch (error) {
    return res.send(error)
  }
}
