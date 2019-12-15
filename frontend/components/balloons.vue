<template>
  <ul>
    <Balloon v-for="balloon in balloons" :key="balloon.key" :balloon="balloon" @animationFinish="shiftBallons" />
  </ul>
</template>

<script>
import Vue from 'vue'
import Balloon from '~/components/balloon'

export default {
  components: {
    Balloon
  },
  props: {
    buffer: {
      type: Array,
      default: []
    }
  },
  data() {
    return {
      balloons: [],
    }
  },
  methods: {
    shiftBallons(element, key) {
      this.balloons = this.balloons.filter(balloon => balloon.key !== key)
    }
  },
  watch: {
    buffer(newValue) {
      const time = newValue['time']
      for (let [index, [identifier, count]] of Object.entries(Object.entries(newValue['buffer']))) {
        if (index > 6) retrurn
        setTimeout(() => {
          this.balloons.push({
            key: `${identifier}::${time}`, identifier: identifier, count: count
          })
        }, index * 500)
      }
    }
  }
}
</script>

<style lang="scss" scoped>
ul {
  position: relative;
  margin: 0;
  padding: 0;
  width: 100%;
  height: 0;
  overflow: visible;
  list-style: none;
}

ul > li {
  position: absolute;
  right: 0;
  left: 0;
  display: block;
  margin: 0 auto;
  padding: 0;
  width: 100px;
  height: 60px;
  line-height: 60px;
  font-size: 1.5rem;
  color: #56c7f2;
  border: 2px solid #56c7f2;
  border-radius: 100%;
  background-color: #fff;

  animation: 3s balloon-animation ease-out;

  &::after {
    content: "";
    position: absolute;
    right: 0;
    bottom: -6px;
    left: 0;
    display: block;
    margin: auto;
    padding: 0;
    width: 8px;
    height: 8px;
    border-style: solid;
    border-color: #56c7f2;
    border-width: 0 2px 2px 0;
    background-color: #fff;
    transform: rotate(45deg);
  }
}

@keyframes balloon-animation {
  from {
    bottom: 0;
    opacity: 1;
  }
  to {
    bottom: 100px;
    opacity: 0;
  }
}
</style>
