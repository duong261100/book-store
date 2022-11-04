import { Table, Model, Column, DataType, BelongsToMany, BelongsTo, ForeignKey } from 'sequelize-typescript'
import { User, Status, Book, OrderDetail } from './Model'

@Table({
  timestamps: false,
  tableName: 'order',
})
export class Order extends Model {
  @BelongsToMany(() => Book, () => OrderDetail)
  books: Book[]

  @BelongsTo(() => Status)
  status: Status

  @BelongsTo(() => User)
  user: User

  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
    autoIncrement: true,
  })
  order_id!: number

  @ForeignKey(() => User)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
  })
  user_id!: number

  @Column({
    type: DataType.DATE,
    defaultValue: Date.now(),
  })
  order_date!: Date

  @Column({
    type: DataType.TEXT,
  })
  description!: string

  @ForeignKey(() => Status)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
  })
  status_id!: number
}
