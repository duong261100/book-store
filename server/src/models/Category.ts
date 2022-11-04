import { Table, Model, Column, DataType, BelongsToMany } from 'sequelize-typescript'
import { Book, BookCategory } from './Model'

@Table({
  timestamps: false,
  tableName: 'category',
})
export class Category extends Model {
  @BelongsToMany(() => Book, () => BookCategory)
  books: Book[]

  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
    autoIncrement: true,
  })
  category_id!: number

  @Column({
    type: DataType.STRING(50),
    allowNull: false,
    unique: true,
  })
  name!: string
}
