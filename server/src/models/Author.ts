import { Table, Model, Column, DataType } from 'sequelize-typescript'

@Table({
  timestamps: false,
  tableName: 'author',
})
export class Author extends Model {
  @Column({
    type: DataType.INTEGER,
    primaryKey: true,
    autoIncrement: true,
  })
  author_id!: number

  @Column({
    type: DataType.STRING(50),
    allowNull: false,
    unique: true,
  })
  name!: string

  @Column({
    type: DataType.STRING(100),
  })
  image!: string

  @Column({
    type: DataType.TEXT,
  })
  description!: string
}
