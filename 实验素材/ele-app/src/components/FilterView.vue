<template>
  <div :class="{'open':isSort || isScreen}" @click.self="hideView">
    <!-- 导航 -->
    <div v-if="filterData" class="filter_wrap">
      <aside class="filter">
        <div
          class="filter-nav"
          v-for="(item,index) in filterData.navTab"
          :key="index"
          :class="{'filter-bold':currentFilter==index}"
          @click="filterSort(index)"
        >
          <span>{{item.name}}</span>
          <i v-if="item.icon" :class="'fa fa-'+item.icon"></i>
        </div>
      </aside>
    </div>
    <!-- 排序 -->
    <section class="filter-extend" v-if="isSort">
      <ul>
        <li v-for="(item,index) in filterData.sortBy" :key="index" @click="selectSort(item,index)">
          <span :class="{'selectName':currentSort == index}">{{item.name}}</span>
          <i v-show="currentSort == index" class="fa fa-check"></i>
        </li>
      </ul>
    </section>
    <!-- 筛选 -->
    <section class="filter-extend" v-if="isScreen">
      <div class="filter-sort">
        <div v-for="(screen,index) in filterData.screenBy" :key="index" class="morefilter">
          <p class="title">{{screen.title}}</p>
          <ul>
            <li
              v-for="(item,i) in screen.data"
              :key="i"
              :class="{'selected':item.select}"
              @click="selectScreen(item,screen)"
            >
              <img v-if="item.icon" :src="item.icon" alt>
              <span>{{item.name}}</span>
            </li>
          </ul>
        </div>
      </div>
      <div class="morefilter-btn">
        <span @click="clearFilter" :class="{'edit':edit}" class="morefilter-clear">清空</span>
        <span @click="filterOk" class="morefilter-ok">确定</span>
      </div>
    </section>
  </div>
</template>
<script>
import "../assets/css/filterView.css"
export default {
  name: "FilterView",
  data() {
    return {
      currentFilter: 0, // 当前被选中筛选类型
      isSort: false,    // 是否进行综合排序
      currentSort: 0,   // 当前被选中的综合排序类型
      isScreen: false   // 是否使用多条件筛选过滤
    };
  },
  computed: {
    // 根据多条件筛选是否有条件被选中，动态更新清楚按钮样式
    edit() { 
      let edit = false;
      this.filterData.screenBy.forEach(screen => {
        screen.data.forEach(item => {
          if (item.select) {
            edit = true;
          }
        });
      });
      return edit;
    }
  },
  props: {
    filterData: Object
  },
  methods: {
    // 根据用户点击的过滤类型【0：综合排序，1：距离最近，2：品质联盟，3：筛选】
    // 触发相应事件，从而更新商家数据
    filterSort(index) {
      this.currentFilter = index;
      switch (index) {
        case 0:
          this.isSort = true;
          this.$emit("searchFixed", true);
          break;
        case 1:
          this.$emit("update", {
            condition: this.filterData.navTab[1].condition
          });
          this.hideView();
          break;
        case 2:
          this.$emit("update", {
            condition: this.filterData.navTab[2].condition
          });
          this.hideView();
          break;
        case 3:
          this.isScreen = true;
          this.isSort = false;
          this.$emit("searchFixed", true);

          break;
        default:
          this.hideView();
          break;
      }
    },
    // 隐藏商家过组件弹窗
    hideView() {
      this.isSort = false;
      this.isScreen = false;
      this.$emit("searchFixed", false);
    },
    // 根据用户选择的【综合排序】类型，更新视图数据
    selectSort(item, index) {
      this.currentSort = index;
      this.filterData.navTab[0].name = this.filterData.sortBy[index].name;
      this.hideView();

      // 更新数据
      this.$emit("update", { condition: item.code });
    },
    // 更新【筛选】类目下，某个条件是否被选中的状态
    selectScreen(item, screen) {
      if (screen.id !== "MPI") {
        // 单选
        screen.data.forEach(ele => {
          ele.select = false;
        });
      }
      item.select = !item.select;
    },
    // 清楚【筛选】中所有子条件的状态
    clearFilter() {
      this.filterData.screenBy.forEach(screen => {
        screen.data.forEach(item => {
          item.select = false;
        });
      });
    },
    // 计算用户所有选中的【筛选】条件
    filterOk() {
      let screenData = {
        MPI: "",
        offer: "",
        per: ""
      };
      let mpiStr = "";
      this.filterData.screenBy.forEach(screen => {
        screen.data.forEach((item, index) => {
          if (item.select) {
            // 两种情况 1.多选 2.单选
            if (screen.id !== "MPI") {
              // 单选
              screenData[screen.id] = item.code;
            } else {
              // 多选 fengniao,pinpai
              mpiStr += item.code + ",";
              screenData[screen.id] = mpiStr;
            }
          }
        });
      });

      // console.log(mpiStr);
      this.$emit("update", { condition: screenData });

      this.hideView();
    }
  }
};
</script>

<style>

</style>
