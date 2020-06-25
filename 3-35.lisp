(defpackage :poodl2.3-35
  (:use :cl))
(in-package :poodl2.3-35)

(defclass wheel ()
  ((rim
     :initarg :rim
     :reader rim)
   (tire
     :initarg :tire
     :reader tire)))

(defun new-wheel (rim tire)
  (make-instance 'wheel :rim rim :tire tire))

(defgeneric diameter (wheel))
(defmethod diameter ((wheel wheel))
  (+ (rim wheel) (* (tire wheel) 2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; KEYWORD ARGS
;;;    keyword arg with simple defaults
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass gear ()
  ((chainring
     :initarg :chainring
     :reader chainring)
   (cog
     :initarg :cog
     :reader cog)
   (wheel
     :initarg :wheel
     :reader wheel)))

(defun new-gear (&key (chainring 40) (cog 18) wheel)
  (make-instance 'gear
    :chainring chainring
    :cog cog
    :wheel wheel))
; ...
(defgeneric gear-inches (gear))
(defmethod gear-inches ((gear gear))
  (* (ratio gear) (diameter (wheel gear))))

(defgeneric ratio (gear))
(defmethod ratio ((gear gear))
  (/ (chainring gear) (coerce (cog gear) 'float)))

(format t "~a~%"
  (chainring (new-gear :wheel (new-wheel 26 1.5))))
; => 40

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; KEYWORD ARGS
;;;    keyword arg with defaults
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defclass gear ()
  ((chainring
     :initarg :chainring
     :reader chainring)
   (cog
     :initarg :cog
     :reader cog)
   (wheel
     :initarg :wheel
     :reader wheel)))

(defun new-gear (&key (chainring (default-chainring)) (cog 18) wheel)
  (make-instance 'gear
    :chainring chainring
    :cog cog
    :wheel wheel))

(defun default-chainring ()
  (- (/ 100 2) 10)) ; silly code, useful example
; ...
(defgeneric gear-inches (gear))
(defmethod gear-inches ((gear gear))
  (* (ratio gear) (diameter (wheel gear))))

(defgeneric ratio (gear))
(defmethod ratio ((gear gear))
  (/ (chainring gear) (coerce (cog gear) 'float)))

(format t "~a~%"
  (chainring (new-gear :wheel (new-wheel 26 1.5))))
; => 40

(format t "~a~%"
  (chainring (new-gear :chainring 52 :wheel (new-wheel 26 1.5))))
; => 52
