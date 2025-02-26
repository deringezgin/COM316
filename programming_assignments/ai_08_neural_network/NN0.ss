; Derin Gezgin
; COM316: Artificial Intelligence | Fall 2024
; Programming Assignment #8
; Due November 19 2024
; File that has the code with responses to the questions in the homework.

(define threshold-weights '(((1.5 1 1))))
; When I run these set of weights, I get the following output
; Input: (0 0) | Output: 0
; Input: (0 1) | Output: 0
; Input: (1 0) | Output: 0
; Input: (1 1) | Output: 1
; In this case, these weights belong to the AND logic function

;(define threshold-weights '(((.6 1 -.5) (.6 -.5 1)) ((.4 1 1))))
; When I run these set of weights, I get the following output
; Input: (0 0) | Output: 0
; Input: (0 1) | Output: 1
; Input: (1 0) | Output: 1
; Input: (1 1) | Output: 0
; In this case, these weights belong to the XOR logic function

;(define threshold-weights '(((0.5 1 1))))
; This is the set of weights I added for the OR logic function
; Compared to AND, the only part that should change is the threshold
; When I run these set of weights, I get the following output
; Input: (0 0) | Output: 0
; Input: (0 1) | Output: 1
; Input: (1 0) | Output: 1
; Input: (1 1) | Output: 1
; In this case, these weights belong to the OR logic function

;(define threshold-weights '(((.6 1 -.5) (.6 -.5 1)) ((-0.5 -1 -1))))
; This is the set of weights I added for the NOT XOR logic function
; For the NOT XOR, I just have to change the final layer to ensure the NOT part compared to the regular XOR.
; When I run these set of weights, I get the following output
; Input: (0 0) | Output: 1
; Input: (0 1) | Output: 0
; Input: (1 0) | Output: 0
; Input: (1 1) | Output: 1
; In this case, these weights belong to the NOT XOR logic function

(define NN
  (lambda (lst)
    (NN2 lst threshold-weights)))

(define NN2
  (lambda (lst tw)
    (display lst)
    (newline)
    (if (null? tw)
      lst
    ;else
      (let ((next-level (get-next-level lst (car tw))))
         (NN2 next-level (cdr tw))))))

(define get-next-level
  (lambda (lst twl)
     (if (null? twl)
       '()
     ;else
       (cons (get-node lst (car twl)) (get-next-level lst (cdr twl))))))

(define get-node
  (lambda (lst twn)
    (let ((threshold (car twn))
          (weights (cdr twn)))
      (g (+ (get-activations lst weights) (- threshold))))))

(define get-activations
  (lambda (lst w)
    (if (null? lst)
       0
    ;else
       (+ (* (car lst) (car w)) (get-activations (cdr lst) (cdr w))))))

(define g
  (lambda (x)
    (if (> x 0) 1 0)))

(define test-nn
  (lambda ()
    (display "Output for ")
    (NN '(0 0))
    (newline)
    (display "Output for ")
    (NN '(0 1))
    (newline)
    (display "Output for ")
    (NN '(1 0))
    (newline)
    (display "Output for ")
    (NN '(1 1))
    (newline)))

; Running the test function to  see the output for each input combination
(test-nn)