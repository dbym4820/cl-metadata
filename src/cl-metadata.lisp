(in-package :cl-user)

(defpackage cl-metadata
  (:use :cl)
  (:nicknames :metadata)
  (:import-from :cl-annot
                :enable-annot-syntax)
  (:import-from :local-time
		:now
		:timestamp-year
		:timestamp-month
		:timestamp-day
		:timestamp-hour
		:timestamp-minute
		:timestamp-second))

(in-package :cl-metadata)
(enable-annot-syntax)

(defun random-id-number (max-num)
  (format nil "~4,,,'0@A~4,,,'0@A~4,,,'0@A" (random max-num) (random max-num) (random max-num)))

(defun make-counter ()
  (let ((cnt 0))
    (lambda ()
      (incf cnt))))
(defparameter *counter* (make-counter))

@export
(defun generate-id ()
  "Generate Unique ID from timestamp"
  (let* ((now-time (now))
	 (year (timestamp-year now-time))
	 (month (timestamp-month now-time))
	 (day (timestamp-day now-time))
	 (hour (timestamp-hour now-time))
	 (mini (timestamp-minute now-time))
	 (sec (timestamp-second now-time))
	 (generated-number (funcall *counter*))
	 (timestamp (format nil "~A~A~A~A~A~A~A~A" year month day hour mini sec (random-id-number 1000) generated-number)))
    timestamp))

@export
(defclass data ()
  ((data-content :initarg :content :accessor data-content)
   (data-metadata :initarg :metadata :accessor metadata-content)))

@export
(defclass data-file (data)
  ((file-path :initarg :file-path :accessor file-path)))

@export
(defgeneric show-metadatas (d))

@export
(defmethod show-metadatas ((d data-file))
  (let ((metadata (metadata-content d)))
    (format nil "ID: ~A~%NAME: ~A~%TYPE: ~A~%FILE-PATH: ~A~%" (data-id metadata) (data-name metadata) (data-type metadata) (file-path d))))

@export
(defmethod show-metadatas ((d data))
  (let ((metadata (metadata-content d)))
    (format nil "ID: ~A~%NAME: ~A~%TYPE: ~A~%" (data-id metadata) (data-name metadata) (data-type metadata))))

@export
(defclass basic-metadata ()
  ((data-id :initarg :id :reader data-id)
   (metadata-name :initarg :name :accessor data-name)
   (data-type :initarg :type :reader data-type)))

   
@export
(defun make-metadata (data-name data-type)
  (make-instance 'basic-metadata :id (generate-id) :name data-name :type data-type))


@export
(defun make-data (data-content metadata &key file-path)
  "Instanciate general data as a CL Object"
  (if file-path
      (make-instance 'data-file :file-path file-path :content data-content :metadata metadata)
      (make-instance 'data :content data-content :metadata metadata)))

@export
(defun make-data-with-metadata (data-content metadata-name data-type &key file-path)
  "Instanciate general data as a CL Object"
  (let ((metadata-instance (make-metadata metadata-name data-type)))
    (if file-path
	(make-instance 'data-file :file-path file-path :content data-content :metadata metadata-instance)
	(make-instance 'data :content data-content :metadata metadata-instance))))
