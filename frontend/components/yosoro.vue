<template>
  <div>
    <youtube ref="yosoroPlayer" :player-vars="playerVars" @ready="playerReady" />
    <b-button pill variant="outline-secondary" :pressed.sync="mute">
      <span v-if="mute">🔇</span>
      <span v-else>🔊</span>
    </b-button>
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
      playerVars: {
        autoplay: 1,
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
      this.yosoroPlayer.loadVideoById(this.$data.loadVideoParams)
    },
    playSound() {
      if (!this.mute) this.yosoroPlayer.unMute()
      this.yosoroPlayer.seekTo(this.$data.loadVideoParams.startSeconds)
    }
  }
}
</script>
