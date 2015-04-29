#lang racket

;;----------Teststuff----------
(define high-file "highscore.txt")
(define high-lst (list (cons 1 10) (cons 2 5) (cons 3 2)))

(define (write-high score)
  (1))

(define (update-highscore score)
  (1))

(define out (open-output-file "/home/christoffer/code/highscore.txt" 
                              #:exists 'replace))
(write high-lst out)

(close-output-port out)

(define in (open-input-file "/home/christoffer/code/highscore.txt"))

(define lst (read in))

;;----------real stuff----------

(define highscore%
  (class object%
    (init-field high-lst path)
    
    ;;Returns the highscore list
    (define/public (get-highscore)
      high-lst)
    
    ;;Returns the score for place, if no place exists an error occurs
    (define/public (get-score place)
      (define (loop lst)
        (cond
          [(null? lst) 
           (error "No such place in highscore list. Place:" place)]
          [(= place (caar lst)) (cdr (car lst))]
          [else (loop (cdr lst))]))
      (loop high-lst))
    
    ;;loads the highscore
    (define/public (load-highscore)
      (define in (open-input-file path))
      (set! high-lst (read in))
      (close-input-port in))
    
    
    ;;Updates the highscore, inserts the score on right place
    (define/public (update-score score)
      (define (loop lst)
        (cond
          [(null? lst) '()]
          [(> score (cdr (car lst)))
           (cons (cons (caar lst) score) (cdr lst))]
          [else 
           (set! high-lst (cons (car lst) (loop (cdr lst))))]))
      
      (loop high-lst))
    
    (define/public (save-highscore)
      (1))
    
    (super-new)))




(define classic-highscore
  (new highscore%
       [high-lst '()]
       [path "/home/christoffer/code/highscore-classic.txt"]))

(send classic-highscore load-highscore)
