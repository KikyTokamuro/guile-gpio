(add-to-load-path
 (string-append (dirname (current-filename)) "/../"))

(use-modules (gpio))

;; Led pin
(define led-pin 26)

;; Init GPIO and check status
(let ((status (gpio-init)))
  (if (eq? status 'SETUP-OK)
      (display status)
      (error status)))

;; Setup pin
(gpio-setup led-pin DIRECTION-OUTPUT PUD-OFF)

;; Blinking
(do ((i 1 (1+ i)))
    ((> i 5))
  (gpio-set-mode led-pin MODE-HIGH)
  (sleep 1)
  (gpio-set-mode led-pin MODE-LOW)
  (sleep 1))

;; Clenup GPIO
(gpio-cleanup)
