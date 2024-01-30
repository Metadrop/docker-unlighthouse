export default {
  puppeteerOptions: {
      args: ["--no-sandbox"],
  },
  server: {
      open: false,
  },
  site: 'example.com',
  scanner: {
    exclude: []
  },
  debug: false
}
