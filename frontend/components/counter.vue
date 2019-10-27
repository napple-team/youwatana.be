<template>
  <div class="text-center py-5">
    <template v-if=disconnected>
      <div class="display-3">Loading...</div>
      <button class="btn btn-outline-primary btn-lg my-3 px-5" disabled>
        <span class="spinner-border" role="status" aria-hidden="true">
          <span class="sr-only">Loading...</span>
        </span>
      </button>
    </template>
    <template v-else>
      <div class="display-3">{{ animatedCounter }}</div>
      <button class="btn btn-outline-primary btn-lg my-3" id="button-yosoro" @click=handleClick>
        (*&gt; &#7447; &bull;*)ゞ
      </button>
    </template>
  </div>
</template>

<script>
import axios from 'axios'
import actioncable from 'actioncable'
import { TweenLite } from 'gsap/TweenLite'

export default {
  data() {
    return {
      disconnected: true,
      identifier: null,
      count: 0,
      tweenedNumber: 0,
    }
  },
  async created() {
    this.getIdentifier()
    const channel = actioncable.createConsumer('ws://localhost:13000/cable')
    this.counterChannel = channel.subscriptions.create('CounterChannel', {
      connected: () => { this.disconnected = false },
      received: (data) => this.receivedCount(data),
      rejected: () => { this.disconnected = true },
      disconnected: (data) => { this.disconnected = true },
    })
  },
  beforeDestroy() {
    this.counterChannel.unsubscribe()
  },
  computed: {
    animatedCounter: function() {
      return this.tweenedNumber.toFixed(0)
    }
  },
  methods: {
    handleClick: function() {
      this.counterChannel.perform('increment', {
        count: 1, identifer: this.identifer
      })
    },
    receivedCount: function(data) {
      this.count = data['count']
    },
    getIdentifer: async function() {
      try {
        const response = await axios.get('http://localhost:13000/generate_identifer')
        this.identifer = response.data.identifer
      } catch (err) {
        console.error(err)
      }
    },
  },
  watch: {
    count: function(newValue, oldValue){
      TweenLite.to(this.$data, 0.5, { tweenedNumber: newValue })
    },
  }
}
</script>

