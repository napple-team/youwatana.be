<template>
  <div class="text-center py-5">
    <p class="display-3">{{ animatedCounter }}</p>
    <button class="btn btn-outline-primary btn-lg" id="button-yosoro" @click=handleClick>(*&gt; &#7447; &bull;*)ゞ</button>
  </div>
</template>

<script>
import actioncable from 'actioncable'
import { TweenLite } from 'gsap/TweenLite'

export default {
  data() {
    return {
      count: 0,
      tweenedNumber: 0,
    }
  },
  created() {
    const channel = actioncable.createConsumer('ws://localhost:13000/cable')

    this.counterChannel = channel.subscriptions.create('CounterChannel', {
      received: (data) => {
        this.count = data['count']
      }
    })
  },
  computed: {
    animatedCounter: function() {
      return this.tweenedNumber.toFixed(0)
    }
  },
  methods: {
    handleClick: function() {
      this.counterChannel.perform('increment', {
        count: 1,
      })
    }
  },
  watch: {
    count: function(newValue, oldValue){
      TweenLite.to(this.$data, 0.5, { tweenedNumber: newValue })
    },
  }
}
</script>

