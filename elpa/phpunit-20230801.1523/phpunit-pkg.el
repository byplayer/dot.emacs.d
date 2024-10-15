;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "phpunit" "20230801.1523"
  "Launch PHP unit tests using phpunit."
  '((s        "1.12.0")
    (f        "0.19.0")
    (pkg-info "0.6")
    (cl-lib   "0.5")
    (emacs    "24.3"))
  :url "https://github.com/nlamirault/phpunit.el"
  :commit "e5baa445363942fbd9898ac3cb91eea64b69d316"
  :revdesc "e5baa4453639"
  :keywords '("tools" "php" "tests" "phpunit")
  :authors '(("Nicolas Lamirault" . "nicolas.lamirault@gmail.com")
             ("Eric Hansen" . "hansen.c.eric@gmail.com"))
  :maintainers '(("Nicolas Lamirault" . "nicolas.lamirault@gmail.com")
                 ("Eric Hansen" . "hansen.c.eric@gmail.com")))
