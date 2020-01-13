
module.exports = {
  mode: 'spa',
  /*
  ** Headers of the page
  */
  head: {
    title: 'youwatana.be',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: process.env.npm_package_description || '' },
      { hid: 'twitter:card', name: 'twitter:card', content: 'summary_large_image' },
      { hid: 'twitter:site', name: 'twitter:site', content: '@MITLicense' },
      { hid: 'twitter:creator', name: 'twitter:creator', content: '@MITLicense' },
      { hid: 'twitter:title', name: 'twitter:title', content: 'youwatana.be' },
      { hid: 'twitter:image', name: 'twitter:image', content: `${ process.env.FRONTEND_URL }/ogp.png` },
      { hid: 'twitter:description', name: 'twitter:description', content: '全速前進？ヨーソロー！(*> ᴗ •*)ゞ' }
    ],
    link: [
      { rel: 'icon', type: 'image/png', href: '/favicon.png' }
    ]
  },
  /*
  ** Customize the progress-bar color
  */
  loading: { color: '#fff' },
  /*
  ** Global CSS
  */
  css: [
    '@/assets/common.scss'
  ],
  /*
  ** Plugins to load before mounting the App
  */
  plugins: [
    '~/plugins/vue-youtube',
    '~/plugins/actioncable',
  ],
  /*
  ** Nuxt.js dev-modules
  */
  buildModules: [
  ],
  /*
  ** Nuxt.js modules
  */
  modules: [
    // Doc: https://bootstrap-vue.js.org
    'bootstrap-vue/nuxt',
    '@nuxtjs/axios',
  ],
  /*
  ** Build configuration
  */
  build: {
    /*
    ** You can extend webpack config here
    */
    extend (config, ctx) {
    }
  },
  axios: {
    baseURL: process.env.API_SERVER_BASE_URL,
  },
  env: {
    webSocketEntrypointUrl: process.env.WEB_SOCKET_ENTRYPOINT_URL,
    apiServerBaseUrl: process.env.API_SERVER_BASE_URL,
  }
}
