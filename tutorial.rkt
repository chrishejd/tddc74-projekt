#lang racket/gui
(require "game-window-class.rkt")

;;
(define (render-tutorial canvas dc)
  (send dc set-font (make-font #:size 20))
  (send dc draw-text "1"))

;;Canvas
(define tutorial-canvas
  (new canvas%
       [parent tutorial-window]
       [paint-callback render-tutorial]))

;;Button
(define menu-button
  (new button%
       []))
