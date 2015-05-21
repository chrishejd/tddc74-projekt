#lang racket/gui

;;Purpose: Create all the needed frames 
;;Authors: Christoffer Hejdström (chrhe465) and Jonatan Gustafsson (jongu926)
;;Last change: Implemented frames for tutorial and credits, 2015-05-20

(provide game-canvas%)
(provide main-game-window)
(provide end-game-window)
(provide wrong-key-window)
(provide start-window)
(provide menu-window)
(provide tutorial-window)
(provide hyper-window)
(provide curr-win)
(provide set-curr-win)
(provide tutorial-window)
(provide credits-window)

;;Holder for the current window
(define curr-win (void))

;;----------Gameboard Canvas Object----------

;;Canvas class with keyboard handler
(define game-canvas%
  (class canvas%
    (init-field [keyboard-handler display])
    
    (define/override (on-char key-event)
      (keyboard-handler key-event))
    
    (super-new)))

;;----------Game Frame Object For Score Counting----------

;;Frame for the game score is how many bricks have been clicked
(define game-frame%
  (class frame%
    (init-field curr-score)
        
    (define/public (get-score)
      curr-score)
    
    (define/public (inc-score)
      (set! curr-score (+ 1 curr-score)))
    
    (define/public (init-score)
      (set! curr-score 0))
    
    (super-new)))

;;----------Game Frames----------

(define hyper-window
  (new game-frame%
       [width 600]
       [height 800]
       [label "Don't touch the lava!"]
       [curr-score 0]))

;;Parent window for game-mode
(define main-game-window
  (new game-frame%
       [width 800]
       [height 800]
       [label "Don't touch the lava!"]
       [curr-score 0]))

;;----------Normal Frames----------

;;Window for wrong key pressed
(define wrong-key-window
  (new frame%
       [width 500]
       [height 300]
       [label "Don't touch the lava!"]))

;;Window for when time is up
(define end-game-window
  (new frame%
       [width 500]
       [height 300]
       [label "Don't touch the lava!"]))

;;Window to show before the game starts
(define start-window
  (new frame%
       [width 300]
       [height 100]
       [label "Let's play :)"]))

;;Menu Window
(define menu-window
  (new frame%
       [width 500]
       [height 300]
       [label "Main Menu"]))

;;Window for tutorial
(define tutorial-window
  (new frame%
       [width 600]
       [height 500]
       [label "Tutorial"]))

;;Window for credits
(define credits-window
  (new frame%
       [width 600]
       [height 400]
       [label "In the making of \"Don't touch the lava\""]))

;;----------Helpfunction to Separate the Game Modes from Eachother----------

 ;;Sets the curr-win to the specified game-mode
  (define (set-curr-win game-mode)
    (cond
      [(eq? game-mode 'casual)
       (set! curr-win main-game-window)]
      [(eq? game-mode 'hyper)
       (set! curr-win hyper-window)]
      [else (error "No valid game-mode in set-curr-canv." game-mode)]))


