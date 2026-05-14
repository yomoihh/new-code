<template>
  <div class="home">
    <div class="header">
      <div class="address_map">
        <i class="fa fa-map-marker"></i>
        <span>{{ address }}</span>
        <i class="fa fa-sort-desc"></i>
      </div>
    </div>
    <div class="search_wrap" :class="{ fixedview: showFilter }">
      <div class="shop_search">
        <i class="fa fa-search"></i>
        搜索商家 商家名称
      </div>
    </div>
    <div id="container">
      <!-- 轮播 -->
      <van-swipe class="swiper" :autoplay="3000" indicator-color="white">
        <van-swipe-item v-for="(img, index) in swipeImgs" :key="index">
          <img :src="img" alt />
        </van-swipe-item>
      </van-swipe>

      <!-- 分类 -->
      <van-swipe :auto="0" class="entries">
        <van-swipe-item
          v-for="(entry, i) in entries"
          :key="i"
          class="entry_wrap"
        >
          <div class="foodentry" v-for="(item, index) in entry" :key="index">
            <div class="img_wrap">
              <img :src="item.image" alt />
            </div>
            <span>{{ item.name }}</span>
          </div>
        </van-swipe-item>
      </van-swipe>
    </div>
    <!-- 推荐商家 -->
    <div class="shoplist-title">推荐商家</div>

    <!-- 导航 -->
    <FilterView
      :filterData="filterData"
      @searchFixed="showFilterView"
      @update="update"
    />
    <!-- 商家信息 -->
    <!--mescroll滚动区域的基本结构-->
    <mescroll-vue
      ref="mescroll"
      :down="mescrollDown"
      :up="mescrollUp"
      @init="mescrollInit"
    >
      <div class="shoplist">
        <IndexShop
          v-for="(item, index) in restaurants"
          :key="index"
          :restaurant="item.restaurant"
        />
      </div>
    </mescroll-vue>
  </div>
</template>

<script>
import "assets/css/home.css";
// 引入mescroll的vue组件
import MescrollVue from "mescroll.js/mescroll.vue";
import FilterView from "comp/FilterView.vue";
import IndexShop from "comp/IndexShop.vue";
// 引入Mockjs用于模拟数据
import Mock from "mockjs";

