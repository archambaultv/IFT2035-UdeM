
(define-macro (while condition expr)
  (let ((my-loop (gensym)))
    `(let ,my-loop ()
       (if ,condition
         (begin
           ,expr
           (,my-loop))))))
      
;check_while
