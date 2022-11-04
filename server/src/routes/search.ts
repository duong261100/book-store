import { Router } from 'express'

import { searchByParams } from '../controllers/SearchController'

const router = Router()

router.post('/', searchByParams)

module.exports = router
