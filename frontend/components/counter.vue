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
      temporaryCount: 0,
      tweenedNumber: 0,
      intervalObject: null,
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

    this.intervalObject = setInterval(this.sendTemporaryCount, 1000)
  },
  beforeDestroy() {
    this.counterChannel.unsubscribe()
    clearInterval(this.intervalObject)
  },
  computed: {
    animatedCounter: function() {
      return this.tweenedNumber.toFixed(0)
    },
    localCount: function() {
      return this.count + this.temporaryCount
    }
  },
  methods: {
    handleClick: function() {
      this.temporaryCount++
    },
    sendTemporaryCount: function() {
      if (this.temporaryCount > 0) {
        this.counterChannel.perform('increment', {
          count: this.temporaryCount, identifer: this.identifer
        })
      }
    },
    receivedCount: function(data) {
      this.count = data['count']

      if (this.identifier == data['identifier']) {
        this.temporaryCount = 0
      }
    },
    getIdentifier: async function() {
      try {
        const response = await axios.get('http://localhost:13000/generate_identifier')
        this.identifer = response.data.identifer
      } catch (err) {
        console.error(err)
      }
    },
  },
  watch: {
    localCount: function(newValue) {
      TweenLite.to(this.$data, 0.5, { tweenedNumber: newValue })
    },
  }
}
</script>

