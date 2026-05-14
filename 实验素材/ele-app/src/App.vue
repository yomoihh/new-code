<template>
  <div id="app">
    <router-view v-slot="{ Component }">
      <keep-alive>
        <component :is="Component" />
      </keep-alive>
    </router-view>
  </div>
</template>

<script>
export default {
  name: "app",
  created() {
    this.getLocation();
  },
  methods: {
    // 获取定位与地理位置
    getLocation() {
      const self = this;
      // 首先获取经纬度信息
      AMap.plugin("AMap.Geolocation", function () {
        var geolocation = new AMap.Geolocation({
          // 是否使用高精度定位，默认：true
          enableHighAccuracy: true,
          // 设置定位超时时间，默认：无穷大
          timeout: 10000,
        });
        // 调用定位，获取经纬度信息，可设置成功或失败回调
        geolocation.getCurrentPosition(function (status, result) {
          if (status == "complete") {
            onComplete(result);
          } else {
            onError(result);
          }
        });
        // 成功获取定位，使用Vuex设置定位信息
        function onComplete(data) {
          // data是具体的定位信息  精准定位
          console.log(data);
          self.$store.dispatch("setLocation", data);
          let position = [[data.position.lng, data.position.lat]];
          // 通过经纬度获取地理位置信息
          AMap.plugin("AMap.Geocoder", function () {
            var geocoder = new AMap.Geocoder({
            });
            geocoder.getAddress(position, function (status, result) {
              if (status === "complete" && result.info === "OK") {
                // result为对应的地理位置详细信息
                // result.regeocodes为批量逆地址地理编码数据
                let address = result.regeocodes[0].formattedAddress
                // 如果地址太长，则简化一下地址
                if(address.length>12){ address =address.slice(0,9)+"..."}
                self.$store.dispatch("setAddress", address);
              }
            });
          });
        }

        function onError(data) {
          // 定位出错    非精准定位
          console.log(data);
          self.getLngLatLocation();
        }
      });
    },
  },
};
</script>

<style scoped>
#app {
  width: 100%;
  height: 100%;

  background: #f1f1f1;
}
</style>
