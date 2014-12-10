module.exports =
  default:
    files: 'public/assets/app.css': [
      'assets/stylesheets/app.scss'
    ]
    options:
      style: 'expanded'
  production:
    files: '<%= sass.default.files %>'
    options:
      style: 'compressed'
