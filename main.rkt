#lang racket
(require "gameboard.rkt")
(require "brick.rkt")
(require "game-window-class.rkt")
(require "timer-start-window.rkt")
(require "highscore.rkt")
(require "main-menu.rkt")

(send classic-highscore load-highscore)
(send menu-window show #t)
