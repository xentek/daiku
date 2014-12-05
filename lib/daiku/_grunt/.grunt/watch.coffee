module.exports =
  images:
    files: ['assets/images/*.{png,gif,jpg,jpeg}']
    tasks: ['imagemin']
  javascripts:
    files: ['public/assets/*.js']
    tasks: ['jshint']
  coffeescripts:
    files: ['assets/javascripts/*.coffee']
    tasks: ['coffee']
  stylesheets:
    files: ['assets/stylesheets/*.scss']
    tasks: ['sass']
  livereload:
    options:
      livereload: true
    files: ['public/assets/*','public/fonts/*']
