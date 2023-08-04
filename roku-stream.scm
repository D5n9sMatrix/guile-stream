;; roku-stream.scm

(use-modules (ice-9 streams))

(define odds (make-stream (lambda (state)
                            (cons state (+ state 2)))
                          1))
(stream-car odds)              
(stream-car (stream-cdr odds))


(define (square n) (* n n))
(define oddsquares (stream-map square odds))


(stream-for-each (lambda (n sq)
                   (format #t "~a squared is ~a\n" n sq))
                 odds oddsquares)
