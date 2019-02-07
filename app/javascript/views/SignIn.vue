<<template>
  <simple-form-layout header="Sign In">
    <form @submit.prevent="submit">
      <div
        v-if='credential.errors.base'
        class='alert alert-danger'
      >
        {{ credential.errors.base.fullMessage }}
      </div>
      <text-input
        label="Email Address"
        v-model="credential.email"
        :error="credential.errors.email"
      />
      <text-input
        label="Password"
        type="password"
        v-model="credential.password"
        :error="credential.errors.password"
      />
      <button
        class="btn btn-primary"
        type="submit"
      >
        Sign In
      </button>
    </form>
  </simple-form-layout>
</template>

<script lang="ts">
import Vue from 'vue'
import SimpleFormLayout from "../components/SimpleFormLayout.vue"
import TextInput from '../components/TextInput.vue'

import { Credential } from '../models/credential'

export default Vue.extend({
  components: {
    SimpleFormLayout,
    TextInput,
  },
  data() {
    return {
      credential: new Credential()
    }
  },
  methods: {
    async submit() {
      let success = await this.credential.save({ returnScope: Credential.includes(['user']) })

      if (success) {
        this.$auth.signIn(this.credential, this.credential.user)
      }
    }
  }
})
</script>
