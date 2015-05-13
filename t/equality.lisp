(in-package :common-doc-test.ops)

(test node-equality
  (let* ((text (make-text "test"))
         (code-block (make-code-block "lisp"
                                      (list (make-text "test"))))
         (doc-link (make-document-link "doc" "sec"
                                       (list (make-text "test"))))
         (web-link (make-web-link "http://www.example.com"
                                  (list (make-text "test"))))
         (image (make-image "fig1.jpg"))
         (paragraph (make-paragraph
                     (list (make-text "test"))))
         (section (make-section
                   (list (make-text "Section 1"))
                   :children
                   (list
                    (make-figure
                     image
                     (list paragraph))))))
    (macrolet ((tests (&rest nodes)
                 `(progn
                    ,@(loop for node in nodes collecting
                            `(is (node-equal ,node ,node)))
                    ,@(loop for node in nodes collecting
                            `(progn
                               ,@(loop for other-node in (set-difference nodes (list node))
                                       collecting
                                       `(is (not (node-equal ,node ,other-node)))))))))
      (tests text code-block image paragraph section))))
