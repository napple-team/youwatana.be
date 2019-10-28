<template>
  <div>
    <youtube :video-id="videoId" ref="yosoro"></youtube>
  </div>
</template>

<script>
export default {
  data() {
    return {
      videoId: 'oYk26y9lFjI',
    }
  },
  computed: {
    yosoroPlayer() {
      return this.$refs.yosoro.player
    }
  },
  methods: {
    play() {
      this.yosoroPlayer.seekTo(18)
    }
  }
}
</script>
