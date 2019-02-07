<template>
  <div class="row justify-content-center simple-layout">
    <div class="col-12 col-md-10 col-lg-8 col-xl-6">
      <slot/>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
})
</script>

<style lang="scss" scoped>
@import "~bootstrap/scss/functions";
@import "~bootstrap/scss/variables";
@import "~bootstrap/scss/mixins";

.simple-layout {
  margin-top: 1rem;
}

@include media-breakpoint-up(md) {
  .simple-layout {
    margin-top: 8rem;
  }
}
</style>

