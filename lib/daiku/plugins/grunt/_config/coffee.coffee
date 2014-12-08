module.exports =
  default:
    files:
      'public/assets/app.js': [
        'assets/javascripts/app.coffee'
      ]
    options:
      compress: false
      expand: true
      join: true
  production:
    files: '<%= coffee.default.files %>'
    options:
      compress: true
      expand: true
      join: true
