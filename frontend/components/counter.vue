<template>
  <div class="text-center py-5">
    <b-alert variant="danger" :show="raiseError">
      <p class="mb-0">予期せぬエラーが発生しました</p>
    </b-alert>
    <template v-if="disconnected">
      <div class="display-3">Now Loading</div>
      <button class="btn btn-outline-primary btn-lg my-3 px-5" disabled>
        <span class="spinner-border" role="status" aria-hidden="true">
          <span class="sr-only">Loading...</span>
        </span>
      </button>
    </template>
    <template v-else>
      <Balloons ref="balloons" />
      <div class="display-3">{{ animatedCounter }}</div>
      <b-btn variant="primary" block size="lg" class="my-3" id="button-yosoro" :disabled="playerNotReady" @click="handleClick">
        <span class="sr-only">(*&gt; &#7447; &bull;*)ゞ</span>
      </b-btn>
      <Yosoro ref="soundPlayer" @ready="soundPlayerReady" />
    </template>
  </div>
</template>

<script>
import actioncable from 'actioncable'
import gsap from 'gsap'
import Yosoro from '~/components/yosoro'
import Balloons from '~/components/balloons'

export default {
  components: {
    Yosoro,
    Balloons
  },
  data() {
    return {
      raiseError: false,
      counterChannel: null,
      disconnected: true,
      playerNotReady: true,
      identifier: null,
      count: {
        serverCount: 0,
        notSendCount: 0,
        serverSentCount: 0,
      },
      tweenedNumber: 0,
      counterChannel: null,
    }
  },
  async created() {
    try {
      this.identifier = await this.getIdentifier()

    this.counterChannel = this.$cable.subscriptions.create('CounterChannel', {
      connected: () => { this.disconnected = false },
      received: (receivedData) => this.receivedCount(receivedData),
      rejected: () => { this.disconnected = true },
      disconnected: (data) => { this.disconnected = true },
    })

      this.intervalObject = setInterval(this.sendLocalCount, 1000)
    } catch(err) {
      console.error(err)
      this.raiseError = true
    }
  },
  beforeDestroy() {
    this.counterChannel.unsubscribe()
    clearInterval(this.intervalObject)
  },
  computed: {
    animatedCounter() {
      return this.tweenedNumber.toFixed(0)
    },
    displayCount() {
      return this.count.serverCount + this.localCount
    },
    localCount() {
      return this.count.serverSentCount + this.count.notSendCount
    }
  },
  methods: {
    handleClick() {
      this.count.notSendCount++
      this.$refs.soundPlayer.playSound()
    },
    sendLocalCount() {
      if (this.count.notSendCount > 0) {
        this.counterChannel.perform('increment', {
          identifier: this.identifier, count: this.count.notSendCount
        })
        this.count.serverSentCount += this.count.notSendCount
        this.count.notSendCount = 0
      }
    },
    receivedCount(receivedData) {
      this.count.serverCount = receivedData['count']

      if ('buffer' in receivedData) {
        this.$refs.balloons.pushBalloons(receivedData['buffer'])
        if (this.identifier in receivedData['buffer']) {
          this.count.serverSentCount -= receivedData['buffer'][this.identifier]
        }
      }
    },
    async getIdentifier() {
      try {
        const response = await this.$axios.get('/generate_identifier')
        this.identifier = response.data.identifier
      } catch (err) {
        console.error(err)
      }
    },
    soundPlayerReady(e) {
      this.playerNotReady = false
    }
  },
  watch: {
    displayCount(newValue) {
      gsap.to(this.$data, 0.5, { tweenedNumber: newValue })
    },
  }
}
</script>

<style lang="scss" scoped>
#button-yosoro {
  &::before {
    content: "全速前進？";
  }
  &:hover:not(:disabled)::before {
    content: "ヨーソロー！";
  }
}
</style>
