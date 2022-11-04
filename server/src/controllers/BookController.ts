import { RequestHandler } from 'express'

import { Author, Book, Category, Language, Publisher, User } from '../models/Model'

export const createBook: RequestHandler = async (req, res, next) => {
  var book = await Book.create({ ...req.body })
  return res.status(200).json(book)
}

export const deleteBook: RequestHandler = async (req, res, next) => {
  const { id } = req.params
  const deleteBook: Book | null = await Book.findByPk(id)
  await Book.destroy({ where: { id } })
  return res.status(200).json(deleteBook)
}

export const getAllBooks: RequestHandler = async (req, res, next) => {
  const allBooks: Book[] = await Book.findAll({
    include: [
      {
        model: Author,
      },
      {
        model: Category,
      },
      {
        model: Language,
      },
      {
        model: Publisher,
      },
    ],
  })
  return res.status(200).json(allBooks)
}

export const getBooksByAuthor: RequestHandler = async (req, res, next) => {
  const { id } = req.params
  const books: Book[] | null = await Book.findAll({
    where: {
      author_id: id,
    },
    include: [
      {
        model: Category,
      },
      {
        model: Publisher,
      },
      {
        model: Language,
      },
      {
        model: Author,
      },
    ],
  })
  return res.status(200).json(books)
}

export const getBooksByCategory: RequestHandler = async (req, res, next) => {
  const { id } = req.params
  const books: Book | null = await Book.findByPk(id, {
    include: [
      {
        model: Category,
      },
      {
        model: Publisher,
      },
      {
        model: Language,
      },
      {
        model: Author,
      },
    ],
  })
  return res.status(200).json(books)
}

export const getBooksByLanguage: RequestHandler = async (req, res, next) => {
  const { id } = req.params
  const books: Book[] | null = await Book.findAll({
    where: {
      language_id: id,
    },
    include: [
      {
        model: Category,
      },
      {
        model: Publisher,
      },
      {
        model: Language,
      },
      {
        model: Author,
      },
    ],
  })
  return res.status(200).json(books)
}

export const getBookById: RequestHandler = async (req, res, next) => {
  const { id } = req.params
  const book: Book | null = await Book.findByPk(id, {
    include: [
      {
        model: Category,
      },
      {
        model: Publisher,
      },
      {
        model: Language,
      },
      {
        model: Author,
      },
    ],
  })
  return res.status(200).json(book)
}

export const getBookWithRatingById: RequestHandler = async (req, res, next) => {
  const { id } = req.params
  const book: Book | null = await Book.findByPk(id, {
    include: [
      {
        model: User,
      },
      {
        model: Category,
      },
      {
        model: Publisher,
      },
      {
        model: Language,
      },
      {
        model: Author,
      },
    ],
  })
  return res.status(200).json(book)
}

export const updateBook: RequestHandler = async (req, res, next) => {
  const { id } = req.params
  await Book.update({ ...req.body }, { where: { id } })
  const updatedBook: Book | null = await Book.findByPk(id)
  return res.status(200).json(updatedBook)
}
