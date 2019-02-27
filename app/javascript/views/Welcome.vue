<template>
  <div>
    <h1 v-if="$auth.currentUser">Hello {{ $auth.currentUser.name }}</h1>
    <h1 v-else>Hello Graphiti Guest</h1>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
})
</script>

