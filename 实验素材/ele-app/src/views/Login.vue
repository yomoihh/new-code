<template>
  <div class="login">
    <div class="logo">
      <img src="../assets/food.png" alt="my login image" />
    </div>
    <!-- 手机号 -->
    <div class="text_group">
      <div class="input_group" :class="{ 'is-invalid': errors.phone }">
        <!-- 输入框 -->
        <input type="text" placeholder="手机号" name="phone" v-model="phone" />
        <!-- 输入框后面的按钮 -->
        <button :disabled="disabled" @click="getVerifyCode">
          {{ btnTitle }}
        </button>
      </div>
      <!-- 错误提醒 -->
      <div v-if="errors.phone" class="invalid-feedback">{{ errors.phone }}</div>
    </div>

    <!-- 验证码 -->
    <div class="text_group">
      <div class="input_group">
        <!-- 输入框 -->
        <input
          type="text"
          placeholder="验证码"
          name="VerifyCode"
          v-model="verifyCode"
        />
      </div>
    </div>

    <!-- 用户服务协议 -->
    <div class="login_des">
      <p>
        新用户登录即自动注册，表示已同意
        <span>《用户服务协议》</span>
      </p>
    </div>

    <!-- 登录按钮 -->
    <div class="login_btn">
      <button :disabled="isClick" @click="handleLogin">登录</button>
    </div>
  </div>
</template>

<script>
// 导入组件css样式代码
import "../assets/css/login.css";
import { Toast } from "vant";
export default {
  name: "login",
  data() {
    return {
      phone: "",  // 手机号码
      verifyCode: "", // 验证码
      errors: {}, // 错误提示信息
      disabled: false, // 禁用获取验证码按钮，防止短时间内重复获取
      btnTitle: "获取验证码", // 提示信息
    };
  },
  computed: {
    // 验证手机号及验证码 计算是允许登录
    isClick() {
      console.log(!this.phone, !this.verifyCode);
      if (!this.phone || !this.verifyCode) return true;
      else return false;
    },
  },
  methods: {
    handleLogin() { // 登录业务逻辑代码
      // 取消错误提醒
      this.errors = {};
      // 发送请求
      this.axios
        .post("/api/posts/sms_back", {
          phone: this.phone,
          code: this.verifyCode,
        })
        .then((res) => {
          // console.log(res.data);
          // 检验成功 设置登录状态并且跳转到/
          localStorage.setItem("ele_login", res.data.user._id);
          this.$router.push("/");
        })
        .catch((err) => {
          // 返回错误信息
          this.errors = {
            code: err.response,
          };
        });
    },
    getVerifyCode() { // 后端接口获取验证码
      if (this.validatePhone()) {
        this.validateBtn();
        // 发送网络请求
        this.axios
          .post("/api/posts/sms_send", {
            tpl_id: "140481",
            key: "795be723dd9e88c3ea98e2b6713ab795",
            phone: this.phone,
          })
          .then((res) => {});
      }
    },
    validateBtn() { // 更新获取验证码按钮状态及提示信息
      let time = 60;
      let timer = setInterval(() => {
        if (time == 0) {
          clearInterval(timer);
          this.btnTitle = "获取验证码";
          this.disabled = false;
        } else {
          // 倒计时
          this.btnTitle = time + "秒后重试";
          this.disabled = true;
          time--;
        }
      }, 1000);
    },
    validatePhone() { // 验证手机号码
      if (!this.phone) {
        this.errors = {
          phone: "手机号码不能为空",
        };
        return false;
      } else if (!/^1[345678]\d{9}$/.test(this.phone)) {
        this.errors = {
          phone: "请填写正确的手机号码",
        };
        return false;
      } else {
        this.errors = {};
        return true;
      }
    },
  },
};
</script>

<style scoped>
</style>
