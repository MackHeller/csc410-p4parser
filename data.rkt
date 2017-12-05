;(
#lang rosette
                                                      (require racket/match)
                                                      (require rosette/lib/synthax)
                                                      (require racket/include)(include "ults.rkt")
                                                      (define-synthax(gen-expression (booleanvariables ...) (integervariables ...) (integerconstants ...) height)
                                                        #:base (choose #t #f 5 booleanvariables ... integervariables ... integerconstants ...)
                                                        #:else (choose #t #f booleanvariables ... integervariables ... integerconstants ...
                                                               ((choose >= > <= < + - && || min max) (gen-expression (booleanvariables ...)  (integervariables ...) (integerconstants ...) (- height 1))
                                                                                             (gen-expression (booleanvariables ...)  (integervariables ...) (integerconstants ...) (- height 1)))
                                                               (! (gen-expression (booleanvariables ...)  (integervariables ...) (integerconstants ...) (- height 1)))
                                                               ((choose add1 sub1) (gen-expression (booleanvariables ...)  (integervariables ...) (integerconstants ...) (- height 1)))
                                                               )
                                                        ) (define (gen) (gen-expression () () (4) 1)) (syntax->datum (car (generate-forms (synthesize #:forall (list) #:guarantee (assert (eq? (add1 4) (gen))))))) ;)