# guile-gpio
Module to use Raspberry Pi GPIO from GNU/Guile

### Build
```sh
gcc ./libgpio/gpio.c -fPIC -shared -o libgpio.so
```

### Install
Copy `libgpio.so` to your shared libraries path, and `gpio.scm` to you guile `(%site-dir)` path

### Run example
```sh
LTDL_LIBRARY_PATH=. guile3.0 ./examples/blink.scm
```

### Constants
- DIRECTION-INPUT
- DIRECTION-OUTPUT
- MODE-HIGH
- MODE-LOW
- PUD-OFF
- PUD-DOWN
- PUD-UP

### Functions
- **(gpio-init)**
```
Init GPIO
    Return: SETUP-OK or SETUP-DEVMEM-FAIL or SETUP-MALLOC-FAIL or
            SETUP-MMAP-FAIL or SETUP-CPUINFO-FAIL or SETUP-NOT-RPI-FAIL
```
- **(gpio-setup pin direction pud)**
```
Setup GPIO pin with direction and pud
    Arguments:
    - pin
    - direction: DIRECTION-INPUT or DIRECTION-OUTPUT
    - pud:       PUD-OFF or PUD-DOWN or PUD-UP
```

- **(gpio-get-function pin)**
```
Get GPIO pin function
    Arguments:
    - pin
    Return: INPUT or OUTPUT or ALT0
```

- **(gpio-set-mode pin mode)**
```
Set GPIO pin mode
    Arguments:
    - pin
    - mode: MODE-HIGH or MODE-LOW
```

- **(gpio-get-input pin)**
```
Get GPIO pin input
    Arguments:
    - pin
    Return: int
```

- **(gpio-set-rising-event pin enabled)**
```
Set GPIO pin rising event
    Arguments:
    - pin
    - enabled: #t or #f
```

- **(gpio-set-falling-event pin enabled)**
```
Set GPIO pin falling event
    Arguments:
    - pin
    - enabled: #t or #f 
```

- **(gpio-set-high-event pin enabled)**
```
Set GPIO pin high event
    Arguments:
    - pin
    - enabled: #t or #f
```

- **(gpio-set-low-event pin enabled)**
```
Set GPIO pin low event
    Arguments:
    - pin
    - enabled: #t or #f
```

- **(gpio-event-detected pin)**
```
Get GPIO pin event detected
    Arguments:
    - pin
    Return: int
```

- **(gpio-cleanup)**
```
Cleanup GPIO"
```

### Tested on
```
GNU Guile 3.0.5
```
