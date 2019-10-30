import Vue from 'vue'
import actioncable from 'actioncable'

Vue.prototype.$cable = actioncable.createConsumer(process.env.webSocketEndpointUrl)
