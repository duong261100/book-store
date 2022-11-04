import { RequestHandler } from 'express'

import { Rating } from '../models/Model'

export const addRating: RequestHandler = async (req, res, next) => {
  try {
    const { user_id, book_id, rating, review } = req.body
    const findRating: Rating | null = await Rating.findOne({
      where: { user_id: user_id, book_id: book_id },
    } as Object)
    if (findRating) {
      return res.status(400).send('Bạn đã đánh giá sản phẩm này rồi')
    }

    const newRating = new Rating({
      user_id: user_id,
      book_id: book_id,
      rating: rating,
      review: review,
    })
    await newRating.save()
    res.status(201).send(newRating)
  } catch (error) {
    res.status(400).send(error)
  }
  return
}
