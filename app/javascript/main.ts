import Vue from 'vue'
import App from './App.vue'

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('div'))
  const app = new Vue({
    el,
    render: h => h(App)
  })
})