import express from 'express';
import Ele from '../controller/ele'

const router = express.Router();

// Login page

router.post('/posts/sms_send', Ele.sms_send)
router.post('/posts/sms_back', Ele.sms_back)

// Home page 
router.get('/profile/shopping', Ele.shopping)
router.get('/profile/filter', Ele.filter)
router.post('/profile/restaurants/:page/:size', Ele.restaurants)


// Shops page
router.get('/profile/batch_shop', Ele.batch_shop)

// Shop page --> comments
router.get('/profile/comments', Ele.comments)

// Shop page ---> seller
router.get('/profile/seller', Ele.seller)

// Me page
router.get('/user/user_info/:id', Ele.user_info)

// Order page
router.get('/user/orders/:user_id', Ele.orders)




export default router;