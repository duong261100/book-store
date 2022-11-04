import { Router } from 'express'

import { getAllLanguages } from '../controllers/LanguageController'

const router = Router()

router.get('/', getAllLanguages)


module.exports = router
