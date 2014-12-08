module.exports =
  default:
    files: [
        expand: true,
        cwd: 'assets/pages',
        src: ['**/*.slim']
        dest: 'public'
        ext: '.html'
      ]
  options:
    pretty: true
  production:
    files: '<%= slim.default.files %>'
    options:
      pretty: false
