<template>
  <b-container>
    <b-row>
      <b-col cols="12">
        <div class="d-flex flex-column justify-content-center align-items-center fill-height">
          <Counter />
          <Social />
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Counter from '~/components/counter'
import Social from '~/components/social'

export default {
  components: {
    Counter,
    Social
  }
}
</script>

<style scoped lang="scss">
.fill-height {
  min-height: 100vh;
}
</style>
