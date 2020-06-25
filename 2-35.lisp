(defpackage :poodl2.2-35
  (:use :cl))
(in-package :poodl2.2-35)

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
    :wheel (make-wheel :rim rim :tire tire)))

(defgeneric ratio (gear))
(defmethod ratio ((gear gear))
  (/ (chainring gear) (coerce (cog gear) 'float)))

(defgeneric gear-inches (gear))
(defmethod gear-inches ((gear gear))
  (* (ratio gear) (diameter (wheel gear))))

(defstruct wheel
  rim
  tire)

(defun diameter (wheel)
  (declare (type wheel wheel))
  (+ (wheel-rim wheel) (* (wheel-tire wheel) 2)))

(format t "gear gear-inches = ~a~%" (gear-inches (new-gear 54 11 622 20)))
