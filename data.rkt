;(#lang rosette
                                                      (require racket/match)
                                                      (require rosette/lib/synthax)
                                                      (require racket/include)(include "ults.rkt")
                                                      (define-synthax(gen-expression (booleanvariables ...) (integervariables ...) height)
                                                        #:base (choose booleanvariables ... integervariables ...)
                                                        #:else (choose
                                                                booleanvariables ... integervariables ...
                                                                ((choose >= > <= < + - && ||) (gen-expression (booleanvariables ...)  (integervariables ...) (- height 1))
                                                                                              (gen-expression (booleanvariables ...)  (integervariables ...) (- height 1)))
                                                                )
                                                        ) (define-symbolic a boolean?) (define-symbolic b boolean?) (define (gen a b) (gen-expression (a b) () 1)) (print-forms (synthesize #:forall (list a b) #:guarantee (assert (eq? (or a b) (or (gen-expression (a b) () 0) (gen-expression (a b) () 0)))))) ;)