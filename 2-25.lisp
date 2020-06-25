(defclass obscuring-references ()
  ((data
    :initarg :data
    :reader data)))

(defgeneric diameters (or))

(defmethod diameters ((or obscuring-references))
  ; first is rim, second is tire
  (loop for cell in (data or) collect (+ (first cell) (* (second cell) 2))))

; rim and tire sizes (now in milimeters!) in a 2d array
(defparameter *data* '((622 20) (622 23) (559 30) (559 40)))

(defclass wheel ()
  ((rim
    :initarg :rim
    :reader rim)
   (tire
    :initarg :tire
    :reader tire)))

(defclass revealing-references ()
  ((wheels
    :initarg :data
    :reader wheels)))

(defgeneric wheelify (rr data))

; now everyone can send rim/tire to wheel
(defmethod wheelify ((rr revealing-references) data)
  (loop for cell in data
        collect (make-instance 'wheel :rim (first cell) :tire (second cell))))

(defmethod initialize-instance :after ((rr revealing-references) &key)
  (setf (slot-value rr 'wheels) (wheelify rr (slot-value rr 'wheels))))

(defmethod diameters ((rr revealing-references))
  (loop for wheel in (wheels rr)
        collect (+ (rim wheel) (* (tire wheel) 2))))

; ensure the code compiles and executes
(format t "obscuring-references diameters = ~a~%" (diameters (make-instance 'obscuring-references :data *data*)))
(format t "revealing-references diameters = ~a~%" (diameters (make-instance 'revealing-references :data *data*)))
