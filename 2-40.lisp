(defpackage :poodl2.2-40
  (:use :cl))
(in-package :poodl2.2-40)

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

(defun new-gear (chainring cog &optional (wheel nil))
  (make-instance 'gear
    :chainring chainring
    :cog cog
    :wheel wheel))

(defgeneric ratio (gear))
(defmethod ratio ((gear gear))
  (/ (chainring gear) (coerce (cog gear) 'float)))

(defgeneric gear-inches (gear))
(defmethod gear-inches ((gear gear))
  (* (ratio gear) (diameter (wheel gear))))

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

(defgeneric circumference (wheel))
(defmethod circumference ((wheel wheel))
  (* (diameter wheel) pi))

(defparameter *wheel* (new-wheel 26 1.5))
(format t "~a~%" (circumference *wheel*))
; => 91.106186954104D0

(format t "~a~%" (gear-inches (new-gear 52 11 *wheel*)))
; => 137.0909

(format t "~a~%" (ratio (new-gear 52 11)))
; => 4.7272725
