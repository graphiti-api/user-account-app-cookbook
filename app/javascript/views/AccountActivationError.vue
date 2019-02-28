<template>
  <simple-layout>
    <div class="alert alert-danger">
      <h4 class="alert-heading">Email Verification Error</h4>
      <p>
        The activation code was invalid.  Please check your email for
        a valid account activation link.
      </p>
    </div>
  </simple-layout>
</template>

<script lang="ts">
import Vue from 'vue'
import SimpleLayout from "../components/SimpleLayout.vue"

export default Vue.extend({
  components: {
    SimpleLayout,
  },
})
</script>

