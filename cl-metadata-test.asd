#|
  This file is a part of cl-metadata project.
  Copyright (c) 2017 Tomoki Aburatani (aburatanitomoki@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-metadata-test-asd
  (:use :cl :asdf))
(in-package :cl-metadata-test-asd)

(defsystem cl-metadata-test
  :author "Tomoki Aburatani"
  :license "MIT"
  :depends-on (:cl-metadata
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "cl-metadata"))))
  :description "Test system for cl-metadata"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
