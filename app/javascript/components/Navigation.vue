<template>
  <nav class="navbar navbar-expand navbar-light bg-light">
    <router-link class="navbar-brand" :to="{name: 'home'}" >Graphiti Demo</router-link>
    <div class="navbar-collapse">
      <ul class="navbar-nav mr-auto">
      </ul>
      <ul
        v-if='$auth.currentUser'
        key='signedInRoutes'
        class="navbar-nav logged-in"
      >
        <router-link tag="li" :to="{ name: 'profile' }" class="nav-item">
          <a class="nav-link profile-link">
            <img
              class="border-dark"
              :src="$auth.currentUser.avatarUrl"
            />
            {{ $auth.currentUser.name }}
          </a>
        </router-link>
        <router-link tag="li" :to="{ name: 'sign_out' }" class="nav-item">
          <a class="nav-link">Sign Out</a>
        </router-link>
      </ul>
      <ul
        v-else
        key='signedOutRoutes'
        class="navbar-nav logged-out"
      >
        <router-link tag="li" :to="{ name: 'register' }" class="nav-item">
          <a class="nav-link">Register</a>
        </router-link>
        <router-link tag="li" :to="{ name: 'sign_in' }" class="nav-item">
          <a class="nav-link">Sign In</a>
        </router-link>
      </ul>
    </div>
  </nav>
</template>

<script lang="ts">
import Vue from 'vue'
export default Vue.extend({
  data() {
    return {
      bool: false
    }
  },
  computed: {
    signedIn(): boolean {
      return !!this.$auth.currentUser
    }
  }
})
</script>


<style lang="scss" scoped>
.profile-link {
  img {
    float: left;
    border-radius: 1rem;
    margin-top: -0.25rem;
    margin-right: 16px;
    width: 2rem;
    height: 2rem;
  }
}
</style>
