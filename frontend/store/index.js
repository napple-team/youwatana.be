export const state = () => ({
  count: 0
});

export const mutations = {
  setCount(state, count) {
    state.count = count;
  }
}
