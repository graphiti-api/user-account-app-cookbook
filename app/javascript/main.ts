import Vue from 'vue'
import App from './App.vue'
import router from './router'
import VueRouter from 'vue-router'
import ApplicationRecord from './models/application-record'

Vue.use(VueRouter)

import Auth from "./auth"
const auth = new Auth({
  propsData: { $router: router }
})
Vue.prototype.$auth = auth
ApplicationRecord.$auth = auth

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('div'))
  const app = new Vue({
    el,
    render: h => h(App),
    router
  })
})