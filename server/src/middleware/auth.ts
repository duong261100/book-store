import { Request, Response, NextFunction } from 'express'
import jwt, { JwtPayload } from 'jsonwebtoken'
import { User } from '../models/User'

export const auth = async (req: Request, res: Response, next: NextFunction) => {
  const token = req.header('Authorization')?.replace('Bearer ', '')
  if (!token) return res.status(401).json({ message: 'Unauthorized' })
  else {
    try {
      const decoded = jwt.verify(token, process.env.ACCESS_TOKEN_SECRET as string) as JwtPayload
      const exp = decoded.exp
      if (!exp || Date.now() >= exp * 1000) {
        return res.status(401).json({ message: 'Unauthorized' })
      }
      const user: User | null = await User.findOne({
        where: {
          email: decoded.email,
        },
      })
      if (!user) return res.status(401).json({ message: 'Unauthorized' })
      req.user = user
      return next()
    } catch (error) {
      return res.status(401).json({ message: 'Unauthorized' })
    }
  }
}
