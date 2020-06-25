(defpackage :poodl2.3-30
  (:use :cl))
(in-package :poodl2.3-30)

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
;;; using fixed args
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

(defun new-gear (chainring cog wheel)
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
  (gear-inches
    (new-gear 52
              11
              (new-wheel 26 1.5))))
; => 137.0909

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; using hash
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

(defun new-gear (args)
  (make-instance 'gear
    :chainring (cdr (assoc 'chainring args))
    :cog (cdr (assoc 'cog args))
    :wheel (cdr (assoc 'wheel args))))
; ...
(defgeneric gear-inches (gear))
(defmethod gear-inches ((gear gear))
  (* (ratio gear) (diameter (wheel gear))))

(defgeneric ratio (gear))
(defmethod ratio ((gear gear))
  (/ (chainring gear) (coerce (cog gear) 'float)))

(format t "~a~%"
  (gear-inches
    (new-gear (list
                (cons 'chainring 52)
                (cons 'cog 11)
                (cons 'wheel (new-wheel 26 1.5))))))
; => 137.0909

(format t "~a~%"
  (gear-inches
    (new-gear (list
                (cons 'wheel (new-wheel 26 1.5))
                (cons 'chainring 52)
                (cons 'cog 11)))))
; => 137.0909

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; using keyword args
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

(defun new-gear (&key chainring cog wheel)
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
  (gear-inches
    (new-gear
      :chainring 52
      :cog 11
      :wheel (new-wheel 26 1.5))))
; => 137.0909

(format t "~a~%"
  (gear-inches
    (new-gear
      :wheel (new-wheel 26 1.5)
      :chainring 52
      :cog 11)))
; => 137.0909

