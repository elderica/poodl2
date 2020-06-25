(defpackage :poodl2.2-30-1
  (:use :cl))
(in-package :poodl2.2-30-1)

(defclass revealing-references ()
  ((wheels
    :initarg :wheels
    :reader wheels)))

(defun new-revealing-references (data)
  (make-instance 'revealing-references :wheels (wheelify data)))

; first - iterate over the array
(defgeneric diameters (rr))
(defmethod diameters ((rr revealing-references))
  (loop for wheel in (wheels rr)
        collect (diameter wheel)))

; second - calculate diameter of ONE wheel
(defun diameter (wheel)
  (+ (wheel-rim wheel) (* (wheel-tire wheel) 2)))

; ... now everyone can send rim/tire to wheel
(defstruct wheel
  rim
  tire)

(defun wheelify (data)
  (loop for cell in data
        collect (make-wheel :rim (first cell) :tire (second cell))))

; rim and tire sizes (now in milimeters!) in a 2d array
(defparameter *data* '((622 20) (622 23) (559 30) (559 40)))

(format t "revealing-references diameters = ~a~%"
  (diameters (new-revealing-references *data*)))

(defpackage :poodl2.2-30-2
  (:use :cl))
(in-package :poodl2.2-30-2)

; gear-inches does too much
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
     :reader tire)))

(defun new-gear (chainring cog rim tire)
  (make-instance 'gear
     :chainring chainring
     :cog cog
     :rim rim
     :tire tire))

(defgeneric ratio (gear))
(defmethod ratio ((gear gear))
  (/ (chainring gear) (coerce (cog gear) 'float)))

(defgeneric ratio (gear))
(defmethod gear-inches ((gear gear))
  ; tire goes around rim twice for diameter)
  (* (ratio gear) (+ (rim gear) (* (tire gear) 2))))

(format t "1st gear gear-inches = ~a~%"
  (gear-inches (new-gear 54 11 622 20)))

(defpackage :poodl2.2-30-3
  (:use :cl))
(in-package :poodl2.2-30-3)

; diameter method doesn't belong in Gear, notice it
; depends on rim and tire only
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
     :reader tire)))

(defun new-gear (chainring cog rim tire)
  (make-instance 'gear
     :chainring chainring
     :cog cog
     :rim rim
     :tire tire))

(defgeneric ratio (gear))
(defmethod ratio ((gear gear))
  (/ (chainring gear) (coerce (cog gear) 'float)))

(defgeneric ratio (gear))
(defmethod gear-inches ((gear gear))
  ; tire goes around rim twice for diameter)
  (* (ratio gear) (diameter gear)))

(defgeneric diameter (gear))
(defmethod diameter ((gear gear))
  (+ (rim gear) (* (tire gear) 2)))

(format t "2nd gear gear-inches = ~a~%"
  (gear-inches (new-gear 54 11 622 20)))
