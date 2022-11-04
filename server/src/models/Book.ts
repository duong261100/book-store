import { Table, Model, Column, DataType, BelongsToMany, BelongsTo, ForeignKey } from 'sequelize-typescript'
import { Author, BookCategory, Category, Publisher, Language, Order, OrderDetail, Rating, User } from './Model'

@Table({
  timestamps: false,
  tableName: 'book',
})
export class Book extends Model {
  @BelongsToMany(() => Category, () => BookCategory)
  categories: Category[]

  @BelongsToMany(() => Order, () => OrderDetail)
  orders: Order[]

  @BelongsTo(() => Publisher)
  publisher: Publisher

  @BelongsTo(() => Author)
  author: Author

  @BelongsTo(() => Language)
  language: Language

  @BelongsToMany(() => User, () => Rating)
  users: User[]

  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
    autoIncrement: true,
  })
  book_id!: number

  @ForeignKey(() => Author)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
  })
  author_id!: number

  @ForeignKey(() => Publisher)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
  })
  publisher_id!: number

  @ForeignKey(() => Language)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
  })
  language_id!: number

  @Column({
    type: DataType.STRING(200),
  })
  title!: string

  @Column({
    type: DataType.STRING(100),
  })
  image!: string

  @Column({
    type: DataType.DECIMAL,
    allowNull: false,
    defaultValue: 0,
  })
  price!: number

  @Column({
    type: DataType.INTEGER.UNSIGNED,
    allowNull: false,
    defaultValue: 0,
  })
  stock!: number

  @Column({
    type: DataType.FLOAT(2, 1).UNSIGNED,
    defaultValue: 0,
  })
  rating!: number

  @Column({
    type: DataType.INTEGER.UNSIGNED,
    defaultValue: 0,
  })
  rating_count!: number

  @Column({
    type: DataType.TEXT,
  })
  description!: string

  @Column({
    type: DataType.DATE,
  })
  publication_date!: Date
}
