<template>
  <div class="counter">
    <b-alert variant="danger" :show="raiseError" class="text-center">
      <p class="mb-0">予期せぬエラーが発生しました</p>
    </b-alert>
    <div class="text-center py-3">
      <template v-if="disconnected">
        <div>
          <div class="d-inline-flex align-items-center">
            <b-spinner variant="primary" />
            <span class="ml-3">Now Youding...</span>
          </div>
        </div>
      </template>
      <template v-else>
        <b-row>
          <b-col cols="12">
            <Balloons ref="balloons" :buffer="counterBuffer" :identifier="identifier" />
            <div class="yosoro-counter display-3">{{ animatedCounter }}</div>
          </b-col>
        </b-row>
        <b-row class="justify-content-center">
          <b-col lg="3" md="4" sm="8" cols="12">
            <b-btn
              variant="primary"
              block
              size="lg"
              class="yosoro-button my-3"
              @click="handleClick"
            >
              <span class="sr-only">(*&gt; &#7447; &bull;*)ゞ</span>
            </b-btn>
          </b-col>
        </b-row>
        <Yosoro ref="soundPlayer" class="sound-button" />
      </template>
    </div>
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
      identifier: null,
      count: {
        serverCount: 0,
        notSendCount: 0,
        serverSentCount: 0,
      },
      tweenedNumber: 0,
      counterBuffer: {
        time: 0,
        buffer: []
      },
    }
  },
  async created() {
    try {
      this.identifier = await this.getIdentifier()
      console.log(this.identifier)

      const timeoutId = setTimeout(() => { this.raiseError = true }, 5000)

      this.counterChannel = this.$cable.subscriptions.create(
        { channel: 'CounterChannel', identifier: this.identifier },
        {
          connected: () => {
            this.disconnected = false
            clearTimeout(timeoutId)
          },
          received: (receivedData) => this.receivedCount(receivedData),
          rejected: () => { this.disconnected = true },
          disconnected: (data) => { this.disconnected = true },
        }
      )

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
        this.$refs.soundPlayer.playSound()
        this.counterBuffer = {
          time: receivedData['time'],
          buffer: receivedData['buffer']
        }
        if (this.identifier in receivedData['buffer']) {
          this.count.serverSentCount -= receivedData['buffer'][this.identifier]
        }
      }
    },
    async getIdentifier() {
      try {
        const response = await this.$axios.get('/generate_identifier')
        return response.data.identifier
      } catch (err) {
        console.error(err)
      }
    }
  },
  watch: {
    displayCount(newValue) {
      gsap.to(this.$data, 0.5, { tweenedNumber: newValue, ease: 'linear' } )
    },
  }
}
</script>

<style lang="scss" scoped>
.counter {
  width: 100%;
}
.yosoro-button {
  animation: waggle ease 7s 1s infinite;
  &::before {
    content: "全速前進？";
  }
  &:hover:not(:disabled) {
    animation: none;
    &::before {
      content: "ヨーソロー！";
    }
  }
}

.sound-button {
  position: fixed;
  top: 1rem;
  right: 1rem;
}

@keyframes waggle {
  0% {
    transform: none;
  }
  12.5% {
    transform: rotateZ(-2deg) scale(1.05);
  }
  15% {
    transform: rotateZ(5deg) scale(1.05);
  }
  16.25% {
    transform: rotateZ(-2deg) scale(1.05);
  }
  17.5% {
    transform: rotateZ(2deg) scale(1.05);
  }
  18.75% {
    transform: rotateZ(-2deg) scale(1.05);
  }
  20% {
    transform: rotateZ(0) scale(1.05);
  }
  25% {
    transform: rotateZ(0) scale(1);
  }
  100% {
    transform: none;
  }
}
</style>
