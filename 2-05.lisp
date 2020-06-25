(let* ((chainring 52)
       (cog 11)
       (ratio (/ chainring (coerce cog 'float))))
  (format t "~d~%" ratio))

(let* ((chainring 20)
       (cog 27)
       (ratio (/ chainring (coerce cog 'float))))
  (format t "~d~%" ratio))
