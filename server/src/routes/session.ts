import { Router } from 'express'

import { login, logout, refreshToken, check } from '../controllers/SessionController'

const router = Router()

router.post('/', login)
router.delete('/', logout)
router.post('/refresh_token', refreshToken)
router.get('/check', check)


module.exports = router
