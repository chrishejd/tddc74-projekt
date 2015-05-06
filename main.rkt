#lang racket
(require "gameboard.rkt")
(require "brick.rkt")
(require "game-window-class.rkt")
(require "timer-start-window.rkt")
(require "highscore.rkt")

(init-bricks)
(send classic-highscore load-highscore)
(send main-game-window show #t)
(send start-window show #t)
