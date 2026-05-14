<template>
  <div class="order">
    <div class="order-card-body" v-for="(order,index) in orderlist" :key="index">
      <div
        class="order-card-wrap"
      >
        <img :src="order.restaurant_image_url" alt>
        <div class="order-card-content">
          <div class="order-card-head">
            <div class="title">
              <a>
                <span>{{order.restaurant_name}}</span>
                <i class="fa fa-angle-right"></i>
              </a>
              <p>订单已完成</p>
            </div>
            <p class="date-time">{{order.formatted_created_at}}</p>
          </div>
          <div class="order-card-detail">
            <p class="detail">{{order.basket.group[0][0].name}}</p>
            <p class="price">¥{{order.total_amount}}</p>
          </div>
        </div>
      </div>
      <div class="order-card-bottom">
        <button class="cardbutton">再来一单</button>
      </div>
    </div>
  </div>
</template>

<script>
import "assets/css/order.css"
export default {
  name: "order",
  data() {
    return {
      orderlist: []
    };
  },
  beforeRouteEnter(to, from, next) {
    next(vm => {
      vm.getData();
    });
  },
  methods: {
    getData() {
      this.axios.get(`/api/user/orders/${localStorage.ele_login}`).then(res => {
        this.orderlist = res.data.orderlist;
      });
    }
  }
};
</script>

<style>

</style>
