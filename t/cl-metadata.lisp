(in-package :cl-user)
(defpackage cl-metadata-test
  (:use :cl
        :cl-metadata
        :prove))
(in-package :cl-metadata-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-metadata)' in your Lisp.

(setf *enable-colors* nil)

(plan 8)

(subtest "generate-id test"
  (is-type (generate-id) 'string))

(subtest "data test"
  (let ((test-instance (make-instance 'data :content 'foo :metadata 'bar)))
    (is (cl-metadata::data-content test-instance) 'foo)
    (is (cl-metadata::metadata-content test-instance) 'bar)))

(subtest "data-file test"
  (let ((test-instance (make-instance 'data-file :file-path #p"foo/bar")))
    (is (cl-metadata::file-path test-instance) #p"foo/bar")))

(subtest "basic-metadata test"
  (let ((test-instance (make-instance 'basic-metadata :id 'foo :name 'bar :type 'baz)))
    (is (cl-metadata::data-id test-instance) 'foo)
    (is (cl-metadata::data-name test-instance) 'bar)
    (is (cl-metadata::data-type test-instance) 'baz)))

(subtest "make-metadata test"
  (let ((test-instance (make-metadata 'foo 'bar)))
    (ok (cl-metadata::data-id test-instance))
    (is (cl-metadata::data-name test-instance) 'foo)
    (is (cl-metadata::data-type test-instance) 'bar)))

(subtest "make-data test"
  (let* ((metadata-instance (make-metadata 'foo 'bar))
	 (test-instance (make-data 'baz metadata-instance))
	 (test-instance/f (make-data 'baz metadata-instance :file-path #p"foo/bar")))
    (ok (cl-metadata::data-id (cl-metadata::metadata-content test-instance)))
    (is (cl-metadata::data-name (cl-metadata::metadata-content test-instance)) 'foo)
    (is (cl-metadata::data-type (cl-metadata::metadata-content test-instance)) 'bar)
    (is (cl-metadata::data-content test-instance) 'baz)
    
    (ok (cl-metadata::data-id (cl-metadata::metadata-content test-instance/f)))
    (is (cl-metadata::data-name (cl-metadata::metadata-content test-instance/f)) 'foo)
    (is (cl-metadata::data-type (cl-metadata::metadata-content test-instance/f)) 'bar)
    (is (cl-metadata::data-content test-instance/f) 'baz)
    (is (cl-metadata::file-path test-instance/f) #p"foo/bar")))

(subtest "make-data-with-metadata test"
  (let ((test-instance (make-data-with-metadata 'foo 'bar 'baz))
	(test-instance/f (make-data-with-metadata 'foo 'bar 'baz :file-path #p"foo/bar")))
    (ok (cl-metadata::data-id (cl-metadata::metadata-content test-instance)))
    (is (cl-metadata::data-content test-instance) 'foo)
    (is (cl-metadata::data-name (cl-metadata::metadata-content test-instance)) 'bar)
    (is (cl-metadata::data-type (cl-metadata::metadata-content test-instance)) 'baz)

    (ok (cl-metadata::data-id (cl-metadata::metadata-content test-instance/f)))
    (is (cl-metadata::data-content test-instance/f) 'foo)
    (is (cl-metadata::data-name (cl-metadata::metadata-content test-instance/f)) 'bar)
    (is (cl-metadata::data-type (cl-metadata::metadata-content test-instance/f)) 'baz)
    (is (cl-metadata::file-path test-instance/f) #p"foo/bar")))

(subtest "show-metadatas test"
  (let ((test-instance (make-data-with-metadata 'foo 'bar 'baz))
	(test-instance/f (make-data-with-metadata 'foo 'bar 'baz :file-path #p"foo/bar")))
    (is-type (show-metadatas test-instance) 'string)
    (is-type (show-metadatas test-instance/f) 'string)))
	     
(finalize)
