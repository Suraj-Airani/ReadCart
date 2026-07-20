# ReadCart 📚

A full-stack e-commerce web application built with core Java web technologies, scoped to a book catalog for demonstration. The architecture is domain-agnostic — the same DAO/Service/Servlet structure could power any product category.

## Tech Stack

**Frontend**
- HTML5, CSS3, JavaScript
- JSP (Jakarta Server Pages)

**Backend**
- Java (Servlets, Jakarta EE)
- Apache Tomcat 10.1 
- JDBC 

**Database**
- MySQL

**Tools**
- Eclipse IDE (Dynamic Web Project)
- MySQL Connector/J

## Design Pattern: DAO (Data Access Object)

This project follows the DAO design pattern to separate data access logic from business logic and presentation logic.

```
Model (POJO) → DAO Interface → DAO Implementation (JDBC) → Service Layer → Servlet → JSP
```

- **Model** — plain POJO classes representing entities (`User`, `Product`, `Category`, `CartItem`, `Order`, `OrderItem`), holding fields and getters/setters only.
- **DAO Interface** — defines *what* data operations exist per entity (e.g. `ProductDAO`), with no implementation.
- **DAO Implementation** — implements the interface using JDBC and `PreparedStatement`s; all SQL lives here and nowhere else.
- **Service Layer** — sits between servlets and DAOs, adding business logic and validation (e.g. checking stock before checkout).
- **Servlet** — handles HTTP requests, calls the service layer, and forwards to the appropriate JSP. Never writes SQL directly.
- **JSP** — handles rendering only, using scriptlets/expression tags to display data passed via request/session attributes.

**Why DAO:** it decouples the database layer from the rest of the app — swapping databases, adding caching, or changing SQL doesn't touch servlets or JSPs at all.

## Package Structure

```
com.readcart.model        → POJO classes
com.readcart.dao          → DAO interfaces
com.readcart.dao.impl     → DAO implementations (JDBC)
com.readcart.service      → Business logic layer
com.readcart.servlet      → Request handling
com.readcart.util         → DBConnection utility
```

## Database Schema

| Table | Purpose |
|---|---|
| `users` | Registered user accounts |
| `categories` | Product categories (Fiction, Self-Help, Technology, etc.) |
| `products` | Book catalog with price, stock, and details |
| `cart_items` | Items in a user's cart |
| `orders` | Placed orders |
| `order_items` | Line items belonging to an order |

Key relationships:
- `products.category_id` → `categories.category_id`
- `cart_items.user_id` → `users.user_id`
- `cart_items.product_id` → `products.product_id`
- `orders.user_id` → `users.user_id`
- `order_items.order_id` → `orders.order_id`
- `order_items.product_id` → `products.product_id`

## Features

- User registration and login (session-based)
- Browse product catalog with category filtering and keyword search
- Product detail view
- Add to cart, update quantity, remove from cart
- Checkout with shipping address
- Order placement using a JDBC transaction (order + order items + stock deduction as a single atomic unit, with rollback on failure)
- Order history for logged-in users

## Application Workflow

1. **User registers/logs in** → `RegisterServlet` / `LoginServlet` validate via `UserService` → `UserDAO`, session created on success.
2. **User browses catalog** → `ProductListServlet` fetches products/categories via `ProductService` → `ProductDAO` / `CategoryDAO`, forwards to `catalog.jsp`.
3. **User views a product** → `ProductDetailServlet` fetches a single product, forwards to `productDetail.jsp`.
4. **User adds to cart** → `CartServlet` validates stock via `CartService`, inserts into `cart_items` via `CartDAO`.
5. **User checks out** → `CheckoutServlet` calls `OrderService.checkout()`, which:
   - Fetches cart items
   - Validates the cart isn't empty
   - Calculates the total
   - Places the order and order items in a single JDBC transaction (`OrderDAO.placeOrder`)
   - Deducts stock
   - Clears the cart on success, rolls back everything on failure
6. **User views order history** → `OrderHistoryServlet` fetches past orders via `OrderService` → `OrderDAO`.
