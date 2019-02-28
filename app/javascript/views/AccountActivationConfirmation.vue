<template>
  <simple-layout>
    <div class="alert alert-success">
      <h4 class="alert-heading">Account Verified</h4>
      <p>
        You have successfully verified your account.
        You may now login at
        <router-link :to="{name: 'sign_in'}">the sign in page</router-link>.
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

