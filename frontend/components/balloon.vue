<template>
  <li>(*> ᴗ •*)ゞ +{{count}}</li>
</template>

<script>
export default {
  props: {
    balloon: {
      type: Object,
      default: (() => {})
    },
  },
  computed: {
    key() {
      return this.balloon.key
    },
    identifier() {
      return this.balloon.identifier
    },
    count() {
      return this.balloon.count
    }
  },
  created() {
    setTimeout(this.animationFinish, 3000)
  },
  methods: {
    animationFinish() {
      this.$emit('animationFinish', this.$el, this.key)
    }
  }
}
</script>
