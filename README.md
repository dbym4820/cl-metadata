# Cl-Metadata - CommonLisp Library for Attaching some Meta-Data to any kinds of files

## Purpose
推論機構などを作成する際に各データに付与するメタデータの操作用ライブラリ

## Installation

ライブラリをローカルプロジェクトにクローン

```sh
? cd ~/.quicklisp/local-projects
? git clone https://github.com/TomokiAburatani/cl-metadata.git
```
QUicklispからロード

```cl
(ql:quicklisp :cl-metadata)
```


## Usage

メタデータの生成と付加を別々に行う

```cl
CL-USER> (in-package :cl-metadata)
METADATA> (defparameter *metadata1* (make-metadata :pdf :slide))
*metadata*
METADATA> (defparameter *data1* (make-data "11001110101010111101011" *metadata*))
METADATA> (show-metadatas *data1*)
"ID: 2017891733510177077203171
NAME: PDF
TYPE: SLIDE
"
```

メタデータの生成と付加を同時に行う

```
METADATA> (defparameter *data2* (make-data-with-metadata "11111111111111" :pdf :slide))
*data2*
METADATA> METADATA> (show-metadatas *data1*)
"ID: 2017891733510177077203171
NAME: PDF
TYPE: SLIDE
"
```

## Author

* Tomoki Aburatani (aburatanitomoki@gmail.com)

## Copyright

Copyright (c) 2017 Tomoki Aburatani (aburatanitomoki@gmail.com)

## License

Licensed under the MIT License.
