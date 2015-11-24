;;; Bill Xue
;;; 2015-11-24
;;; Driver Loop for test our evaluator core

(load "evaluator-core.scm")

(define input-prompt "||>")
(define output-prompt "||")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output (eval-me input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))

  (driver-loop))

(define (prompt-for-input string)
  (newline) (newline)
  (display string))

(define (announce-output string)
  (newline)
  (display string))

(define (user-print object)
  (if (compound-procedure? object)
      (display (list 'compound-procedure
                     (procedure-parameters object)
                     (procedure-body object)
                     '<procedure-env>))
      (display object)))

(trace eval-me)
(trace apply-me)

(driver-loop)
