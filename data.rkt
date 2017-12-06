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
                                                        ) (define-symbolic xm integer?) (define-symbolic lm integer?) (define-symbolic xm2 integer?) (define-symbolic lm2 integer?) (define (gen xm lm xm2 lm2) (gen-expression () (xm lm xm2 lm2) (0) 2)) (syntax->datum (car (generate-forms (synthesize #:forall (list xm lm xm2 lm2) #:guarantee (assert (eq? (min (max (+ xm (min 0 0)) lm) (min xm2 lm2)) (gen xm lm xm2 lm2))))))) ;)