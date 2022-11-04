import { Table, Model, Column, DataType, ForeignKey } from 'sequelize-typescript'
import { User, Book } from './Model'

@Table({
  timestamps: false,
  tableName: 'rating',
})
export class Rating extends Model {
  @ForeignKey(() => User)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
  })
  user_id!: number

  @ForeignKey(() => Book)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
  })
  book_id!: number

  @Column({
    type: DataType.INTEGER.UNSIGNED,
    allowNull: false,
    validate: {
      min: 0,
      max: 5,
    },
  })
  rating!: number

  @Column({
    type: DataType.TEXT,
  })
  review!: string

  @Column({
    type: DataType.DATE,
    defaultValue: DataType.NOW
  })
  date_time!: string
}
