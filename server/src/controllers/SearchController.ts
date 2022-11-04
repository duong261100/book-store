import { RequestHandler } from 'express'
import { Op } from 'sequelize'

import { Author, Book, Category, Language, Publisher } from '../models/Model'

export const searchByParams: RequestHandler = async (req, res) => {
  const searchData = req.body.data
  // const { categoriesSelectedId, languageSelected, priceRange, titleSearch } = req.body.data

  // Default values
  const allCategories: Category[] = await Category.findAll()
  const allCategoriesId = allCategories.map((obj) => obj.category_id)
  const defaultPriceRange = [0, 9999999]

  const bookSearched: Book[] = await Book.findAll({
    where: {
      title: {
        [Op.like]: `%${searchData.titleSearch || ''}%`,
      },
      price: {
        [Op.or]: [
          {
            [Op.between]: searchData.priceRange || defaultPriceRange,
          },
        ],
      },
    },
    include: [
      {
        model: Category,
        where: {
          category_id: {
            [Op.in]: searchData.categoriesSelectedId || allCategoriesId,
          },
        },
      },
      {
        model: Publisher,
      },
      {
        model: Language,
        where: {
          language_name: {
            [Op.like]: `%${searchData.languageSelected || ''}%`,
          },
        },
      },
      {
        model: Author,
      },
    ],
  })
  return res.status(200).json(bookSearched)
}
