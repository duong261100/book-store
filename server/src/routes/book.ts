import { Router } from 'express'

import { createBook, deleteBook, getAllBooks, getBooksByAuthor, getBooksByCategory, getBooksByLanguage, getBookById, getBookWithRatingById, updateBook } from '../controllers/BookController'

const router = Router()

router.post('/', createBook)

router.get('/', getAllBooks)

router.get('/:id', getBookById)

router.get('/authors/:id', getBooksByAuthor)

router.get('/genres/:id', getBooksByCategory)

router.get('/languages/:id', getBooksByLanguage)

router.get('/ratings/:id', getBookWithRatingById)

router.put('/:id', updateBook)

router.delete('/:id', deleteBook)

module.exports = router
