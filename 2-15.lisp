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

(defgeneric ratio (gear))

(defmethod ratio ((g gear))
  (/ (chainring g) (coerce (cog g) 'float)))

(defgeneric gear-inches (gear))

(defmethod gear-inches ((g gear))
  (* (ratio g) (+ (rim g) (* (tire g) 2.0))))

(format t "~d~%" (gear-inches (make-instance 'gear :chainring 52 :cog 11 :rim 26 :tire 1.5)))
(format t "~d~%" (gear-inches (make-instance 'gear :chainring 52 :cog 11 :rim 24 :tire 1.25)))
(format t "~d~%" (gear-inches (make-instance 'gear :chainring 52 :cog 11)))
