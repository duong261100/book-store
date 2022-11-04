import express, { Application } from 'express'
import cors from 'cors'
import dotenv from 'dotenv'
import bodyParser from 'body-parser'
import { sequelize } from '../config/mysql'
import router from './routes/index'

dotenv.config()
const app: Application = express()
app.use(cors())

/** Parse the body of the request */
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())

const host = process.env.SERVER_HOSTNAME || 'localhost'
const port = process.env.SERVER_PORT || 3001

app.use((err: Error, req: express.Request, res: express.Response, next: express.NextFunction) => {
  res.status(500).json({ message: err.message })
})

router(app)

app.listen(port, () => {
  console.log(`🚀Server listening at http://${host}:${port}`)
  sequelize
    .authenticate()
    .then(() => console.log('Authenticated'))
    .catch((e: any) => console.log('Error: ', e))
})
