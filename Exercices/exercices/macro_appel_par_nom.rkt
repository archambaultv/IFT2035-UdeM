#lang racket

(require compatibility/defmacro)

;; Première définition naïve de la macro or
(define-macro (or1 a b)
  `(if ,a ,a b))

;; La macro or1 évite d'évaluer la 2e expression lorsque
;; la première est vraie. Ceci ne serait pas le cas si
;; or1 était définie comme une fonction
(or1 #t (/ 1 0)) 

;; Toutefois la macro souffre d'un problème, car elle
;; évalue 2 fois son paramètre a s'il est vrai
(or1 (begin (display "Hello World") #t)
     #t)

;; On peut donc utiliser un let pour évaluer une seule fois
;; le paramètre a
(define-macro (or2 a b)
  `(let ((tmp ,a)) (if tmp tmp ,b)))

;; Toutefois, ceci introduit un problème de capture de nom
;; Le code ci-dessous ne respecte pas la portée lexicale
;; Problème connu sous le nom de : Introduced Binder Hygiene
(let ((tmp #t))
  (or2 #f tmp)) ;; Retourne #f au lieu de #t

;; De plus, il y a d'autre problème.
;; Le code ci-dessous change la définition de if
;; Problème connu sous le nom de : Reference Hygiene
(let ((if (lambda (x y z) y)))
  (or2 #f #t)) ;; Retourne #f au lieu de #t


;; Il est possible de corriger le premier problème
(define-macro (or a b)
  (let ((var (gensym)))
    `(let ((,var ,a)) (if ,var ,var ,b))))

(let ((tmp #t))
  (or #f tmp)) ;; Retourne correctement #f
