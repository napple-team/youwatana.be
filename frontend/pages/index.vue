<template>
  <div class="container">
    <div class="row">
      <div class="col">
        <Counter />
      </div>
    </div>
  </div>
</template>

<script>
import Counter from '~/components/counter'

export default {
  components: {
    Counter,
  }
}
</script>

<style>
.kaomoji {
  font-family: -apple-system, BlinkMacSystemFont, 'Open Sans', 'Helvetica Neue', Helvetica, Arial, '游ゴシック', YuGothic, 'ヒラギノ角ゴ ProN W3', 'Hiragino Kaku Gothic ProN', 'メイリオ', Meiryo, sans-serif;
}
</style>
