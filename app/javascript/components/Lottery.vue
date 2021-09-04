<template>
<div class="wheel-wrapper">
  <div
    class="wheel-pointer"
    @click="onClickRotate"
  >
    抽獎
  </div>
  <div
    class="wheel-bg"
    :class="{freeze: freeze}"
    :style="`transform: rotate(${wheelDeg}deg)`"
  >
    <div class="prize-list">
      <div
        class="prize-item-wrapper"
        v-for="(item,index) in prizeList"
        :key="index"
      >
        <div
          class="prize-item"
          :style="`transform: rotate(${(360/ prizeList.length) * index}deg)`"
        >
          <div class="prize-name">
            {{ item.name }}
          </div>
          <div class="prize-icon">
            <img :src="item.icon">
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
export default {
  data() {
    return {
      freeze: false,
      rolling: false,
      wheelDeg: 0,
      prizeNumber: 5,
      prizeListOrigin: [
        {
          icon: "https://picsum.photos/40?random=1",
          name: "喝水 50cc"
        },
        {
          icon: "https://picsum.photos/40?random=6",
          name: "站立 10 秒"
        },
        {
          icon: "https://picsum.photos/40?random=2",
          name: "開合跳 2下"
        },
        {
          icon: "https://picsum.photos/40?random=3",
          name: "倒立 2秒"
        },
        {
          icon: "https://picsum.photos/40?random=6",
          name: "魔王笑"
        },
      ]
    }
  },
  computed: {
    prizeList() {
      return this.prizeListOrigin.slice(0, this.prizeNumber);
    }
  },
  methods: {
    onClickRotate() {
      if (this.rolling) {
        return;
      }
      const result = Math.floor(Math.random() * this.prizeList.length);
      this.roll(result);
    },
    roll(result) {
      this.rolling = true;
      const { wheelDeg, prizeList } = this;
      this.wheelDeg =
        wheelDeg -
        wheelDeg % 360 +
        6 * 360 +
        (360 - 360 / prizeList.length * result);
      setTimeout(() => {
        this.rolling = false;
        // alert("Result：" + prizeList[result].name);
      }, 4500);
    }
  },
  watch: {
    prizeNumber() {
      this.freeze = true;
      this.wheelDeg = 0;

      setTimeout(() => {
        this.freeze = false;
      }, 0);
    }
  }
}
</script>