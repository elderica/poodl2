(defclass gear ()
  ((chainring
    :initarg :chainring)
   (cog
    :initarg :cog)))

(defgeneric ratio (gear))

(defmethod ratio ((g gear))
  (/ (slot-value g 'chainring) (coerce (slot-value g 'cog) 'float))) ; <-- road to ruin

(format t "1st ratio = ~d~%" (ratio (make-instance 'gear :chainring 52 :cog 11)))

(defclass gear ()
  ((chainring
    :initarg :chainring
    :reader chainring)                                               ; <-------
   (cog
    :initarg :cog
    :reader cog)))                                                   ; <-------

(defmethod ratio ((g gear))
  (/ (chainring g) (coerce (cog g) 'float)))                         ; <-------

(format t "2nd ratio = ~d~%" (ratio (make-instance 'gear :chainring 52 :cog 11)))

; default-ish implementation via :reader
(defmethod cog ((g gear))
  (slot-value g 'cog))

; a simple reimplementation of cog
(defmethod cog ((g gear))
  (* (slot-value g 'cog) *unanticipated-adjustment-factor*))

; a more complex one
(defmethod cog ((g gear))
  (* (slot-value g 'cog) (if foo *bar-adjustment* *baz-adjustment*)))

(defclass blinkered () ())

(defgeneric bcog (blinkered gear))                           ; Gear's cog and Blinkered's cog are incompatible

(defmethod bcog ((b blinkered) gear)
  (cog gear))

(format t "~a~%" (bcog (make-instance 'blinkered) (make-instance 'gear :chainring 52 :cog 11)))
