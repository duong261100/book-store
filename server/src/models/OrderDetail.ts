import { Table, Model, Column, DataType, ForeignKey } from 'sequelize-typescript'
import { Book, Order } from './Model'

@Table({
  timestamps: false,
  tableName: 'order_detail',
})
export class OrderDetail extends Model {
  @ForeignKey(() => Order)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
  })
  order_id!: number

  @ForeignKey(() => Book)
  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
  })
  book_id!: number

  @Column({
    type: DataType.INTEGER.UNSIGNED,
  })
  quantity!: number
}
