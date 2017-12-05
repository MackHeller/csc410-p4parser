;(
#lang rosette
                                                      (require racket/match)
                                                      (require rosette/lib/synthax)
                                                      (require racket/include)(include "ults.rkt")
                                                      (define-synthax(gen-expression (booleanvariables ...) (integervariables ...) (integerconstants ...) height)
                                                        #:base (choose #t #f booleanvariables ... integervariables ... integerconstants ...)
                                                        #:else (choose #t #f booleanvariables ... integervariables ... integerconstants ...
                                                               ((choose = >= > <= < + - min max && || equal?) (gen-expression (booleanvariables ...)  (integervariables ...) (integerconstants ...) (- height 1))
                                                                                                              (gen-expression (booleanvariables ...)  (integervariables ...) (integerconstants ...) (- height 1)))
                                                               (if (gen-expression (booleanvariables ...)  (integervariables ...) (integerconstants ...) (- height 1))
                                                                   (gen-expression (booleanvariables ...)  (integervariables ...) (integerconstants ...) (- height 1))
                                                                   (gen-expression (booleanvariables ...)  (integervariables ...) (integerconstants ...) (- height 1)))
                                                                ((choose ! add1 sub1) (gen-expression (booleanvariables ...)  (integervariables ...) (integerconstants ...) (- height 1)))
                                                               )
                                                        ) (define-symbolic a integer?) (define-symbolic b integer?) (define (gen a b) (gen-expression () (a b) () 0)) (syntax->datum (car (generate-forms (synthesize #:forall (list a b) #:guarantee (assert (eq? (if #t a b) (gen a b))))))) ;)