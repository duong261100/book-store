import { Table, Model, Column, DataType, BeforeSave, BelongsToMany } from 'sequelize-typescript'
import { Book, Rating } from './Model'
import bcrypt from 'bcrypt'
import jwt from 'jsonwebtoken'
import dotenv from 'dotenv'
const saltRounds = 8
dotenv.config()

@Table({
  timestamps: false,
  tableName: 'user',
})
export class User extends Model {
  @BelongsToMany(() => Book, () => Rating)
  books: Book[]

  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
    autoIncrement: true,
  })
  user_id!: number
  
  @Column({
    type: DataType.STRING(50),
    allowNull: false,
    unique: true,
  })
  email!: string

  @Column({
    type: DataType.TEXT,
    allowNull: false,
  })
  password!: string

  @Column({
    type: DataType.STRING(50),
  })
  fullname!: string

  @Column({
    type: DataType.TEXT,
  })
  image!: string

  @Column({
    type: DataType.STRING(200),
  })
  address!: string

  @Column({
    type: DataType.BOOLEAN,
    allowNull: false,
    defaultValue: 0,
  })
  is_activate!: boolean

  @Column({
    type: DataType.BOOLEAN,
    allowNull: false,
    defaultValue: 0,
  })
  is_admin!: boolean

  @Column({
    type: DataType.TEXT,
  })
  refresh_token!: string

  @Column({
    type: DataType.DATE,
    defaultValue: Date.now(),
  })
  created_at!: Date

  @BeforeSave
  static async hashPasswordBeforeSave(user: User) {
    if (user.changed('password')) {
      const salt = bcrypt.genSaltSync(saltRounds)
      user.password = await bcrypt.hash(user.password, salt)
    }
  }

  public generateRefreshToken = async (user: User) => {
    const refreshToken = jwt.sign({ email: user.email }, process.env.REFRESH_TOKEN_SECRET as string)
    user.refresh_token = refreshToken
    await user.save()
    return refreshToken
  }

  public generateAccessToken: any = async (user: User) => {
    const accessToken = jwt.sign({ email: user.email }, process.env.ACCESS_TOKEN_SECRET as string, {
      expiresIn: "10m",
    })
    return accessToken
  }
}
