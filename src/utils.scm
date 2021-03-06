(define (prn x)
  (with-output-to *stderr*
		  (display x) (newline))
  x)

(define (lookup elt alst default)
  (let ((a (assq elt alst)))
    (if a (cdr a) default)))

(define (index-p pred lst start)
  (cond ((null? lst) #f)
	((pred (car lst)) start)
	(else (index-p pred (cdr lst) (+ start 1)))))

(define (diff s1 s2)
  (cond ((null? s1)         '())
	((memq (car s1) s2) (diff (cdr s1) s2))
	(else               (cons (car s1) (diff (cdr s1) s2)))))

(define (unique lst) (delete-duplicates lst))

(define (has-dups lst)
  (if (null? lst)
      #f
      (or (memq (car lst) (cdr lst))
	  (has-dups (cdr lst)))))

(define (contains p expr)
  (or (p expr)
      (and (pair? expr)
	   (any (lambda (x) (contains p x))
		expr))))

(define (butlast lst)
  (if (or (null? lst) (null? (cdr lst)))
      '()
      (cons (car lst) (butlast (cdr lst)))))

(define (last lst)
  (if (null? (cdr lst))
      (car lst)
      (last (cdr lst))))

(define *gensyms* '())
(define *current-gensyms* '())
(define *gensy-counter* 1)
(define (gensy)
  (if (null? *current-gensyms*)
      (let ((g (symbol (string "#s" *gensy-counter*))))
	(set! *gensy-counter* (+ *gensy-counter* 1))
	(set! *gensyms* (cons g *gensyms*))
	g)
      (begin0 (car *current-gensyms*)
	      (set! *current-gensyms* (cdr *current-gensyms*)))))
(define (named-gensy name)
  (let ((g (symbol (string name "#" *gensy-counter*))))
    (set! *gensy-counter* (+ *gensy-counter* 1))
    g))
(define (reset-gensyms)
  (set! *current-gensyms* *gensyms*))
