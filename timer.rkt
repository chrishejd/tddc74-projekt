#lang racket/gui

(define (timer-fn)
  (display "hej"))

(define timer
  (new timer%
    [notify-callback timer-fn]))
