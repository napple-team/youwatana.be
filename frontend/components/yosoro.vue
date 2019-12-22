<template>
  <div class="yosoro" :class="{ 'yosoro-hover': hover }" @mouseenter="hover = true" @mouseleave="hover = false">
    <youtube class="yosoro-player" ref="yosoroPlayer" width="0" height="0" :player-vars="playerVars" @ready="playerReady" @playing="playerPlaying" />
    <template v-if="!initialized">
      <b-button pill variant="link">
        <b-spinner variaant="primary" type="grow" small />
      </b-button>
    </template>
    <template v-else>
      <div class="d-inline-flex justify-content-end align-items-center">
        <div class="yosoro-youtube-from-url pr-2">
          <a href="https://www.youtube.com/watch?v=oYk26y9lFjI">
            音声元の YouTube を開く
          </a>
        </div>
        <b-button pill variant="outline-secondary" :pressed.sync="mute">
          <span v-if="mute">🔇</span>
          <span v-else>🔊</span>
        </b-button>
      </div>
    </template>
  </div>
</template>

<script>
export default {
  props: {
    mute: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      initialized: false,
      playerVars: {
        controls: 0,
        disablekb: 0,
        rel: 0,
      },
      loadVideoParams: {
        videoId: 'oYk26y9lFjI',
        startSeconds: 17.9,
        endSeconds: 19,
      },
      hover: false
    }
  },
  computed: {
    yosoroPlayer() {
      return this.$refs.yosoroPlayer.player
    },
  },
  watch: {
    mute(newValue) {
      if (newValue) {
        this.yosoroPlayer.mute()
      } else {
        this.yosoroPlayer.unMute()
      }
    }
  },
  methods: {
    playerReady() {
      // 無音で再生してロードさせる
      this.yosoroPlayer.mute()
      this.yosoroPlayer.loadVideoById(this.loadVideoParams)
    },
    playerPlaying(target) {
      // 読み込みが完了（バッファリングが終わって再生できるようになったらreadyイベントを発生させる）
      if (!this.initialized) {
        this.initialized = true
        this.$emit('ready', target)
      }
    },
    playSound() {
      if (!this.mute) this.yosoroPlayer.unMute()
      this.yosoroPlayer.seekTo(this.loadVideoParams.startSeconds)
    }
  }
}
</script>

<style scoped lang="scss">
.yosoro {
  .yosoro-youtube-from-url {
    display: none;
  }
}
.yosoro-hover {
  .yosoro-youtube-from-url {
    display: block;
    animation: fade-in 0.5s ease;
  }
}

@keyframes fade-in {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}
</style>
