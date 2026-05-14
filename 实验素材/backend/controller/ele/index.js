import Mock from 'mockjs'
import restaurants from './restaurants';
import filterData from './filterData';
import batch_shop from './batch_shop_back';
import user from './user'
import comments from './comments'
import seller from './seller'
import orders from './orders';

class Elm {
    constructor() {
            this.sms_send = this.sms_send.bind(this);
        }
        // Login.vue /api/posts/sms_send
    async sms_send(req, res, next) {
            res.send({
                tpl_id: req.body.tpl_id,
                key: req.body.key,
                phone: req.body.phone
            })
        }
        // Login.vue /api/posts/sms_back
    async sms_back(req, res, next) {
        res.send({
            user: {
                _id: 1001
            },
            phone: req.body.phone,
            code: req.body.code
        })
    }

    // Home.vue /api/profile/shopping
    async shopping(req, res, next) {
        var swipeImgs = [
                "/imgs/banner_1.webp",
                "/imgs/banner_2.webp",
                "/imgs/banner_3.webp",
                "/imgs/banner_4.webp"
            ]
            // var swipeImgs = Mock.mock({
            //     'imgs|4': ['@image(300x250,@color)']
            // })
        var entries = Mock.mock({
            'foodItem|10': [{
                'image': '@image(50x50,@color)',
                'name': '@cname'
            }]
        })
        var foodItem = [{
                image: '/imgs/entries/1.png',
                name: '美食'
            },
            {
                image: '/imgs/entries/2.png',
                name: '美食美刻超市'
            },
            {
                image: '/imgs/entries/3.png',
                name: '生鲜果蔬'
            },
            {
                image: '/imgs/entries/4.png',
                name: '美食美刻专送'
            },
            {
                image: '/imgs/entries/5.png',
                name: '快食简餐'
            },
            {
                image: '/imgs/entries/6.png',
                name: '午餐优选'
            },
            {
                image: '/imgs/entries/7.png',
                name: '甜点饮品'
            },
            {
                image: '/imgs/entries/8.png',
                name: '家常菜'
            },
            {
                image: '/imgs/entries/9.png',
                name: '小吃馆'
            },
            {
                image: '/imgs/entries/10.png',
                name: '鲜花蛋糕'
            },
        ]
        var data = {
            'swipeImgs': swipeImgs,
            'entries': [foodItem, foodItem]
        }
        res.send(data)
    }

    // Home.vue /apit/profile/filter
    async filter(req, res, next) {
        res.send(filterData)
    }

    // Home.vue /api/profile/restaurants
    async restaurants(req, res, next) {
        console.log("page --> " + req.params.page + ",size --> " + req.params.size)
        res.send(restaurants)
    }

    // Shops/Shop.vue /api/profile/batch_shop
    async batch_shop(req, res, next) {
        res.send(batch_shop)
    }

    // Me.vue /api/user/user_info/:id
    async user_info(req, res, next) {
        res.send(user)
    }

    // Comments.vue /api/profile/comments
    async comments(req, res, next) {
        res.send(comments)
    }

    // Seller.vue /api/profile/seller
    async seller(req, res, next) {
        res.send(seller)
    }

    // Order.vue /api/user/orders/:user_id
    async orders(req, res, next) {
        console.log("user_id --> ", req.params.user_id)
        res.send(orders)
    }
}


export default new Elm();