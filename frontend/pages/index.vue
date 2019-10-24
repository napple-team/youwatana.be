<template>
  <div class="container">
    <div class="row">
      <div class="col text-center py-5">
        <div class="display-2">{{ totalCount }}</div>
        <button class="btn btn-outline-primary btn-lg" @click=handleClick>(*&gt; &#7447; &bull;*)ゞ</button>
      </div>
    </div>
  </div>
</template>

<script>
import cable from 'actioncable'

export default {
  computed: {
    totalCount () {
      return this.$store.state.count;
    }
  },
  created() {
    const channel = cable.createConsumer('ws://localhost:13000/cable');

    this.counterChannel = channel.subscriptions.create('CounterChannel', {
      received: (data) => {
        this.$store.commit('setCount', data['count']);
      }
    })
  },
  methods: {
    handleClick: function() {
      this.counterChannel.perform('increment', {
        count: 1,
      });
    }
  }
}
</script>

<style>
.kaomoji {
  font-family: -apple-system, BlinkMacSystemFont, 'Open Sans', 'Helvetica Neue', Helvetica, Arial, '游ゴシック', YuGothic, 'ヒラギノ角ゴ ProN W3', 'Hiragino Kaku Gothic ProN', 'メイリオ', Meiryo, sans-serif;
}
</style>
