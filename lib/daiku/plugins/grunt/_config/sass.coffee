module.exports =
  default:
    files: 'public/assets/main.css': [
      'assets/stylesheets/main.scss'
    ]
    options:
      style: 'expanded'
  production:
    files: '<%= sass.default.files %>'
    options:
      style: 'compressed'
