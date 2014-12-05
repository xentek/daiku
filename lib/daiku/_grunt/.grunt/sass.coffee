module.exports =
  default:
    options:
      style: 'compressed'
    files: [
      src: 'assets/stylesheets/app.scss'
      dest: 'public/assets/app.css'
    ]
  development:
    options:
      style: 'expanded'
    files: '<%= sass.default.files %>'
