module.exports =
  options:
    out: 'public/assets/<%= env %>/manifest.json'
    separator: '-'
    algorithm: 'md5'
  files:
    src: ['public/assets/<%= env %>/*.{js,css,png,gif,jpg}']
