gulp = require('gulp')
plumber = require('gulp-plumber')

gutil = require('gulp-util')
coffee = require('gulp-coffee')

# Code linting
coffeelint = require('gulp-coffeelint')

# Notifications for OSX
notify = require('gulp-notify')

errorHandler = notify.onError('Error: <%= error.message %>')

coffeeFiles = ['src/*.coffee']

gulp.task 'coffee', ['coffeelint'], ->
  gulp
    .src(coffeeFiles)
    .pipe(plumber({errorHandler}))
    .pipe(coffee())
    .on('error', gutil.log)
    .pipe(gulp.dest(''))


gulp.task 'coffeelint', ->
  gulp
    .src(coffeeFiles)
    .pipe(plumber({errorHandler}))
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())
    .on('error', gutil.log)

gulp.task 'default', ['coffee'], ->
  gulp.watch coffeeFiles, ['coffee']