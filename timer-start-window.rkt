#lang racket/gui

;;Purpose: Provides a 20 second timer, the 'time-is-up-window', and
;;the 'start-timer-canvas'
;;Authors: Christoffer Hejdström (chrhe465) and Jonatan Gustafsson (jongu926)
;;Last change: Updated with new modular highscore and game modes, 2015-05-20

(require "game-window-class.rkt")
(require "highscore.rkt")

(provide timer)
(provide main-time-up)

;;----------Timer Notify Callback----------

;;Window handling function for timer
(define (main-time-up)
  (send curr-win show #f)
  (send highscore update-score! (send curr-win get-score))
  (send highscore save-highscore)
  (send end-game-window show #t)
  (send end-game-window refresh))

;;----------Timer Object----------
(define countdown-timer%
  (class timer%
    [init-field time]
    
    (define/public (set-time-msec new-time)
      (set! time new-time))
    
    (define/public (get-time)
      time)
    
    (super-new)))

;;Countdown timer for use in-game, 20 seconds
(define timer
  (new countdown-timer%
    [time 20000]   
    [notify-callback main-time-up]))

;;----------Time-is-up-canvas----------

;;Draws the window for the time-up window
(define (render-time-up canvas dc)
  (let ((score (send curr-win get-score)))
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

;;----------Buttons For Timer Window----------

;;Restarts the game with the same mode
(define retry-button
  (new button%
       [parent end-game-window]
       [label "Play again"]
       [callback (lambda (button event) 
                   (send curr-win init-score)
                   (send end-game-window show #f)
                   (send curr-win show #t)
                   (send curr-win refresh)
                   (send start-window show #t))]))

;;Back to main menu
(define main-menu-button
  (new button%
       [parent end-game-window]
       [label "Main menu"]
       [callback (lambda (button event)
                   (send end-game-window show #f)
                   (send menu-window show #t))]))

;;----------Start-Timer-Canvas----------

(define (render-start-window canvas dc)
  (send dc draw-text "Press any key and release to play..." 10 40))

;;When a key is released, starts the game
(define (key-handler-start key-obj)
  (let ((key (send key-obj get-key-code)))
    (if (eq? key 'release)
        (begin
          (send start-window show #f)
          (send main-game-window focus)
          (send timer start (send timer get-time) #t))
        (void))))

;;Canvas shown before the game starts
(define start-canvas
  (new game-canvas%
       [parent start-window]
       [paint-callback render-start-window]
       [keyboard-handler key-handler-start]))
