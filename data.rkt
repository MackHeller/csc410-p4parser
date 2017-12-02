;(
#lang rosette
                                                      (require racket/match)
                                                      (require rosette/lib/synthax)
                                                      (require racket/include)(include "ults.rkt")
                                                      (define-synthax(gen-expression (booleanvariables ...) (integervariables ...) height)
                                                        #:base (choose booleanvariables ... integervariables ...)
                                                        #:else (choose #t #f booleanvariables ... integervariables ...
                                                               ((choose >= > <= < + - && ||) (gen-expression (booleanvariables ...)  (integervariables ...) (- height 1))
                                                                                             (gen-expression (booleanvariables ...)  (integervariables ...) (- height 1)))
                                                               (! (gen-expression (booleanvariables ...)  (integervariables ...) (- height 1)))
                                                               )
                                                        ) (define-symbolic a boolean?) (define-symbolic b boolean?) (define-symbolic c boolean?) (define (gen a b c) (gen-expression (a b c) () 2)) (syntax->datum (car (generate-forms (synthesize #:forall (list a b c) #:guarantee (assert (eq? (and (or (and (or a b) (and b c)) (and b (or a c))) (and b (or (and a c) (or c b)))) (gen a b c))))))) ;)