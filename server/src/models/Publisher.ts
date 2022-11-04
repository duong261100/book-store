import { Table, Model, Column, DataType, HasMany } from 'sequelize-typescript'
import { Book } from './Model'

@Table({
  timestamps: false,
  tableName: 'publisher',
})
export class Publisher extends Model {
  @HasMany(() => Book)
  books: Book[]

  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
    autoIncrement: true,
  })
  publisher_id!: number

  @Column({
    type: DataType.STRING(50),
    allowNull: false,
    unique: true,
  })
  name!: string
}
