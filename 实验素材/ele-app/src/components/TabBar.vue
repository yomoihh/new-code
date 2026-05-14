<template>
  <div class="tabbar">
    <router-link
      class="tab-item"
      v-for="(item,index) in data"
      :key="index"
      :to="item.path"
      active-class="is-selected"
    >
      <div class="tab-item-icon">
        <i :class="'fa fa-' + item.icon"></i>
      </div>
      <div class="tab-item-label">{{item.title}}</div>
    </router-link>
  </div>
</template>

<script>
// 导入组件样式文件
import "assets/css/tabBar.css"
export default {
  name: "tabbar",
  props: {
    data: Array // 导航链接按钮文字及目标路径数组
  }
};
</script>

<style>

</style>

