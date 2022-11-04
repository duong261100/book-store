import { Table, Model, Column, DataType, ForeignKey } from 'sequelize-typescript'
import { Book, Category } from './Model'

@Table({
  timestamps: false,
  tableName: 'book_category',
})
export class BookCategory extends Model {
  @ForeignKey(() => Book)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
  })
  book_id!: number

  @ForeignKey(() => Category)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
  })
  category_id!: number
}
