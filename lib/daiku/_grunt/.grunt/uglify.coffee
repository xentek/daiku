module.exports =
  default:
    files:
      'public/assets/html5shiv.js': [
        'assets/vendor/html5shiv/dist/html5shiv.js'
      ]
      'public/assets/vendor.js': [
        'assets/vendor/jquery/dist/jquery.js'
        'assets/vendor/underscore/underscore.js'
      ]
      'public/assets/main.js': [
        'public/assets/main.js'
      ]
    options:
      beautify: true
      mangle: false
      banner: '/*! packaged on: <%= grunt.template.today("isoUtcDateTime") %> */'
  production:
    files: '<%= uglify.default.files %>'
    options:
      beautify: false
      mangle: false
      banner: '/*! packaged for production on: <%= grunt.template.today("isoUtcDateTime") %> */'
