import { Router } from 'express'

import { getAllCategories } from '../controllers/CategoryController'

const router = Router()

router.get('/', getAllCategories)


module.exports = router
