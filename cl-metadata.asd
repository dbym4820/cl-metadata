#|
  This file is a part of cl-metadata project.
  Copyright (c) 2017 Tomoki Aburatani (aburatanitomoki@gmail.com)
|#

#|
  CommonLisp Library for Attaching some Meta-Data for any kinds of files

  Author: Tomoki Aburatani (aburatanitomoki@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-metadata-asd
  (:use :cl :asdf))
(in-package :cl-metadata-asd)

(defsystem cl-metadata
  :version "0.1"
  :author "Tomoki Aburatani"
  :license "MIT"
  :depends-on (:cl-ppcre
               :dexador
	       :cl-annot
	       :local-time
               :uiop
               :alexandria
               :cl-csv
               :xmls
               :cxml)
  :components ((:module "src"
                :components
                ((:file "cl-metadata"))))
  :description "CommonLisp Library for Attaching some Meta-Data for any kinds of files"
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.md"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cl-metadata-test))))
