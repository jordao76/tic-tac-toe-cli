# coffeelint: disable=max_line_length

gulp = require 'gulp'
$ = (require 'gulp-load-plugins')()
run = require 'run-sequence'

onError = (error) ->
  $.util.log error
  process.exit 1

# build

gulp.task 'lint', ->
  gulp.src ['./gulpfile.coffee', './src/**/*.coffee']
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()
    .pipe $.coffeelint.reporter 'failOnWarning'

gulp.task 'compile', ['lint'], ->
  gulp.src './src/**/*.coffee'
    .pipe $.coffee bare: yes
    .on 'error', onError
    .pipe gulp.dest './lib'

gulp.task 'clean',
  require 'del'
    .bind null, ['lib']

gulp.task 'build', (done) ->
  run 'clean', 'compile', done

gulp.task 'default', ['build']
