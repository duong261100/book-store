import { Table, Model, Column, DataType, HasMany } from 'sequelize-typescript'
import { Order } from './Model'

@Table({
  timestamps: false,
  tableName: 'status',
})
export class Status extends Model {
  @HasMany(() => Order)
  orders: Order[]

  @Column({
    type: DataType.INTEGER.UNSIGNED,
    primaryKey: true,
    autoIncrement: true,
  })
  status_id!: number

  @Column({
    type: DataType.STRING(50),
    allowNull: false,
    unique: true,
  })
  name!: string
}
