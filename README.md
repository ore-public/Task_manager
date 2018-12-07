# README


| User           ||
|:-------------- ||
| id             |integer|
| name           |string|
| email          |string|
| password       |string|                    
| password_digest|string|                    




|Task        ||
|:-----------||
|id          |integer|
|user_id(FK) |reference|
|title       |string|
|content     |text|
|status      |string|
|end_date    |integer|
|priority    |integer|


|Task_label_rekation ||
|:------------------ ||
|id                  |integer|
|task_id(FK)         |reference|
|label_id(FK)        |reference|


|Label      ||
|:----------||
| id        |integer|
| title     |string|
