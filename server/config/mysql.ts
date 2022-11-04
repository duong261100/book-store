import { Sequelize } from 'sequelize-typescript'
import config from './config'
import {
  Author,
  Book,
  BookCategory,
  Category,
  Language,
  Order,
  OrderDetail,
  Publisher,
  Rating,
  Status,
  User,
} from '../src/models/Model'

export const sequelize = new Sequelize({
  dialect: 'mysql',
  host: config.mysql.host,
  username: config.mysql.user,
  password: config.mysql.password,
  database: config.mysql.database,
  logging: false,
  models: [Author, Book, BookCategory, Category, Language, Order, OrderDetail, Publisher, Rating, Status, User],
})
