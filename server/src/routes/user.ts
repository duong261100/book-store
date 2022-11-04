import { Router } from 'express'
import { auth } from '../middleware/auth'
import { createUser, getUserDetail, updateUser } from '../controllers/UserController'

const router = Router()

router.post('/', createUser)
router.get('/me', auth, getUserDetail)
router.put('/:id', auth, updateUser)

module.exports = router
