(defpackage :poodl2.3-15
  (:use :cl))
(in-package :poodl2.3-15)

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

(defun new-gear (chainring cog rim tire)
  (make-instance 'gear
    :chainring chainring
    :cog cog
    :wheel (new-wheel rim tire)))

(defgeneric gear-inches (gear))
(defmethod gear-inches ((gear gear))
  (* (ratio gear) (diameter (wheel gear))))

(defgeneric ratio (gear))
(defmethod ratio ((gear gear))
  (/ (chainring gear) (coerce (cog gear) 'float)))

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

(format t "~a~%" (gear-inches (new-gear 52 11 26 1.5)))
; => 137.0909
