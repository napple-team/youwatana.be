<template>
  <div class="container">
    <div class="row">
      <div class="col text-center py-5">
        <h1>{{ count }}</h1>
        <button class="btn btn-primary" @click=handleClick>(*&gt; ᴗ &bullet;*)ゞ</button>
      </div>
    </div>
  </div>
</template>

<script>
import cable from 'actioncable'

export default {
  computed: {
    count () {
      return this.$store.state.count;
    }
  },
  created() {
    const channel = cable.createConsumer('ws://localhost:13000/cable');

    this.counterChannel = channel.subscriptions.create('CounterChannel', {
      received: (data) => {
        console.log(data);
        this.$store.commit('setCount', data['count']);
        console.log(this.$store.state.count);
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
</style>
