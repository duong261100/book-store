import { Table, Model, Column, DataType, HasMany } from 'sequelize-typescript'
import { Book } from './Model'

@Table({
  timestamps: false,
  tableName: 'language',
})
export class Language extends Model {
  @HasMany(() => Book)
  books: Book[]

  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
    autoIncrement: true,
  })
  language_id!: number

  @Column({
    type: DataType.STRING(50),
    allowNull: false,
    unique: true,
  })
  language_name!: string
}
