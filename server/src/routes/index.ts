import { Application } from 'express'
const authorRouter = require('./author')
const bookRouter = require('./book')
const categoryRouter = require('./category')
const languageRouter = require('./language')
const ratingRouter = require('./rating')
const searchRouter = require('./search')
const sessionRouter = require('./session')
const uploadRouter = require('./upload')
const userRouter = require('./user')

function router(app: Application) {
  app.use('/authors', authorRouter)
  app.use('/books', bookRouter)
  app.use('/categories', categoryRouter)
  app.use('/languages', languageRouter)
  app.use('/search', searchRouter)
  app.use('/rating', ratingRouter)
  app.use('/session', sessionRouter)
  app.use('/upload', uploadRouter)
  app.use('/users', userRouter)
}

export default router
