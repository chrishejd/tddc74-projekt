#lang racket/gui
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

;;Holder for the current canvas
(define curr-win (void))

;;a cnvas class with a keyboard handler
(define game-canvas%
  (class canvas%
    (init-field [keyboard-handler display])
    
    (define/override (on-char key-event)
      (keyboard-handler key-event))
    
    (super-new)))

;;frame for the game score is how many bricks have been clicked
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

;;window to show if thewrong key is pressed
(define wrong-key-window
  (new frame%
       [width 500]
       [height 300]
       [label "Don't touch the lava!"]))

;;window to show if the time is up
(define end-game-window
  (new frame%
       [width 500]
       [height 300]
       [label "Don't touch the lava!"]))

;;window to show before the game starts
(define start-window
  (new frame%
       [width 300]
       [height 100]
       [label "Let's play :)"]))

(define menu-window
  (new frame%
       [width 500]
       [height 300]
       [label "Main Menu"]))

(define tutorial-window
  (new frame%
       [width 600]
       [height 500]
       [label "Tutorial"]))

(define credits-window
  (new frame%
       [width 600]
       [height 400]
       [label "In the making of \"Don't touch the lava\""]))

 ;;Sets the curr-win to the specified game-mode
  (define (set-curr-win game-mode)
    (cond
      [(eq? game-mode 'casual)
       (set! curr-win main-game-window)]
      [(eq? game-mode 'hyper)
       (set! curr-win hyper-window)]
      [else (error "No valid game-mode in set-curr-canv." game-mode)]))


