<template>
  <div class="index">
    <b-container class="index-content">
      <b-row>
        <b-col cols="12">
          <div class="d-flex flex-column justify-content-center align-items-center fill-height">
            <h1><span class="text-you-color">you</span>watana.be</h1>
            <Counter />
            <Social />
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
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

.index {
  position: relative;
  background-image: url("/wave-dark.svg");
  background-size: 100px 100px;
  background-repeat: repeat-x;
  background-position-y: bottom;
  animation: 10s wave-background-animation linear infinite;

  &::before {
    content: "";
    position: absolute;
    right: 20px;
    bottom: 25px;
    z-index: 1;
    display: block;
    width: 150px;
    height: 150px;
    background-image: url("/yosoro.svg");
    background-repeat: no-repeat;
    background-size: 150px 150px;
    transform-origin: bottom center;
    animation: 5s wave-boat-animation ease-in-out infinite
  }

  &::after {
    content: "";
    position: absolute;
    right: 0;
    bottom: 0;
    left: 0;
    z-index: 2;
    display: block;
    width: 100%;
    height: 100px;
    background-image: url("/wave-light.svg");
    background-size: 100px 100px;
    background-repeat: repeat-x;
    background-position-y: bottom;
    animation: 6s wave-background-animation linear infinite;
    pointer-events: none;
  }
}

@keyframes wave-background-animation {
  from {
    background-position-x: 100px;
  }
  to {
    background-position-x: 0;
  }
}

@keyframes wave-boat-animation {
  from {
    transform: rotateZ(-5deg);
  }
  50% {
    transform: rotateZ(5deg);
  }
  to {
    transform: rotateZ(-5deg);
  }
}

.index-content {
  z-index: 100;
}

.text-you-color {
  color: #56c7f2;
}
</style>
