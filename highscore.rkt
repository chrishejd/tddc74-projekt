#lang racket

(define high-file "highscore.txt")

(define high-lst (mcons (mcons 1 10) (mcons 2 5) (mcons 3 2)))

(define (write-high score)
  (1))

;;Skriver data till en utport
(define writer
  (lambda args
    (let ((output-file (open-flagged-outport (picker args 2) 
                                             (picker args 1))))
      [begin
        (write (picker args 0) output-file)
        (newline output-file)
        (close-output-port output-file)])))
