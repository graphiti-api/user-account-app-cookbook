import VueRouter from 'vue-router'
import Welcome from './views/Welcome.vue'

const router =  new VueRouter({
  mode: 'history',
  linkActiveClass: 'active',
  routes: [
    {
      path: '/',
      component: Welcome,
      name: 'home',
      meta: {
        skipAuthentication: true
      }
    },
    {
      path:'/sign_in',
      name: 'sign_in',
      component: () => import('./views/SignIn.vue'),
      meta: {
        skipAuthentication: true
      }
    },
    {
      path:'/sign_out',
      name: 'sign_out',
      beforeEnter(to, from, next) {
        router.app.$auth.signOut();
        next({ name: 'home' })
      },
      meta: {
        skipAuthentication: true
      }
    },
    {
      path:'/register',
      name: 'register',
      component: () => import('./views/Register.vue'),
      meta: {
        skipAuthentication: true
      }
    },
    {
      path:'/register/confirm',
      name: 'registration_confirmation',
      component: () => import('./views/RegistrationConfirmation.vue'),
      meta: {
        skipAuthentication: true
      }
    },
    {
      path:'/profile',
      name: 'profile',
      component: () => import('./views/Profile.vue'),
    },
  ]
})

router.beforeEach((to, from , next) => {
  if (to.meta.skipAuthentication ||
      router.app.$auth.currentUser) {
    next()
  } else {
    router.app.$auth.setPostLoginRoute(to)
    next({ name: 'sign_in' })
  }
})

export default router