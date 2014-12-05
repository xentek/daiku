module.exports =
  options:
    beautify: false
    mangle: false
  default:
    files:
      'public/assets/html5shiv.js': [
        'assets/javascripts/vendor/html5shiv/dist/html5shiv.js'
      ]
      'public/assets/vendor.js': [
        'assets/javascripts/vendor/jquery/jquery.js'
        'assets/javascripts/vendor/css3-mediaqueries-js/css3-mediaqueries.js'
        'assets/javascripts/vendor/fastclick/lib/fastclick.js'
        'assets/javascripts/vendor/jquery.validation/jquery.validate.js'
        'assets/javascripts/vendor/jquery-placeholder/jquery.placeholder.js'
      ]
      'public/assets/require.js': [
        'assets/javascripts/vendor/requirejs/require.js'
      ]
      'public/assets/app.js': [
        'public/assets/app.js'
      ]
      'public/assets/main.js': [
        'public/assets/main.js'
      ]
