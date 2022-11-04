import { Router } from 'express'

import { addRating } from '../controllers/RatingController'

const router = Router()

router.post('/', addRating)


module.exports = router
