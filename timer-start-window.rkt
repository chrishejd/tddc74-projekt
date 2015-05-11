#lang racket/gui
(require "game-window-class.rkt")
(require "highscore.rkt")
(provide timer)
(provide main-time-up)

;;----------

;;Window handling function for timer
(define (main-time-up)
  (send main-game-window show #f)
  (send classic-highscore update-score! (send main-game-window get-score))
  (send classic-highscore save-highscore)
  (send end-game-window show #t)
  (send end-game-window refresh))

;;Timer class
(define countdown-timer%
  (class timer%
    [init-field time]
    
    (define/public (set-time-msec new-time)
      (set! time new-time))
    
    (define/public (get-time)
      time)
    
    (super-new)))

;;countdown timer for use in-game
(define timer
  (new countdown-timer%
    [time 20000]   
    [notify-callback main-time-up]))

;;----------window to show if the time is up----------

;;draws the window for the time-up window
(define (render-time-up canvas dc)
  (let ((score (send main-game-window get-score)))
    (send dc set-font (make-font #:size 20))
    (send dc draw-text "Time is up!" 200 50)
    (send dc draw-text 
          (string-append (string-append "You stepped on " (number->string 
                                                           score)) 
                         " blocks.")
          90 100)))


(define success-canvas
  (new canvas%
       [parent end-game-window]
       [paint-callback render-time-up]))

;;button to play again
(define retry-button
  (new button%
       [parent end-game-window]
       [label "Play again"]
       [callback (lambda (button event) 
                   (send end-game-window show #f)
                   (send main-game-window show #t)
                   (send main-game-window refresh)
                   (send main-game-window init-score)
                   (send start-window show #t))]))

(define main-menu-button
  (new button%
       [parent end-game-window]
       [label "Main menu"]
       [callback (lambda (button event)
                   (send end-game-window show #f)
                   (send menu-window show #t))]))

;;----------Start canvas----------

(define (render-start-window canvas dc)
  (send dc draw-text "Press any key and release to play..." 20 40))

;;When a key is released, starts the game
(define (key-handler-start key-obj)
  (let ((key (send key-obj get-key-code)))
    (if (eq? key 'release)
        (begin
          (send start-window show #f)
          (send main-game-window focus)
          (send timer start (send timer get-time) #t))
        (void))))

;;shown before the games tarts
(define start-canvas
  (new game-canvas%
       [parent start-window]
       [paint-callback render-start-window]
       [keyboard-handler key-handler-start]))
