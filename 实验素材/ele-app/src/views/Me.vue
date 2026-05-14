<template>
  <div class="me">
    <div class="headInfo">
      <div class="head-img"></div>
      <div class="head-profile">
        <p class="user-id" v-if="userInfo">{{ userInfo._id }}</p>
        <p v-else class="user-id" @click="handleLogin">登录/注册</p>
        <p class="user-phone">
          <i class="fa fa-mobile"></i>
          <span v-if="userInfo">{{ encryptPhone(userInfo.phone) }}</span>
          <span v-else>登录后享受更多特权</span>
        </p>
      </div>
      <i class="fa fa-angle-right"></i>
    </div>
    <div class="maininfo">
      <a href="javascript:;" class="bounes">
        <p>
          <span class="hongbao-num" style="color: rgb(255, 95, 62)">0</span
          ><span class="hongbao-type" style="color: rgb(255, 95, 62)">个</span>
        </p>
        <p class="type">红包</p>
      </a>
      <a href="javascript:;" class="bounes">
        <p>
          <span class="hongbao-num" style="color: rgb(106, 194, 11)">0</span
          ><span class="hongbao-type" style="color: rgb(106, 194, 11)">个</span>
        </p>
        <p class="type">金币</p>
      </a>
    </div>
    <div v-if="userInfo">
      <div class="address-cell">
        <i class="fa fa-map-marker"></i>
        <div class="address-index">
          <span>我的地址</span>
          <i class="fa fa-angle-right"></i>
        </div>
      </div>
      <div class="address-cell">
        <i class="fa fa-shopping-bag"></i>
        <div class="address-index">
          <span>金币商城</span>
          <i class="fa fa-angle-right"></i>
        </div>
      </div>
      <div class="address-cell">
        <i class="fa fa-comments"></i>
        <div class="address-index">
          <span>我的客服</span>
          <i class="fa fa-angle-right"></i>
        </div>
      </div>
      <div class="address-cell">
        <i class="fa fa-cloud-download"></i>
        <div class="address-index">
          <span>下载美食美刻APP</span>
          <i class="fa fa-angle-right"></i>
        </div>
      </div>
      <div class="address-cell">
        <i class="fa fa-file-text-o"></i>
        <div class="address-index">
          <span>规则中心</span>
          <i class="fa fa-angle-right"></i>
        </div>
      </div>
      <button @click="handleLogout" class="loginOut-btn">退出登录</button>
    </div>
  </div>
</template>
<script>
import "assets/css/me.css"
export default {
  name: "me",
  data() {
    return {
      userInfo: "",
    };
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => vm.getData());
  },
  methods: {
    handleLogin() {
      this.$router.push("/login");
    },
    getData() {
      const user_id = localStorage.ele_login;
      this.axios.get(`/api/user/user_info/${user_id}`).then((res) => {
        this.userInfo = res.data;
      });
    },
    encryptPhone(phone) {
      return phone.replace(/(\d{3})\d{4}(\d{4})/, "$1****$2");
    },
    handleLogout() {
      localStorage.removeItem("ele_login");
      this.$router.push("/login");
    },

  },
};
</script>
<style>

</style>
