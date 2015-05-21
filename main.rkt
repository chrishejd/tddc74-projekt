#lang racket

;;Purpose: Main file. Program runs from here 
;;Authors: Christoffer Hejdström (chrhe465) and Jonatan Gustafsson (jongu926)
;;Last change: Moved load highscore to highscore.rkt, 2015-05-20

(require "gameboard.rkt")
(require "brick.rkt")
(require "game-window-class.rkt")
(require "timer-start-window.rkt")
(require "highscore.rkt")
(require "main-menu.rkt")

;;Starts the menu window
(send menu-window show #t)
