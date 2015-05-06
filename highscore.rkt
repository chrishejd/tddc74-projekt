#lang racket
(provide highscore%)
(provide classic-highscore)
(define classic-score-path "/home/chrhe465/Desktop/highscore-classic.txt")

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
    (define/public (update-score! score)
      (define (loop lst)
        (cond
          [(null? lst) '()]
          [(> score (cdr (car lst)))
           (cons (cons (+ 1 (caar lst)) (cdr (car lst))) (loop (cdr lst)))]
          [(<= score (cdr (car lst)))
           (cons (cons (+ 1 (caar lst)) score) lst)]
          [else (error "Update-score no testcase.")]))
      
      (let ((new-high-lst (loop (reverse high-lst))))
        (if (> (length new-high-lst) 10)
            (set! high-lst (reverse (cdr new-high-lst)))
            (set! high-lst (reverse new-high-lst)))))
    
    ;;Saves the highscore to path
    (define/public (save-highscore)
      (let ((out (open-output-file path #:exists 'truncate)))
        (begin 
          (write high-lst out)
          (close-output-port out))))
    
    ;;Makes a string of the form "rank:    score"
    (define/public (rank->string rank)
      (string-append (string-append
                      (number->string rank)
                      ":    ")
                     (number->string (send this get-score rank))))
    
    (super-new)))

;;----------Highscore objects----------

(define classic-highscore
  (new highscore%
       [high-lst '()]
       [path classic-score-path]))
