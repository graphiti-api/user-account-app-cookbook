<template>
  <nav class="navbar navbar-expand-sm navbar-light bg-light">
    <router-link class="navbar-brand" :to="{name: 'home'}" >Graphiti Demo</router-link>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto">
      </ul>
      <ul
        v-if='$auth.currentUser'
        class="navbar-nav"
      >
        <router-link to='/'/>
        <router-link to='/'/>
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
        class="navbar-nav"
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
