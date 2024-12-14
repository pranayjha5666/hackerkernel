# hackerkernel

This is a mobile application built with Flutter that allows users to manage a product list. Users can log in, add, delete, and search for products. Product data is stored locally using `SharedPreferences`.

## Getting Started

**Login Page**

## Screens and Functionalities

### 1. **Login Page**
- **UI Features**:
  - Email input field
  - Password input field
  - Login button
- **Behavior**:
  - Validates user credentials using the provided API.
  - On successful login, navigate to the Home Page.
  - Displays error messages for invalid login credentials using Snackbar or Toast.
  - Prevents access to the home page without logging in.

---

### 2. **Home Page**
- **UI Features**:
  - Search Bar at the top
  - List of products (with delete icons)
  - Floating action button for adding products
- **Behavior**:
  - Allows product search using a search query.
  - Displays `No Product Found` if the product list is empty.
  - Deletes products from the list using the delete icon.

---

### 3. **Add Product Page**
- **UI Features**:
  - Input field for the product name.
  - Input field for the product price.
