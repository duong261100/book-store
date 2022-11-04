import { Router } from 'express'
const router = Router()

// Multer for upload image
const multer = require('multer')
const upload = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 10 * 1024 * 1024 },
})

// Initialize Firebase
const admin = require('firebase-admin')
// import ref from 'firebase/storage'
const serviceAccount = require('../../config/firebase-key.json')
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: process.env.STORAGE_BUCKET,
})
const bucket = admin.storage().bucket()

// route upload image
router.post('/', upload.single('file'), async (req, res): Promise<any> => {
  if (!req.file) {
    return res.status(400).send('Error: No files found')
  }

  const imageName = Date.now() + '.' + req.file.originalname.split('.')[0]

  const blob = bucket.file(imageName)

  // get image's url
  const signedURLconfig = { action: 'read', expires: '01-01-2030' }
  const signedURLArray = await blob.getSignedUrl(signedURLconfig)
  const url = signedURLArray[0]

  // create stream upload image
  const blobWriter = blob.createWriteStream({
    metadata: {
      contentType: req.file.mimetype,
    },
  })

  blobWriter.on('error', (err: any) => {
    res.status(400).send(err)
  })

  blobWriter.on('finish', () => {
    res.status(200).send(url)
  })

  blobWriter.end(req.file.buffer)
})

router.post('/delete', async (req, res) => {
  const imageURL: string = req.body.image
  const imagePath = imageURL.substring(imageURL.indexOf('appspot.com/') + 12, imageURL.lastIndexOf('?'))
  const file = bucket.file(imagePath)
  await file.delete()
  res.status(201).send("Update successfully")
})

module.exports = router
