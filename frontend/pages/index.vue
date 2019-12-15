<template>
  <b-container>
    <b-row :class="$style.fillHeight" class="justify-content-center align-items-center">
      <b-col cols="12" lg="3" md="4" sm="8">
        <Counter />
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Counter from '~/components/counter'

export default {
  components: {
    Counter,
  }
}
</script>

<style module lang="scss">
.fillHeight {
  min-height: 100vh;
}
</style>
