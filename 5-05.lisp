(defpackage :poodl2.5-05
  (:use :cl))
(in-package :poodl2.5-05)

(defclass trip ()
  ((bicycles
     :initarg :bicycles
     :reader bicycles)
   (customers
     :initarg :customers
     :reader customers)
   (vehicle
     :initarg :vehicle
     :reader vehicle)))

(defun new-trip (bicycles customers vehicle)
  (make-instance 'trip
    :bicycles bicycles
    :customers customers
    :vehicle vehicle))

; this 'mechanic' argument could be of any class

(defgeneric prepare (trip mechanic))
(defmethod prepare ((trip trip) mechanic)
  (prepare-bicycles mechanic (bicycles trip)))

; ...

; if you happen to pass an instance of *this* class,
; it works

(defclass mechanic ()
  ())

(defun new-mechanic ()
  (make-instance 'mechanic))

(defgeneric prepare-bicycles (mechanic bicycles))
(defmethod prepare-bicycles ((mechanic mechanic) bicycles)
  (loop for bicycle in bicycles
        collect (prepare-bicycles mechanic bicycle)))

(defgeneric prepare-bicycle (mechanic bicycle))
(defmethod prepare-bicycle ((mechanic mechanic) bicycle))
  ; ...

(defclass bicycle ()
  ())

(defun new-bicycle ()
  (make-instance 'bicycle))

(defclass customer ()
  ())

(defun new-customer ()
  (make-instance 'customer))

(defclass vehicle ()
  ())

(defun new-vehicle ()
  (make-instance 'vehicle))

(prepare
  (new-trip
    (list (new-bicycle) (new-bicycle) (new-bicycle))
    (list (new-customer) (new-customer))
    (new-vehicle))
  (new-mechanic))

