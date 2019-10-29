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
      <button class="btn btn-outline-primary btn-lg my-3" id="button-yosoro" :disabled="playerNotReady" @click="handleClick">
        (*&gt; &#7447; &bull;*)ゞ
      </button>
      <Yosoro ref="soundPlayer" @ready="soundPlayerReady" />
    </template>
  </div>
</template>

<script>
import axios from 'axios'
import actioncable from 'actioncable'
import { TweenLite } from 'gsap/TweenLite'
import Yosoro from '~/components/yosoro'

export default {
  components: {
    Yosoro
  },
  data() {
    return {
      disconnected: true,
      identifier: null,
      count: 0,
      temporaryCount: 0,
      tweenedNumber: 0,
      playerNotReady: true,
    }
  },
  async created() {
    this.getIdentifier()
    const channel = actioncable.createConsumer('ws://localhost:13000/cable')
    this.counterChannel = channel.subscriptions.create('CounterChannel', {
      connected: () => { this.$data.disconnected = false },
      received: (receivedData) => this.receivedCount(receivedData),
      rejected: () => { this.$data.disconnected = true },
      disconnected: (data) => { this.$data.disconnected = true },
    })

    this.intervalObject = setInterval(this.sendTemporaryCount, 1000)
  },
  beforeDestroy() {
    this.counterChannel.unsubscribe()
    clearInterval(this.intervalObject)
  },
  computed: {
    animatedCounter() {
      return this.$data.tweenedNumber.toFixed(0)
    },
    localCount() {
      return this.$data.count + this.$data.temporaryCount
    }
  },
  methods: {
    handleClick() {
      this.$data.temporaryCount++
      this.$refs.soundPlayer.playSound()
    },
    sendTemporaryCount() {
      if (this.$data.temporaryCount > 0) {
        this.counterChannel.perform('increment', {
          count: this.$data.temporaryCount, identifier: this.$data.identifier
        })
      }
    },
    receivedCount(receivedData) {
      this.$data.count = receivedData['count']

      if (this.$data.identifier == receivedData['from']) {
        this.$data.temporaryCount = 0
      }
    },
    async getIdentifier() {
      try {
        const response = await axios.get('http://localhost:13000/generate_identifier')
        this.$data.identifier = response.data.identifier
      } catch (err) {
        console.error(err)
      }
    },
    soundPlayerReady(e) {
      this.$data.playerNotReady = false
    }
  },
  watch: {
    localCount(newValue) {
      TweenLite.to(this.$data, 0.5, { tweenedNumber: newValue })
    },
  }
}
</script>
