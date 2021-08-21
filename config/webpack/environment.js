const { environment } = require('@rails/webpacker')
const coffee =  require('./loaders/coffee')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.loaders.prepend('coffee', coffee)
module.exports = environment
