<template>
  <simple-layout>
    <div class="alert alert-success">
      <h4 class="alert-heading">Account Created</h4>
      <p>
        Before continuing, you must confirm your email address. Please check your email
        and follow the confirmation link to finalize your account creation.
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

