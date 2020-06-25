(defclass gear ()
  ((chainring
    :initarg :chainring
    :reader chainring)
   (cog
    :initarg :cog
    :reader cog)))

(defgeneric ratio (gear))

(defmethod ratio ((g gear))
  (/ (chainring g) (coerce (cog g) 'float)))

(format t "~d~%" (ratio (make-instance 'gear :chainring 52 :cog 11)))
(format t "~d~%" (ratio (make-instance 'gear :chainring 30 :cog 27)))
