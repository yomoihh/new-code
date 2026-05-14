<template>
  <section class="index-container">
    <div class="index-shopInfo">
      <!-- 左侧图片 -->
      <div class="logo_container">
        <img :src="restaurant.image_path" alt>
      </div>
      <!-- 右侧内容 -->
      <div class="index_main">
        <!-- 第一行 品牌 -->
        <div class="index_shopname">
          <i v-if="restaurant.is_premium">品牌</i>
          <span>{{restaurant.name}}</span>
        </div>

        <!-- 第二行 星级 -->
        <div class="index-rateWrap">
          <div>
            <Rating :rating="restaurant.rating"/>
            <span class="rate">{{restaurant.rating}}</span>
            <span>月售{{restaurant.recent_order_num}}单</span>
          </div>
          <div v-if="restaurant.delivery_mode" class="delivery">
            <span class="icon-hollow">{{restaurant.delivery_mode.text}}</span>
          </div>
        </div>

        <!-- 第三行 配送 -->
        <div class="index-moneylimit">
          <div>
            <span>¥{{restaurant.float_minimum_order_amount}}起送</span>
            |
            <span>配送费¥{{restaurant.float_delivery_fee}}</span>
          </div>
          <div class="index-distanceWrap">
            <span>{{(restaurant.distance / 1000).toFixed(2)}}km</span>
            |
            <span>{{restaurant.order_lead_time}}分钟</span>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import "assets/css/indexShop.css"
import Rating from "./Rating.vue";
export default {
  name: "IndeShop",
  props: {
    restaurant: Object
  },
  components: {
    Rating
  }
};
</script>

<style>

</style>
