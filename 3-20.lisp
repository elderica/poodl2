(defpackage :poodl2.3-20
  (:use :cl))
(in-package :poodl2.3-20)

(defclass gear ()
  ((chainring
     :initarg :chainring
     :reader chainring)
   (cog
     :initarg :cog
     :reader cog)
   (rim
     :initarg :rim
     :reader rim)
   (tire
     :initarg :tire
     :reader tire)
   (wheel
     :initarg :wheel)))

(defun new-gear (chainring cog rim tire)
  (make-instance 'gear
    :chainring chainring
    :cog cog
    :rim rim
    :tire tire))

(defgeneric gear-inches (gear))
(defmethod gear-inches ((gear gear))
  (* (ratio gear) (diameter (wheel gear))))

(defgeneric wheel (gear))
(defmethod wheel ((gear gear))
  (with-slots (wheel) gear
    (unless (slot-boundp gear 'wheel)
      (setf wheel (new-wheel (rim gear) (tire gear))))
    wheel))

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
