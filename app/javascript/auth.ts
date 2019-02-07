import Vue, { PropType } from 'vue'
import VueRouter, { Route } from 'vue-router'
import { User } from './models/user'
import { Credential } from './models/credential'

export interface IAuth {
  authenticated: boolean
  currentUser: User | undefined
  setPostLoginRoute(route: Route): void
  signIn(credential: Credential, user: User): void
  signOut(): void
  forceSignOut(): void
}

export default Vue.extend({
  props: {
    $router: {
      type: Object as PropType<VueRouter>,
      required: true,
    }
  },
  data() {
    return {
      user: undefined as IAuth['currentUser'],
      jwt: undefined as string | undefined,
      postLogin: undefined as Route | undefined
    }
  },
  computed: {
    authenticated() : IAuth['authenticated'] {
      return !!this.currentUser
    },
    currentUser() : IAuth['currentUser'] {
      return this.user
    }
  },
  methods: {
    setPostLoginRoute(route: Route): void {
      this.postLogin = route
    },
    signIn(credential: Credential, user: User): void {
      this.user = user
      this.jwt = credential.jsonWebToken

      if((window as any).halt) { debugger }
      if (this.postLogin) {
        let destination = { ...this.postLogin }
        this.postLogin = undefined

        this.$router.push(destination)
      } else {
        this.$router.push({ name: 'home' })
      }
    },
    signOut(): void {
      this.user = undefined
      this.jwt = undefined
    },
    forceSignOut(): void {
      this.setPostLoginRoute(this.$router.currentRoute)
      this.signOut()
      this.$router.push({ name: 'sign_in' })
    },
  }
})