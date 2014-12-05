module.exports =
  default:
    options:
      mode: 'gzip'
    files: [
      {
        expand: true
        flatten: true
        src: ['public/assets/*.js']
        dest: 'public/assets'
        ext: '.js.gz'
      },
      {
        expand: true
        flatten: true
        src: ['public/assets/*.css']
        dest: 'public/assets'
        ext: '.css.gz'
      }
    ]
