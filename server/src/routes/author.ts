import { Router } from 'express'

import { getAllAuthor, getAuthorById } from '../controllers/AuthorController'

const router = Router()

router.get('/', getAllAuthor)

router.get('/:id', getAuthorById)

module.exports = router
