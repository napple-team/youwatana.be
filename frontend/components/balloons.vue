<template>
  <div>
    <Balloon v-for="balloon in balloons" :key="balloon.key" :balloon="balloon" @animationFinish="shiftBallons" />
  </div>
</template>

<script>
import Vue from 'vue'
import Balloon from '~/components/balloon'

export default {
  components: {
    Balloon
  },
  data() {
    return {
      balloons: [],
    }
  },
  methods: {
    pushBalloons(from) {
      const time = Date.now();
      for (let [identifier, count] of Object.entries(from)) {
        this.$data.balloons.push({
          key: `${identifier}::${time}`, identifier: identifier, count: count
        })
      }
    },
    shiftBallons(element, key) {
      this.$data.balloons = this.$data.balloons.filter(balloon => balloon.key !== key)
    }
  }
}
</script>
