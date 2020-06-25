; When gear is part of an external interface
(defpackage :poodl2.3-40.some-framework
  (:use :cl)
  (:shadowing-import-from :poodl2.3-40
    :diameter)
  (:export
    :gear
    :new-gear
    :gear-inches
    :ratio))
(in-package :poodl2.3-40.some-framework)

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

; wrap the interface to protect yourself from changes
(defpackage :poodl2.3-40.gear-wrapper
  (:import-from :poodl2.3-40.some-framework
    :new-gear)
  (:export
    :gear))
(in-package :poodl2.3-40.gear-wrapper)

(defun gear (&key chainring cog wheel)
  (new-gear chainring cog wheel))

(defpackage :poodl2.3-40
  (:use :cl)
  (:import-from :poodl2.3-40.gear-wrapper
    :gear)
  (:import-from :poodl2.3-40.some-framework
    :gear-inches)
  (:export :diameter))
(in-package :poodl2.3-40)

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

; Now you can create a new Gear using keyword arguments
(format t "~a~%"
  (gear-inches
    (gear
      :chainring 52
      :cog 11
      :wheel (new-wheel 26 1.5))))
; => 137.0909
