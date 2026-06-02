// ==========================================
// 默认数据模块
// 职责：提供 App 内置的轮播、咖啡卡片、产品默认数据
// ==========================================

import 'package:flutter/material.dart';

class DefaultData {
  static const defaultGradient1 = [Color(0xFF6B4423), Color(0xFF3E2515)];
  static const defaultGradient2 = [Color(0xFF2C2420), Color(0xFF1A1410)];
  static const defaultGradient3 = [Color(0xFF5D4037), Color(0xFF3E2723)];

  static const banners = [
    {
      'id': '1',
      'title': '手冲埃塞俄比亚',
      'subtitle': '花香调 · 明亮果酸 · 柔顺口感',
      'tag': '新品上市',
      'image': '',
      'gradient': defaultGradient1,
    },
    {
      'id': '2',
      'title': '冷萃哥伦比亚',
      'subtitle': '巧克力风味 · 低酸度 · 醇厚顺滑',
      'tag': '热卖推荐',
      'image': '',
      'gradient': defaultGradient2,
    },
    {
      'id': '3',
      'title': '单品意式拼配',
      'subtitle': '坚果香 · 焦糖甜感 · 浓郁醇厚',
      'tag': '限定特供',
      'image': '',
      'gradient': defaultGradient3,
    },
  ];

  static const coffeeCards = [
    {
      'id': '1',
      'name': '肯尼亚 AA',
      'desc': '明亮的黑醋栗与柑橘风味，层次分明，余韵悠长',
      'origin': '非洲 · 肯尼亚',
      'roast': '浅烘',
      'image': '',
    },
    {
      'id': '2',
      'name': '埃塞俄比亚 耶加雪菲',
      'desc': '茉莉花香与柠檬酸质，如花茶般清爽细腻',
      'origin': '非洲 · 埃塞俄比亚',
      'roast': '浅烘',
      'image': '',
    },
    {
      'id': '3',
      'name': '哥伦比亚 蕙兰',
      'desc': '焦糖甜感与坚果香气，醇厚平衡的经典之选',
      'origin': '南美 · 哥伦比亚',
      'roast': '中烘',
      'image': '',
    },
    {
      'id': '4',
      'name': '云南 小粒咖啡',
      'desc': '国货精品，红糖甜香与淡淡果韵，柔和不失个性',
      'origin': '亚洲 · 中国云南',
      'roast': '中深烘',
      'image': '',
    },
    {
      'id': '5',
      'name': '印尼 曼特宁',
      'desc': '草本醇香与黑巧克力尾韵，口感厚重顺滑',
      'origin': '亚洲 · 苏门答腊',
      'roast': '深烘',
      'image': '',
    },
    {
      'id': '6',
      'name': '哥斯达黎加 塔拉珠',
      'desc': '蜂蜜甜感与热带水果风味，干净明亮的回甘',
      'origin': '中美 · 哥斯达黎加',
      'roast': '中烘',
      'image': '',
    },
  ];

  static const products = [
    {
      'id': '1',
      'name': '肯尼亚 AA',
      'price': '¥68',
      'category': '非洲',
      'origin': '肯尼亚',
      'roast': '浅烘',
      'image': '',
      'desc': '明亮的黑醋栗与柑橘风味',
    },
    {
      'id': '2',
      'name': '埃塞俄比亚 耶加雪菲',
      'price': '¥78',
      'category': '非洲',
      'origin': '埃塞俄比亚',
      'roast': '浅烘',
      'image': '',
      'desc': '茉莉花香与柠檬酸质',
    },
    {
      'id': '3',
      'name': '哥伦比亚 蕙兰',
      'price': '¥65',
      'category': '南美',
      'origin': '哥伦比亚',
      'roast': '中烘',
      'image': '',
      'desc': '焦糖甜感与坚果香气',
    },
    {
      'id': '4',
      'name': '巴西 喜拉多',
      'price': '¥55',
      'category': '南美',
      'origin': '巴西',
      'roast': '中烘',
      'image': '',
      'desc': '柔和顺滑，经典风味',
    },
    {
      'id': '5',
      'name': '危地马拉 安提瓜',
      'price': '¥72',
      'category': '中美',
      'origin': '危地马拉',
      'roast': '中深烘',
      'image': '',
      'desc': '浓郁巧克力风味',
    },
    {
      'id': '6',
      'name': '哥斯达黎加 塔拉珠',
      'price': '¥85',
      'category': '中美',
      'origin': '哥斯达黎加',
      'roast': '中烘',
      'image': '',
      'desc': '蜂蜜甜感与热带水果',
    },
    {
      'id': '7',
      'name': '云南 小粒咖啡',
      'price': '¥48',
      'category': '亚洲',
      'origin': '中国云南',
      'roast': '中深烘',
      'image': '',
      'desc': '国货精品，红糖甜香',
    },
    {
      'id': '8',
      'name': '印度尼西亚 曼特宁',
      'price': '¥69',
      'category': '亚洲',
      'origin': '苏门答腊',
      'roast': '深烘',
      'image': '',
      'desc': '草本醇香与黑巧克力',
    },
    {
      'id': '9',
      'name': '秘鲁 禅茶玛悠',
      'price': '¥62',
      'category': '南美',
      'origin': '秘鲁',
      'roast': '中烘',
      'image': '',
      'desc': '干净明亮的酸甜平衡',
    },
    {
      'id': '10',
      'name': '卢旺达 基伍湖',
      'price': '¥75',
      'category': '非洲',
      'origin': '卢旺达',
      'roast': '浅烘',
      'image': '',
      'desc': '莓果风味，层次丰富',
    },
  ];
}
