module.exports =
  default:
    files: [
      expand: true
      cwd: 'assets/images'
      src: ['**/*.{png,jpg,gif}']
      dest: 'public/assets'
    ]
  options:
    pngquant: false
    optimizationLevel: 7
    progressive: true
