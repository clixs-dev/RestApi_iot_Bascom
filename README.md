# ESP8266 + ATmega2560 LED Controller

A simple web server using **ATmega2560** and **ESP8266 (AT Firmware)** for controlling 8 LEDs and reading sensor values (temperature & gas). The ESP runs in SoftAP mode and exposes simple HTTP endpoints that return JSON or switch the LEDs ON/OFF.

---

## ⚙️ Hardware Requirements

| Component                  | Qty |
| -------------------------- | --- |
| ATmega2560                 | 1   |
| ESP8266 (AT Firmware)      | 1   |
| 8MHz Crystal (or internal) | 1   |
| LEDs                       | 8   |
| Voltage level shifter      | 1   |
| Breadboard / Wires         | –   |

## 🔌 Connections

### ESP8266 to ATmega2560

| ATmega2560 Pin | ESP8266 Pin |
| -------------- | ----------- |
| TX0 (PD1)      | RX          |
| RX0 (PD0)      | TX          |

### LEDs

| LED | ATmega Pin |
| --- | ---------- |
| 1   | PB0        |
| 2   | PB1        |
| 3   | PB2        |
| 4   | PB3        |
| 5   | PB4        |
| 6   | PB5        |
| 7   | PD0        |
| 8   | PD1        |

## 🚀 How to Use

1. Open the BAS file in BASCOM and compile for ATmega2560 @8MHz
2. Flash the generated HEX file to the MCU
3. Flash AT firmware on the ESP8266 (if not already)
4. Power the circuit and wait a few seconds.

After start‐up, ESP8266 creates an access point:

```
SSID  : TakMoj-IoT
PASS  : 12345678
IP    : 192.168.4.1
```

Connect to the WiFi network and open the following URLs:

| URL                                                      | Description                        |
| -------------------------------------------------------- | ---------------------------------- |
| [http://192.168.4.1/leds](http://192.168.4.1/leds)       | Returns JSON status of all LEDs    |
| [http://192.168.4.1/sensors](http://192.168.4.1/sensors) | Returns temperature and gas values |
| [http://192.168.4.1/ON1](http://192.168.4.1/ON1)         | Turns LED #1 ON                    |
| [http://192.168.4.1/OFF1](http://192.168.4.1/OFF1)       | Turns LED #1 OFF                   |

*(change the last number for other LEDs)*

## ✅ Next steps (optional)

* Add HTML control page
* Replace fake sensor values with real hardware sensors
* Add basic authentication for requests

---

# کنترل LED با ESP8266 + ATmega2560

این پروژه یک **وب‌سرور ساده** با استفاده از ATmega2560 و ماژول ESP8266 (در حالت AT) راه‌اندازی می‌کند که:

* وضعیت ۸ عدد LED را به صورت JSON ارائه می‌دهد
* دما و مقدار گاز را (فعلاً به صورت شبیه‌سازی‌شده) نمایش می‌دهد
* با درخواست‌های HTTP (`/ON1` تا `/ON8`) LED ها را روشن یا خاموش می‌کند

## ⚙️ قطعات مورد نیاز

| قطعه                           | تعداد |
| ------------------------------ | ----- |
| ATmega2560                     | 1     |
| ماژول ESP8266 (AT Firmware)    | 1     |
| کریستال 8MHz (یا داخلی)        | 1     |
| LED                            | 8     |
| Level shifter یا تقسیم مقاومتی | 1     |
| سیم / برد                      | —     |

## 🔌 اتصال ماژول‌ها

### ارتباط ATmega2560 و ESP8266

| پایه ATmega | پایه ESP8266 |
| ----------- | ------------ |
| TX0 (PD1)   | RX           |
| RX0 (PD0)   | TX           |

### LED ها

| LED | پایه میکرو |
| --- | ---------- |
| 1   | PB0        |
| 2   | PB1        |
| 3   | PB2        |
| 4   | PB3        |
| 5   | PB4        |
| 6   | PB5        |
| 7   | PD0        |
| 8   | PD1        |

## 🛠️ نحوه استفاده

1. فایل BAS را در محیط BASCOM باز کرده و روی ATmega2560 @8MHz کامپایل کنید
2. فایل HEX تولید شده را روی میکرو پروگرام کنید
3. ESP8266 باید دارای فریمور AT باشد (فرمان AT → OK)
4. مدار را تغذیه کنید و چند ثانیه صبر کنید

سپس شبکه وای‌فای زیر ایجاد می‌شود:

```
SSID : TakMoj-IoT
PASS : 12345678
IP   : 192.168.4.1
```

به شبکه متصل شوید و یکی از URL‌های زیر را در مرورگر بزنید:

| URL                                                      | توضیح                     |
| -------------------------------------------------------- | ------------------------- |
| [http://192.168.4.1/leds](http://192.168.4.1/leds)       | نمایش وضعیت LED ها (JSON) |
| [http://192.168.4.1/sensors](http://192.168.4.1/sensors) | نمایش دما و گاز           |
| [http://192.168.4.1/ON1](http://192.168.4.1/ON1)         | روشن کردن LED شماره 1     |
| [http://192.168.4.1/OFF1](http://192.168.4.1/OFF1)       | خاموش کردن LED شماره 1    |

(برای سایر LEDها فقط شماره را تغییر دهید)

## ✅ پیشنهادات توسعه بعدی

* افزودن صفحه HTML برای کنترل ساده از مرورگر
* استفاده از سنسور واقعی دما / گاز
* اضافه کردن احراز هویت ساده برای امنیت بیشتر
