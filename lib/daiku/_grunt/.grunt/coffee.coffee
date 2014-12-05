module.exports =
  compile:
    files: [
      expand: true
      flatten: true
      cwd: 'assets/javascripts'
      src: ['*.coffee']
      dest: 'public/assets/'
      ext: '.js'
    ]
