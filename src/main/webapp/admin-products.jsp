```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="nextDir" value="${sortDir == 'asc' ? 'desc' : 'asc'}" />

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Products | Admin Panel - Matcha Coffee</title>

  <!-- Fonts -->
  <link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
    rel="stylesheet"
  />

  <style>
    :root {
      --matcha-light: #E8F3E1;
      --matcha-green: #9BCF8E;
      --matcha-dark: #3A5F41;
      --brown-accent: #6A4E23;
      --white: #ffffff;
      --danger: #c0392b;
      --warning: #d1a229;
    }

    body {
      margin: 0;
      font-family: 'Noto Sans JP', sans-serif;
      background: #f3f7f3;
      display: flex;
    }

    /* SIDEBAR */
    .sidebar {
      width: 240px;
      background: var(--matcha-dark);
      color: var(--white);
      height: 100vh;
      padding: 20px;
      position: fixed;
    }

    .sidebar h2 {
      margin: 0 0 20px 0;
      text-align: center;
    }

    .sidebar a {
      display: block;
      padding: 12px;
      text-decoration: none;
      color: var(--white);
      margin: 8px 0;
      border-radius: 6px;
      font-weight: 500;
    }

    .sidebar a:hover {
      background: var(--matcha-green);
      color: var(--matcha-dark);
    }

    /* MAIN CONTENT WRAPPER */
    .content {
      margin-left: 260px;
      padding: 30px;
      width: calc(100% - 260px);
      box-sizing: border-box;
    }

    .content h1 {
      color: var(--brown-accent);
      margin-bottom: 18px;
    }

    /* CARDS / SECTIONS */
    .card {
      background: var(--white);
      border-radius: 15px;
      padding: 18px 22px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
      margin-bottom: 18px;
    }

    .card h2 {
      margin: 0 0 12px 0;
      color: var(--brown-accent);
      font-size: 1.1rem;
    }

    /* TOOLBAR */
    .toolbar {
      display: flex;
      gap: 12px;
      flex-wrap: wrap;
      align-items: center;
      justify-content: space-between;
    }

    .toolbar-left {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
      align-items: center;
    }

    .toolbar-right {
      display: flex;
      gap: 10px;
      flex-wrap: wrap;
      align-items: center;
    }

    .input,
    select.input {
      padding: 10px 12px;
      border-radius: 10px;
      border: 1px solid #dfe7df;
      outline: none;
      min-width: 220px;
      background: #fff;
    }

    .input:focus {
      border-color: var(--matcha-green);
      box-shadow: 0 0 0 3px rgba(155, 207, 142, 0.25);
    }

    .btn {
      display: inline-block;
      padding: 10px 14px;
      border-radius: 10px;
      border: none;
      cursor: pointer;
      font-weight: 700;
      text-decoration: none;
      transition: transform 0.04s ease-in-out;
    }

    .btn:active {
      transform: scale(0.99);
    }

    .btn-primary {
      background: var(--matcha-dark);
      color: var(--white);
    }

    .btn-primary:hover {
      background: #2f5136;
    }

    .btn-secondary {
      background: var(--matcha-light);
      color: var(--matcha-dark);
      border: 1px solid #dfe7df;
    }

    .btn-secondary:hover {
      background: #dfeedd;
    }

    .btn-danger {
      background: var(--danger);
      color: var(--white);
    }

    .btn-danger:hover {
      background: #a93226;
    }

    .btn-warning {
      background: var(--warning);
      color: #1f1f1f;
    }

    .btn-warning:hover {
      filter: brightness(0.95);
    }

    /* TABLE */
    table {
      width: 100%;
      border-collapse: collapse;
      background: var(--white);
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 3px 8px rgba(0, 0, 0, 0.07);
    }

    th {
      background: var(--matcha-dark);
      color: white;
      padding: 12px;
      text-align: left;
      white-space: nowrap;
    }

    td {
      padding: 12px;
      border-bottom: 1px solid #eee;
      vertical-align: middle;
    }

    tr:hover {
      background: #f0f7ef;
    }

    .muted {
      color: #6b7280;
      font-size: 0.92rem;
    }

    /* BADGES */
    .badge {
      display: inline-block;
      padding: 6px 10px;
      border-radius: 999px;
      font-size: 0.82rem;
      font-weight: 800;
      color: white;
    }

    .badge.available {
      background: #4CAF50;
    }

    .badge.unavailable {
      background: #c0392b;
    }

    /* PRODUCT IMAGE PREVIEW */
    .thumb {
      width: 52px;
      height: 52px;
      border-radius: 12px;
      background: #f6f6f6;
      border: 1px solid #eee;
      object-fit: cover;
    }

    /* FORM GRID */
    .form-grid {
      display: grid;
      grid-template-columns: repeat(2, minmax(220px, 1fr));
      gap: 12px;
    }

    .form-grid .full {
      grid-column: 1 / -1;
    }

    label {
      display: block;
      font-size: 0.9rem;
      color: #374151;
      font-weight: 700;
      margin-bottom: 6px;
    }

    .field {
      display: flex;
      flex-direction: column;
    }

    textarea.input {
      min-height: 96px;
      resize: vertical;
    }

    .row-actions {
      display: flex;
      gap: 8px;
      flex-wrap: wrap;
    }

    /* MODAL (pure frontend) */
    .modal-backdrop {
      position: fixed;
      inset: 0;
      background: rgba(0, 0, 0, 0.35);
      display: none;
      align-items: center;
      justify-content: center;
      padding: 20px;
      z-index: 50;
    }

    .modal {
      width: min(680px, 100%);
      background: var(--white);
      border-radius: 16px;
      box-shadow: 0 12px 40px rgba(0, 0, 0, 0.25);
      overflow: hidden;
    }

    .modal-header {
      background: var(--matcha-dark);
      color: var(--white);
      padding: 14px 18px;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    .modal-header h3 {
      margin: 0;
      font-size: 1rem;
    }

    .modal-body {
      padding: 18px;
    }

    .modal-footer {
      padding: 14px 18px;
      display: flex;
      gap: 10px;
      justify-content: flex-end;
      border-top: 1px solid #eee;
    }

    /* show modal with :target trick */
    .modal-backdrop:target {
      display: flex;
    }

    /* RESPONSIVE */
    @media (max-width: 900px) {
      .form-grid {
        grid-template-columns: 1fr;
      }
    }

    @media (max-width: 768px) {
      .sidebar {
        position: relative;
        width: 100%;
        height: auto;
      }

      .content {
        margin-left: 0;
        width: 100%;
      }

      .input {
        min-width: 160px;
      }
    }


    .back-home {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      padding: 5px;
      text-decoration: none;
      font-weight: 500;
      background: rgba(255, 255, 255, 0.12);
      color: var(--white);
    }

    .back-home:hover {
      background: var(--matcha-green);
      color: var(--matcha-dark);
    }

    .back-home:active {
      transform: scale(0.98);
    }
    
    .icon-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 38px;
  height: 38px;
  border-radius: 10px;
  border: none;
  cursor: pointer;
  text-decoration: none;
  font-weight: 900;
}

.icon-danger {
  background: var(--danger);
  color: var(--white);
}

.icon-danger:hover {
  background: #a93226;
}

.icon-btn svg {
  width: 18px;
  height: 18px;
  fill: currentColor;
}
    
  </style>
</head>

<body>
  <!-- SIDEBAR -->
  <div class="sidebar">
    <h2>☘ Admin Panel</h2>
    <a href="dashboard">Dashboard</a>
    <a href="products">Products</a>
    <a href="orders">Orders</a>
    <a href="users">Users</a>
    <a href="logout">Logout</a>

    <div class="sidebar-footer">
      <a href="${pageContext.request.contextPath}/" class="back-home">
        ← Back to Homepage
      </a>
    </div>
  </div>

  <!-- MAIN CONTENT -->
  <div class="content">
    <h1>Products Management ☕</h1>

    <!-- TOOLBAR: Search + Add -->
    <div class="card">
      <div class="toolbar">
        <div class="toolbar-left">
          <form
            action="products"
            method="get"
            style="display:flex;gap:10px;flex-wrap:wrap;align-items:center;"
          >
            <input
              class="input"
              type="text"
              name="q"
              placeholder="Search by name / category..."
              value="${param.q}"
            />

            <select class="input" name="category">
              <option value="">All Categories</option>
              <option value="coffee" ${param.category == 'coffee' ? 'selected' : ''}>Coffee</option>
              <option value="tea" ${param.category == 'tea' ? 'selected' : ''}>Tea</option>
              <option value="milk_tea" ${param.category == 'milk tea' ? 'selected' : ''}>Milk Tea</option>
              <option value="bakery" ${param.category == 'bakery' ? 'selected' : ''}>Bakery</option>
              <option value="matcha" ${param.category == 'matcha' ? 'selected' : ''}>Matcha</option>
            </select>

            <select class="input" name="status">
              <option value="">All Status</option>
              <option value="available">Available</option>
              <option value="unavailable">Unavailable</option>
            </select>

            <button class="btn btn-primary" type="submit">Search</button>
            <a class="btn btn-secondary" href="products">Reset</a>
          </form>
        </div>

        <div class="toolbar-right">
          <a class="btn btn-primary" href="#addProductModal">+ Add Product</a>
        </div>
      </div>
    </div>

    <!-- PRODUCTS TABLE -->
    <div class="card" style="overflow:hidden;">
      <div style="padding:18px 22px;">
        <h2 style="margin-bottom:6px;">Product List</h2>
      </div>

      <table>
        <tr>
          <th style="width:70px;">Image</th>

          <th style="width: 90px;">
            <a
              href="products?page=${page}&q=${param.q}&category=${param.category}&status=${param.status}&sortBy=id&sortDir=${sortBy == 'id' ? nextDir : 'asc'}"
              style="color:white; text-decoration:none;"
            >
              ID
              <c:if test="${sortBy == 'id'}">
                ${sortDir == 'asc' ? '↑' : '↓'}
              </c:if>
            </a>
          </th>

          <th>Name</th>
          <th style="width:140px;">Category</th>
          <th style="width:120px;">Price</th>
          <th style="width:130px;">Status</th>
          <th style="width:220px;">Actions</th>
        </tr>

        <!-- Placeholder when list is empty -->
        <c:if test="${empty products}">
          <tr>
            <td colspan="7" style="text-align:center;padding:22px;">
              No products found. Click <b>+ Add Product</b> to create one.
            </td>
          </tr>
        </c:if>

        <!-- Real dynamic loop -->
        <c:forEach var="p" items="${products}">
          <tr>
            <td>
              <img
                class="thumb"
                src="${pageContext.request.contextPath}/uploads/menu/${p.imageUrl}"
                alt="${p.name}"
              />
            </td>
            <td>#${p.id}</td>
            <td>
              <b>${p.name}</b>
              <div class="muted">${p.description}</div>
            </td>
            <td>${p.category}</td>
            <td>$${p.price}</td>
            <td>
              <span class="badge ${p.status == 'available' ? 'available' : 'unavailable'}">
                ${p.status}
              </span>
            </td>
            <td>
              <div class="row-actions">
                <!-- FIXED: open the correct modal for each product -->
                <a class="btn btn-secondary" href="#editProductModal_${p.id}">Edit</a>

                <a
                  class="btn btn-warning"
                  href="products?op=toggle&id=${p.id}&page=${page}&q=${param.q}&category=${param.category}&status=${param.status}&sortBy=${sortBy}&sortDir=${sortDir}"
                >
                  ${p.status == 'available' ? 'Disable' : 'Enable'}
                </a>
                
                <!-- Remove (Trash Icon) -->
                <a class="btn btn-danger" href="products?op=remove&id=${p.id}&page=${page}&q=${param.q}&category=${param.category}&status=${param.status}&sortBy=${sortBy}&sortDir=${sortDir}" onclick="return confirm('Remove this product?');" title="Remove">
  🗑 </a>

              </div>
            </td>
          </tr>
        </c:forEach>
      </table>

      <div
        style="display:flex; justify-content:space-between; align-items:center; margin-top:14px;"
      >
        <div class="muted">
          Page <b>${page}</b> of <b>${totalPages}</b> — Total products:
          <b>${totalItems}</b>
        </div>

        <div style="display:flex; gap:8px;">
          <c:if test="${page > 1}">
            <a
              class="btn btn-secondary"
              href="products?page=${page-1}&q=${param.q}&category=${param.category}&status=${param.status}&sortBy=${sortBy}&sortDir=${sortDir}"
            >
              ← Prev
            </a>
          </c:if>
          <c:if test="${page < totalPages}">
          <a class="btn btn-secondary" href="products?page=${page+1}&q=${param.q}&category=${param.category}&status=${param.status}&sortBy=${sortBy}&sortDir=${sortDir}"> Next →</a>
          </c:if>

        </div>
      </div>
    </div>
  </div>

  <!-- ADD PRODUCT MODAL -->
  <div id="addProductModal" class="modal-backdrop">
    <div class="modal">
      <div class="modal-header">
        <h3>+ Add New Product</h3>
        <a href="#" style="color:white;text-decoration:none;font-weight:900;">✕</a>
      </div>

      <div class="modal-body">
        <form action="products" method="post" enctype="multipart/form-data">
          <input type="hidden" name="op" value="add" />

          <div class="form-grid">
            <div class="field">
              <label>Product Name</label>
              <input
                class="input"
                type="text"
                name="name"
                placeholder="e.g. Matcha Espresso Fusion"
              />
            </div>

            <div class="field">
              <label>Category</label>
              <select class="input" name="category">
                <option value="coffee">Coffee</option>
                <option value="tea">Tea</option>
                <option value="milk_tea">Milk Tea</option>
                <option value="bakery">Bakery</option>
                <option value="matcha">Matcha</option>
              </select>
            </div>

            <div class="field">
              <label>Price ($)</label>
              <input
                class="input"
                type="number"
                step="0.01"
                name="price"
                placeholder="e.g. 5.50"
              />
            </div>

            <div class="field">
              <label>Status</label>
              <select class="input" name="status">
                <option value="available">available</option>
                <option value="unavailable">unavailable</option>
              </select>
            </div>

            <div class="field full">
              <label>Description</label>
              <textarea
                class="input"
                name="description"
                placeholder="Short product description..."
              ></textarea>
            </div>

            <div class="field full">
              <label>Upload Image</label>
              <input class="input" type="file" name="image" accept="image/*" />
            </div>
          </div>

          <div class="modal-footer">
            <a class="btn btn-secondary" href="#">Cancel</a>
            <button class="btn btn-primary" type="submit">Save Product</button>
          </div>
        </form>
      </div>
    </div>
  </div>

  <!-- EDIT PRODUCT MODAL (generated per product) -->
  <c:forEach var="p" items="${products}">
    <div id="editProductModal_${p.id}" class="modal-backdrop">
      <div class="modal">
        <div class="modal-header">
          <h3>Edit Product #${p.id}</h3>
          <a href="#" style="color:white;text-decoration:none;font-weight:900;">✕</a>
        </div>

        <div class="modal-body">
          <form action="products" method="post">
            <input type="hidden" name="op" value="update" />
            <input type="hidden" name="id" value="${p.id}" />

            <div class="form-grid">
              <div class="field">
                <label>Product Name</label>
                <input class="input" type="text" name="name" value="${p.name}" required />
              </div>

              <div class="field">
                <label>Category</label>
                <select class="input" name="category" required>
                  <option value="coffee" ${p.category == 'coffee' ? 'selected' : ''}>Coffee</option>
                  <option value="tea" ${p.category == 'tea' ? 'selected' : ''}>Tea</option>
                  <option value="milk_tea" ${p.category == 'milk_tea' ? 'selected' : ''}>Milk Tea</option>
                  <option value="bakery" ${p.category == 'bakery' ? 'selected' : ''}>Bakery</option>
                  <option value="matcha" ${p.category == 'matcha' ? 'selected' : ''}>Matcha</option>
                </select>
              </div>

              <div class="field">
                <label>Price ($)</label>
                <input class="input" type="number" step="0.01" name="price" value="${p.price}" required />
              </div>

              <div class="field">
                <label>Status</label>
                <select class="input" name="status" required>
                  <option value="available" ${p.status == 'available' ? 'selected' : ''}>available</option>
                  <option value="unavailable" ${p.status == 'unavailable' ? 'selected' : ''}>unavailable</option>
                </select>
              </div>

              <div class="field full">
                <label>Description</label>
                <textarea class="input" name="description">${p.description}</textarea>
              </div>

              <div class="field full">
                <label>Current Image (unchanged)</label>
                <div style="display:flex;gap:12px;align-items:center;">
                  <img
                    class="thumb"
                    src="${pageContext.request.contextPath}/uploads/menu/${p.imageUrl}"
                    alt="${p.name}"
                  />
                  <span class="muted">${p.imageUrl}</span>
                </div>
              </div>
            </div>

            <div class="modal-footer">
              <a class="btn btn-secondary" href="#">Cancel</a>
              <button class="btn btn-primary" type="submit">Save Changes</button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </c:forEach>
</body>
</html>
