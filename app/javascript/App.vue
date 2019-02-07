<template>
  <div id="app">
    <navigation/>
    <div class="container">
      <router-view/>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import Navigation from './components/Navigation.vue'

export default Vue.extend({
  components: {
    Navigation
  }
})
</script>

<style lang="scss">
@import "~bootstrap/scss/bootstrap";
</style>


<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
