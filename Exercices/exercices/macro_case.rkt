#lang racket

(require compatibility/defmacro)

(define-macro (case-naive exp . patterns)
  (letrec ((build-clauses
            (lambda (x)
              (if (null? x)
                  '(error "Non exhaustive pattern")
                  (let* ((next (car x))
                         (test (car next))
                         (res (cadr next)))
                    `(if (member tmp ',test)
                         ,res
                         ,(build-clauses (cdr x))))))))
    `(let ((tmp ,exp))
       ,(build-clauses patterns))))
  
(case-naive (+ 1 3) ((1) 1) ((2) 2) ((3) 3) ((4) 4) ((5) 5))


(case-naive (+ 7 3) ((1 2 3 4 5) 1) ((6 7 8 9 10) 2))

; Le code ci-dessous ne respecte pas la portée lexicale
; Problème connu sous le nom de : Introduced Binder Hygiene
(let ((tmp 2))
  (case-naive (+ tmp tmp) ((1 2 3 4) tmp)))

; Le code ci-dessous change la définition de member
; Problème connu sous le nom de : Reference Hygiene
(let ((member (lambda (x y) #t)))
  (case-naive 1 ((0) 0) ((1) 1)))

; Il est possible de corriger le premier problème
(define-macro (case exp . patterns)
  (letrec ((var (gensym))
           (build-clauses
            (lambda (x)
              (if (null? x)
                  '(error "Non exhaustive pattern")
                  (let* ((next (car x))
                         (test (car next))
                         (res (cadr next)))
                    `(if (member ,var ',test) ; ,var pas tmp
                         ,res
                         ,(build-clauses (cdr x))))))))
    `(let ((,var ,exp))
       ,(build-clauses patterns))))

(let ((tmp 2))
  (case (+ tmp tmp) ((1 2 3 4) tmp)))
