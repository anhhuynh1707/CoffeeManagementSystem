# ☕ Matcha Coffee – Web Ordering System (Java MVC)

## 1. Project Overview

**Matcha Coffee** is a Java web application that allows users to browse drinks, customize orders, place orders, and track delivery status.  
The system is built using **Java Servlet + JSP (MVC architecture)** with **MySQL** as the database.

A key feature of the system is **shipping fee calculation based on delivery district**, extracted from the user’s address and mapped via a configurable database table.

---

## 2. Technology Stack

- **Backend:** Java (Servlets, JDBC)  
- **Frontend:** JSP, JSTL, HTML, CSS, JavaScript  
- **Database:** MySQL 8.x  
- **Server:** Apache Tomcat 10+  
- **Architecture:** MVC (Model – View – Controller)

---

## 3. Project Structure

```

src/main/java
├── controller        # Servlets (routing & request handling)
├── dao               # Database access (JDBC)
├── model             # Entity & DTO classes
├── service           # Business logic
├── util              # Utilities (DB, address parsing, hashing)

src/main/webapp
├── *.jsp             # UI pages
├── css/              # Stylesheets
├── js/               # JavaScript
├── img/              # Images
└── WEB-INF/
└── web.xml

```

---

## 4. Key Features

### 👤 User
- Register, login, logout  
- Profile management  
- Browse menu and customize drinks  
- Add to cart & checkout  
- View order history  
- Track delivery status  

### 🛒 Order & Payment
- Cart → Order conversion  
- Payment methods:
  - Cash on Delivery (COD)
  - VietQR
  - Card  
- Order status lifecycle:
  - `pending` → `confirmed` → `completed`
  - `cancelled` (with refund handling)

### 🚚 Shipping (District-Based Fee)
- Shipping fee is calculated **based on delivery district**
- District is parsed from user address:
```

"111 Nguyen Kiem, Go Vap" → district = "Go Vap"

````
- Shipping fee is retrieved from database (`shipping_zone`)
- A **shipping snapshot** is saved per order

---

## 5. Database Design (Shipping Feature)

### `shipping_zone`
Defines shipping fee per district.

| Column        | Type      | Description     |
|---------------|-----------|-----------------|
| zone_id       | INT (PK)  | Auto increment  |
| city          | VARCHAR   | City name       |
| district      | VARCHAR   | District name   |
| shipping_fee  | INT       | Fee in VND      |

Example:
```sql
('Ho Chi Minh City', 'Go Vap', 50000)
````

---

### `shipping`

Stores shipping snapshot per order.

| Column       | Description                       |
| ------------ | --------------------------------- |
| order_id     | Linked to `orders.order_id` (1–1) |
| address      | Full delivery address             |
| city         | City name                         |
| district     | Extracted district                |
| shipping_fee | Calculated fee (VND)              |
| status       | pending / shipping / delivered    |

Each order has **exactly one shipping record**.

---

## 6. Shipping Fee Calculation Flow

1. User address is read from profile
2. District is extracted using `AddressUtil`
3. Fee is calculated via `ShippingService`
4. Fee is saved into:

   * `orders.shipping_fee`
   * `shipping.shipping_fee`
5. Fee is displayed on:

   * Checkout page
   * Order tracking page

### Fallback Rule

If district is missing or not found:

```java
Shipping fee = 50,000 VND
```

---

## 7. Important Business Rules

* Shipping fee is **always in VND** (no decimals)
* One shipping record per order
* Orders are created with:

  * `pending` status
  * Admin confirms later
* Shipping data is **snapshotted** (address changes later do not affect old orders)

---

## 8. Setup Instructions

### 1️⃣ Database

Create database:

```sql
CREATE DATABASE coffee_management;
USE coffee_management;
```

Run required SQL scripts:

* `users`
* `menu`
* `cart`
* `orders`
* `order_items`
* `shipping_zone`
* `shipping`

> Shipping scripts must be included for checkout to work correctly.

---

### 2️⃣ Server

* Use **Apache Tomcat 10+**
* Deploy as a Dynamic Web Project
* Ensure JDBC driver (`mysql-connector-j`) is in `/WEB-INF/lib`

---

### 3️⃣ Configuration

Edit database connection in:

```
util/DBConnection.java
```

Ensure:

* Database name: `coffee_management`
* Credentials are correct

---

## 9. Known Design Decisions

* Shipping is calculated **at checkout**, not after payment
* Shipping fee is stored redundantly:

  * `orders` (for totals)
  * `shipping` (for tracking)
* No external shipping API (district table is configurable)

---

## 10. Contributors

* **Huynh Tuan Anh** — ITIT23003
* **Tran Thi Truc Mai** — ITCSIU23024

