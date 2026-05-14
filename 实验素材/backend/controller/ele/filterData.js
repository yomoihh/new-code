import Mock from 'mockjs'

export default {
    'navTab': [{
            'name': '综合排序',
            'icon': 'caret-down'
        },
        {
            'name': '距离最近',
            'condition': 'distance'
        },
        {
            'name': '品质联盟',
            'condition': 'is_premium'
        },
        {
            'name': '筛选',
            'icon': 'filter'
        }
    ],
    'screenBy': [{
            'data': [{
                    'code': 'delivery_mode',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '蜂鸟专送',
                    'select': false
                },
                {
                    'code': 'brank_mode',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '品牌商家',
                    'select': false
                },
                {
                    'code': 'brank_mode',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '新店',
                    'select': false
                },
                {
                    'code': 'brank_mode',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '食安保',
                    'select': false
                },
                {
                    'code': 'brank_mode',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '开发票',
                    'select': false
                }
            ],
            'id': 'MPI',
            'title': '商家服务（可多选）'
        },
        {
            'data': [{
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '首单立减',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '门店新客立减',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '满减优惠',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '下单返红包',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '进店红包',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '配送费优惠',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '赠品优惠',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '特价商品',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '品质联盟红包',
                    'select': false
                }
            ],
            'id': 'offer',
            'title': '优惠活动（单选）'
        },
        {
            'data': [{
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '￥20以下',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '￥20-￥40',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '￥40-￥60',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '￥60-￥80',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '￥80-￥100',
                    'select': false
                },
                {
                    'code': '',
                    'icon': Mock.Random.image('60x60', Mock.Random.color()),
                    'name': '￥100以上',
                    'select': false
                }
            ],
            'id': 'per',
            'title': '人均消费'
        }
    ],
    'sortBy': [{
            'name': '综合排序',
            'check': 'false',
            'code': ''
        },
        {
            'name': '好评优先',
            'check': 'false',
            'code': ''
        },
        {
            'name': '销量最高',
            'check': 'false',
            'code': ''
        },
        {
            'name': '起送价最低',
            'check': 'false',
            'code': ''
        },
        {
            'name': '配送最快',
            'check': 'false',
            'code': ''
        },
        {
            'name': '配送费最低',
            'check': 'false',
            'code': ''
        },
        {
            'name': '人均从低到高',
            'check': 'false',
            'code': ''
        },
        {
            'name': '人均从高到低',
            'check': 'false',
            'code': ''
        },
        {
            'name': '通用排序',
            'check': 'false',
            'code': ''
        }
    ]
}