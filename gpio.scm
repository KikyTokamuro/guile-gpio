(define-module (gpio)
  #:use-module (system foreign)
  #:use-module (ice-9 list)
  #:export (;; Constants
	    DIRECTION-INPUT
	    DIRECTION-OUTPUT
	    MODE-HIGH
	    MODE-LOW
	    PUD-OFF
	    PUD-DOWN
	    PUD-UP
	    ;; Functions
	    gpio-init
	    gpio-setup
	    gpio-get-function
	    gpio-set-mode
	    gpio-get-input
	    gpio-set-rising-event
	    gpio-set-falling-event
	    gpio-set-high-event
	    gpio-set-low-event
	    gpio-event-detected
	    gpio-cleanup))

(define libgpio (dynamic-link "libgpio"))

;; Directions
(define DIRECTION-INPUT  1) ;; is really 0 for control register!
(define DIRECTION-OUTPUT 0) ;; is really 1 for control register!

;; Modes
(define MODE-HIGH 1)
(define MODE-LOW  0)

;; Puds
(define PUD-OFF  0)
(define PUD-DOWN 1)
(define PUD-UP   2)

(define pin-function
  '((INPUT  . 0)
    (OUTPUT . 1)
    (ALT0   . 4)))

(define init-gpio-result
  '((SETUP-OK           . 0)
    (SETUP-DEVMEM-FAIL  . 1)
    (SETUP-MALLOC-FAIL  . 2)
    (SETUP-MMAP-FAIL    . 3)
    (SETUP-CPUINFO-FAIL . 4)
    (SETUP-NOT-RPI-FAIL . 5)))

(define (init-gpio-result-to-symbol num)
  (car (rassq num init-gpio-result)))

(define (pin-function-to-symbol num)
  (car (rassq num pin-function)))

(define (boolean->number b)
  (if b 1 0))

(define (gpio-init)
  "Init GPIO
    Return: SETUP-OK or SETUP-DEVMEM-FAIL or SETUP-MALLOC-FAIL or
            SETUP-MMAP-FAIL or SETUP-CPUINFO-FAIL or SETUP-NOT-RPI-FAIL
  "
  (let ((fn (pointer->procedure int (dynamic-func "setup" libgpio) '())))
    (init-gpio-result-to-symbol (fn))))

(define (gpio-setup pin direction pud)
  "Setup GPIO pin with direction and pud
    Arguments:
    - pin
    - direction: DIRECTION-INPUT or DIRECTION-OUTPUT
    - pud:       PUD-OFF or PUD-DOWN or PUD-UP
  "
  (let ((fn (pointer->procedure void (dynamic-func "setup_gpio" libgpio) (list int int int))))
    (fn pin direction pud)))

(define (gpio-get-function pin)
  "Get GPIO pin function
    Arguments:
    - pin
    Return: INPUT or OUTPUT or ALT0
  "
  (let ((fn (pointer->procedure int (dynamic-func "gpio_function" libgpio) (list int))))
    (pin-function-to-symbol (fn pin))))

(define (gpio-set-mode pin mode)
  "Set GPIO pin mode
    Arguments:
    - pin
    - mode: MODE-HIGH or MODE-LOW
  "
  (let ((fn (pointer->procedure void (dynamic-func "output_gpio" libgpio) (list int int))))
    (fn pin mode)))

(define (gpio-get-input pin)
  "Get GPIO pin input
    Arguments:
    - pin
    Return: int
  "
  (let ((fn (pointer->procedure int (dynamic-func "input_gpio" libgpio) (list int))))
    (fn pin)))

(define (gpio-set-rising-event pin enabled)
  "Set GPIO pin rising event
    Arguments:
    - pin
    - enabled: #t or #f
  "
  (let ((fn (pointer->procedure void (dynamic-func "set_rising_event" libgpio) (list int int))))
    (fn pin (boolean->number enabled))))

(define (gpio-set-falling-event pin enabled)
  "Set GPIO pin falling event
    Arguments:
    - pin
    - enabled: #t or #f 
  "
  (let ((fn (pointer->procedure void (dynamic-func "set_falling_event" libgpio) (list int int))))
    (fn pin (boolean->number enabled))))

(define (gpio-set-high-event pin enabled)
  "Set GPIO pin high event
    Arguments:
    - pin
    - enabled: #t or #f
  "
  (let ((fn (pointer->procedure void (dynamic-func "set_high_event" libgpio) (list int int))))
    (fn pin (boolean->number enabled))))

(define (gpio-set-low-event pin enabled)
  "Set GPIO pin low event
    Arguments:
    - pin
    - enabled: #t or #f
  "
  (let ((fn (pointer->procedure void (dynamic-func "set_low_event" libgpio) (list int int))))
    (fn pin (boolean->number enabled))))

(define (gpio-event-detected pin)
  "Get GPIO pin event detected
    Arguments:
    - pin
    Return: int
  "
  (let ((fn (pointer->procedure int (dynamic-func "eventdetected" libgpio) (list int))))
    (fn pin)))

(define (gpio-cleanup)
  "Cleanup GPIO"
  (let ((fn (pointer->procedure void (dynamic-func "cleanup" libgpio) '())))
    (fn)))