export default {
  name: "home",
  data() {
    return {
      swipeImgs: [],
      entries: [],
      filterData: null,
      showFilter: false,
      restaurants: [], // 存放所有商家容器
      data: null,
      mescroll: null, // mescroll实例对象
      mescrollDown: {},
      //下拉刷新的配置. (如果下拉刷新和上拉加载处理的逻辑是一样的,则mescrollDown可不用写了)
      mescrollUp: {
        // 上拉加载的配置.
        callback: this.upCallback, // 上拉回调,此处简写; 相当于 callback: function(page, mescroll) { }
        page: {
          num: 0, //当前页 默认0,回调之前会加1; 即callback(page)会从1开始
          size: 5, //每页数据条数,默认10
        },
        htmlNodata: '<p class="upwarp-nodata">-- END --</p>',
        noMoreSize: 5, //如果列表已无数据,可设置列表的总数量要大于5才显示无更多数据;
      },
    };
  },
  beforeRouteEnter(to, from, next) {
    // 如果没有配置顶部按钮或isBounce,则beforeRouteEnter不用写
    next((vm) => {
      // 滚动到原来的列表位置,恢复顶部按钮和isBounce的配置
      vm.$refs.mescroll && vm.$refs.mescroll.beforeRouteEnter();
    });
  },
  beforeRouteLeave(to, from, next) {
    // 如果没有配置顶部按钮或isBounce,则beforeRouteLeave不用写
    // 记录列表滚动的位置,隐藏顶部按钮和isBounce的配置
    this.$refs.mescroll && this.$refs.mescroll.beforeRouteLeave();
    next();
  },
  computed: {
    address() {
      return this.$store.getters.address;
    },
    city() {
      return (
        this.$store.getters.location.addressComponent.city ||
        this.$store.getters.location.addressComponent.province
      );
    },
  },
  created() {
    /*
      代码说明：
      (1) 注释this.getData()方法，启用this.mockData()方法则表示使用Mockjs模拟首页数据
      (2) 注释this.mockData()方法，启用this.getData()方法则表示使用axios请求后端真实数据
    */
    //this.getData();
    this.mockData();
  },
  methods: {
    // mescroll组件初始化的回调,可获取到mescroll对象
    mescrollInit(mescroll) {
      this.mescroll = mescroll; // 如果this.mescroll对象没有使用到,则mescrollInit可以不用配置
    },
    // 上拉回调 page = {num:1, size:10}; num:当前页 ,默认从1开始; size:每页数据条数,默认10
    upCallback(page, mescroll) {
      // 联网请求
      setTimeout(() => {
        this.axios
          .post("/api/profile/restaurants/1/5")
          .then((response) => {
            // 请求的列表数据
            let arr = response.data;
            // console.log(response.data)
            // 如果是第一页需手动置空列表
            if (page.num === 1) this.restaurants = [];
            // 把请求到的数据添加到列表
            this.restaurants = this.restaurants.concat(arr);
            // 数据渲染成功后,隐藏下拉刷新的状态
            this.$nextTick(() => {
              mescroll.endSuccess(arr.length);
            });
          })
          .catch((e) => {
            // 联网失败的回调,隐藏下拉刷新和上拉加载的状态;
            mescroll.endErr();
          });
      }, 500);
    },
    getData() {
      this.axios.get("/api/profile/shopping").then((res) => {
        // console.log(res.data);
        this.swipeImgs = res.data.swipeImgs;
        this.entries = res.data.entries;
      });
      this.axios.get("/api/profile/filter").then((res) => {
        // console.log(res.data);
        this.filterData = res.data;
      });
      //this.loadData();
    },
    mockData() {
      // 使用mockjs模拟首页轮播宣传海报数据
      Mock.Random.extend({
        swipImg: function (date) {
          var swipImgs = [
            "/imgs/banner_1.webp",
            "/imgs/banner_2.webp",
            "/imgs/banner_3.webp",
            "/imgs/banner_4.webp"
          ];
          return this.pick(swipImgs);
        }
      })
      var swipeImgs = Mock.mock({
        "imgs|4": ["@swipImg"],
      });
      this.swipeImgs = swipeImgs.imgs;
      // 使用mockjs模拟首页各种入口链接数据
      //Mock.js随机选取入口链接图片
      Mock.Random.extend({
        entryImg: function (date) {
          var entryImgs = [
            "/imgs/entries/1.png",
            "/imgs/entries/2.png",
            "/imgs/entries/3.png",
            "/imgs/entries/4.png",
            "/imgs/entries/5.png",
            "/imgs/entries/6.png",
            "/imgs/entries/7.png",
            "/imgs/entries/8.png",
            "/imgs/entries/9.png",
            "/imgs/entries/10.png",
          ];
          return this.pick(entryImgs);
        },
      });
      //Mock.js随机选取入口链接名称
      Mock.Random.extend({
        entryName: function (date) {
          var entryNames = [
            "美食",
            "美食美刻超市",
            "生鲜果蔬",
            "美食美刻专送",
            "快食简餐",
            "午餐优选",
            "甜点饮品",
            "家常菜",
            "小吃馆",
            "鲜花蛋糕",
          ];
          return this.pick(entryNames);
        },
      });
      var entries = Mock.mock({
        "foodItem|10": [
          {
            image: "@entryImg",
            name: "@entryName",
          },
        ],
      });
      this.entries = [entries.foodItem, entries.foodItem];
      // 后台获取过滤器数据
      this.axios.get("/api/profile/filter").then((res) => {
        this.filterData = res.data;
      });
    },
    showFilterView(isShow) {
      this.showFilter = isShow;
    },
    update(condation) {
      // console.log(condation);
      this.data = condation;
    },
  },
  components: {
    FilterView,
    MescrollVue,
    IndexShop,
  },
};
</script>
<style></style>