const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')
const vue =  require('./loaders/vue')

environment.loaders.append('vue', vue)
environment.loaders.append('typescript', typescript)
module.exports = environment
