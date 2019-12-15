<template>
  <div>
    <youtube class="yosoro-player" ref="yosoroPlayer" width="0" height="0" :player-vars="playerVars" @ready="playerReady" @playing="playerPlaying" />
    <template v-if="!initialized">
      <b-button pill variant="outline-secondary">
        <b-spinner variaant="primary" type="grow" small />
      </b-button>
    </template>
    <template v-else>
      <b-button pill variant="outline-secondary" :pressed.sync="mute">
        <span v-if="mute">🔇</span>
        <span v-else>🔊</span>
      </b-button>
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
      }
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
