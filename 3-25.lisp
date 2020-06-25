(defpackage :poodl2.3-25
  (:use :cl))
(in-package :poodl2.3-25)

(defgeneric gear-inches (gear))

(defmethod gear-inches ((gear gear))
  (* (ratio gear) (diameter (wheel gear))))

(defmethod gear-inches ((gear gear))
  ;... a few lines of scary math
  (setf (foo gear) (* some-intermediate-result)
                   (diameter (wheel gear))))
  ;... more lines of scary math

(defmethod gear-inches ((gear gear))
  ;... a few lines of scary math
  (setf (foo gear) (* some-intermediate-result)
                   (diameter gear)))
  ;... more lines of scary math

(defmethod diameter ((gear gear))
  (diameter (wheel gear)))
