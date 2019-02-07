<template>
  <simple-layout>
    <div class='card'>
      <div class="card-header">
        {{ header }}
      </div>
      <div class="card-body">
        <slot/>
      </div>
    </div>
  </simple-layout>
</template>

<script lang="ts">
import Vue from 'vue'
import SimpleLayout from './SimpleLayout.vue'
export default Vue.extend({
  components: {
    SimpleLayout,
  },
  props: {
    header: {
      required: true,
      type: String
    }
  }
})
</script>
