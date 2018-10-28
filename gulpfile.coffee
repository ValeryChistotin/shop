gulp = require 'gulp'
pug = require 'gulp-pug'
sass = require 'gulp-sass'

gulp.task 'pug', ->
  gulp.src 'views/*.pug'
    .pipe do pug
    .pipe gulp.dest 'public/html'

gulp.task 'sass', ->
  gulp.src 'sass/*.sass'
    .pipe sass set:['compress']
    .pipe gulp.dest 'public/css'

gulp.task 'watch', ->
  gulp.watch 'views/.pug', ['pug']
  gulp.watch 'sass/*.sass', ['sass']

gulp.task 'default', ['pug', 'sass', 'watch']