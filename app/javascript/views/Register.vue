<template>
  <simple-form-layout header="Create an Account">
    <form @submit.prevent="submit">
      <div
        v-if='registration.errors.base'
        class='alert alert-danger'
      >
        {{ registration.errors.base.fullMessage }}
      </div>
      <text-input
        label="Email Address"
        type="email"
        v-model="registration.email"
        :error="registration.errors.email"
      />
      <text-input
        label="Name"
        v-model="registration.name"
        :error="registration.errors.name"
      />
      <text-input
        label="Password"
        type="password"
        v-model="registration.password"
        :error="registration.errors.password"
      />
      <text-input
        label="Password Confirmation"
        type="password"
        v-model="registration.passwordConfirmation"
        :error="registration.errors.passwordConfirmation"
      />

      <button
        class="btn btn-primary"
        type="submit"
      >
        Register
      </button>
    </form>
  </simple-form-layout>
</template>

<script lang="ts">
import Vue from 'vue'
import SimpleFormLayout from "../components/SimpleFormLayout.vue"
import TextInput from '../components/TextInput.vue'

import { Registration } from '../models/registration'

export default Vue.extend({
  components: {
    SimpleFormLayout,
    TextInput,
  },
  data() {
    return {
      registration: new Registration()
    }
  },
  methods: {
    async submit() {
      let success = await this.registration.save()

      if (success) {
        this.$router.push({name: 'registration_confirmation'})
      }
    }
  }
})
</script>

