

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Catalog Dashboard</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f4f8;
            color: #333;
        }

        .sidebar {
            width: 220px;
            background-color: #1e293b;
            color: white;
            height: 100vh;
            position: fixed;
            padding: 30px 20px;
        }

        .sidebar h2 {
            text-align: center;
            font-size: 18px;
            margin-bottom: 40px;
            letter-spacing: 1px;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
        }

        .sidebar ul li {
            padding: 12px 20px;
            cursor: pointer;
            border-radius: 6px;
            margin-bottom: 8px;
            transition: 0.3s;
        }

        .sidebar ul li:hover {
            background-color: #334155;
        }

        .main {
            margin-left: 240px;
            padding: 40px;
        }

        h1 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 30px;
        }

        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 20px;
            align-items: center;
        }

        input, select {
            padding: 10px;
            min-width: 160px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .btn {
            padding: 10px 16px;
            background-color: #3b82f6;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.3s;
        }

        .btn:hover {
            background-color: #2563eb;
        }

        #productTable, #promoTable {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        #productTable th, #productTable td,
        #promoTable th, #promoTable td {
            padding: 14px 16px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        #productTable th, #promoTable th {
            background-color: #f1f5f9;
        }

        #productTable tr:hover,
        #promoTable tr:hover {
            background-color: #f9fafb;
        }

        #createPromoBtn {
            margin-top: 30px;
            padding: 12px 20px;
            font-size: 16px;
            background-color: #10b981;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        #createPromoBtn:hover {
            background-color: #059669;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 999;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }

        .modal-content {
            background-color: white;
            margin: 80px auto;
            padding: 30px;
            border-radius: 12px;
            width: 400px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }

        .modal-content h2 {
            margin-top: 0;
            font-size: 22px;
            margin-bottom: 20px;
            color: #111827;
            text-align: center;
        }

        .modal-content label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
        }

        .modal-content input,
        .modal-content select {
            width: 100%;
            padding: 10px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        .modal-content button[type="submit"] {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #3b82f6;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: bold;
        }

        .modal-content button:hover {
            background-color: #2563eb;
        }

        .close {
            float: right;
            font-size: 24px;
            color: #aaa;
            cursor: pointer;
        }

        .close:hover {
            color: #333;
        }

        .inventory-counter {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .inventory-counter button {
            padding: 6px 12px;
            font-size: 14px;
            border: none;
            border-radius: 6px;
            background-color: #e5e7eb;
            cursor: pointer;
        }

        .inventory-counter button:hover {
            background-color: #cbd5e1;
        }


    </style>
</head>
<body>

<div class="sidebar">
    <h2>Catalog Management System</h2>
    <ul>
        <li>Dashboard</li>
        <li>Add Product</li>
        <li>Create Promo Code</li>
    </ul>
</div>

<div class="main">
    <h1>Catalog Dashboard</h1>

    <form id="productForm" onsubmit="return submitProduct();">
        <div class="form-row">
            <input type="text" id="productName" placeholder="Product Name" required>
            <input type="text" id="sku" placeholder="SKU" required>

            <select id="category" required>
                <option value="">Select Category</option>
                <option value="Mens">Mens</option>
                <option value="Womens">Womens</option>
                <option value="Child">Child</option>
            </select>

            <select id="size" required>
                <option value="">Select Size</option>
                <option value="S">S</option>
                <option value="M">M</option>
                <option value="L">L</option>
                <option value="XL">XL</option>
            </select>

            <input type="text" id="color" placeholder="Color" required>
            <input type="number" id="price" placeholder="Price" required step="0.01" min="0">


            <div class="inventory-counter">
                <button type="button" onclick="decrement()">-</button>
                <input type="number" id="inventory" value="1" min="0">
                <button type="button" onclick="increment()">+</button>
            </div>


            <button type="submit" form="productForm" class="btn">Add Product</button>
        </div>
    </form>

    <table id="productTable" border="1" style="margin-top: 30px; width: 100%; text-align: left;">
        <thead>
        <tr>
            <th>Category</th>
            <th>Product</th>
            <th>SKU</th>
            <th>Size</th>
            <th>Color</th>
            <th>Price</th>
            <th>Inventory Count</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody id="tableBody"></tbody>
    </table>
</div>

<!-- Create Promo Code Button -->
<div class="main">
<div style="text-align: center; margin-top: 20px;">
    <button id="createPromoBtn">Create Promo Code</button>
</div>

<!-- Promo Code Modal -->
<div id="promoModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <h2>Create Promo Code</h2>
        <form id="promoForm" onsubmit="return submitProduct2();">
            <label for="promoType">Promo Type:</label>
            <select id="promoType">
                <option value="product">By Product</option>
                <option value="order">By Order Type</option>
                <option value="category">By Category</option>
            </select>

            <label for="description">Description:</label>
            <input type="text" id="description" placeholder="Enter description">

            <label for="amount">Amount:</label>
            <input type="number" id="amount" placeholder="Enter amount">

            <button type="submit" form="promoForm">Submit</button>
        </form>


    </div>

</div>
<table id="promoTable" border="1" style="margin-top: 30px; text-align: left;">
    <thead>
    <tr>
        <th>Promo Type</th>
        <th>Description</th>
        <th>Promo Code</th>
        <th>Amount</th>
    </tr>
    </thead>
    <tbody id="promotablebody"></tbody>
</table>
</div>
<script>
    function increment() {
        const inv = document.getElementById("inventory");
        inv.value = parseInt(inv.value) + 1;
    }

    function decrement() {
        const inv = document.getElementById("inventory");
        if (parseInt(inv.value) > 0) {
            inv.value = parseInt(inv.value) - 1;
        }
    }

    function submitProduct() {
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "add-product", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        const data = "productName=" + encodeURIComponent(document.getElementById("productName").value) +
            "&sku=" + encodeURIComponent(document.getElementById("sku").value) +
            "&category=" + encodeURIComponent(document.getElementById("category").value) +
            "&size=" + encodeURIComponent(document.getElementById("size").value) +
            "&color=" + encodeURIComponent(document.getElementById("color").value) +
            "&price=" + encodeURIComponent(document.getElementById("price").value) +
            "&inventory=" + encodeURIComponent(document.getElementById("inventory").value);


        xhr.onload = function () {
            if (xhr.status === 200) {
                try {
                    const products = JSON.parse(xhr.responseText);
                    renderTable1(products);
                    clearForm();
                } catch (e) {
                    alert("Invalid response from server");
                }
            } else {
                alert("Error saving product!");
            }
        };

        xhr.send(data);
        return false; // prevent form from submitting normally
    }

    function renderTable1(products) {
        const tableBody = document.getElementById("tableBody");
        tableBody.innerHTML = "";
        products.forEach(p => {
            const row = `<tr>
                <td>${p.category}</td>
                <td>${p.productName}</td>
                <td>${p.sku}</td>
                <td>${p.size}</td>
                <td>${p.color}</td>
                <td>${p.price}</td>
                <td>${p.inventory}</td>
                <td><button onclick="alert('Edit coming soon')">Edit</button></td>
            </tr>`;
            tableBody.innerHTML += row;
        });
    }

    function clearForm() {
        document.getElementById("productName").value = "";
        document.getElementById("sku").value = "";
        document.getElementById("category").value = "";
        document.getElementById("size").value = "";
        document.getElementById("color").value = "";
        document.getElementById("price").value = "";
        document.getElementById("inventory").value = 1;
    }

    const promoModal = document.getElementById("promoModal");
    const createBtn = document.getElementById("createPromoBtn");
    const closeBtn = document.querySelector(".modal .close");

    // Show modal
    createBtn.onclick = function () {
        promoModal.style.display = "block";
    };

    // Close button functionality
    closeBtn.onclick = function () {
        promoModal.style.display = "none";
    };

    // Close modal when clicking outside the modal content
    window.onclick = function (event) {
        if (event.target === promoModal) {
            promoModal.style.display = "none";
        }
    };

    // Promo code submission
    function submitProduct2() {
        const chr = new XMLHttpRequest();
        chr.open("POST", "add-promo", true);
        chr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        const promoType = document.getElementById("promoType").value;
        const description = document.getElementById("description").value;
        const amount = document.getElementById("amount").value;

        if (!description || !amount) {
            alert("Please fill in all promo fields.");
            return false;
        }

        const randomNumber = Math.floor(Math.random() * 91) + 10; // 10 to 100
        const promoCode = "PROMO" + randomNumber;

        const promodata = "promoType=" + encodeURIComponent(promoType) +
            "&description=" + encodeURIComponent(description) +
            "&promoCode=" + encodeURIComponent(promoCode) +
            "&amount=" + encodeURIComponent(amount);

        chr.onload = function () {
            if (chr.status === 200) {
                try {
                    const promos = JSON.parse(chr.responseText);
                    renderTable2(promos);
                    promoclearForm();
                    promoModal.style.display = "none";
                } catch (e) {
                    alert("Invalid response from server");
                }
            } else {
                alert("Error saving promo!");
            }
        };

        chr.send(promodata);
        return false;
    }


    function renderTable2(promoproducts) {
        const promotablebody = document.getElementById("promotablebody");
        promotablebody.innerHTML = "";
        promoproducts.forEach(p => {
            const row = `<tr>
            <td>${p.promoType}</td>
            <td>${p.description}</td>
            <td>${p.promoCode}</td>
            <td>${p.amount}</td>
        </tr>`;
            promotablebody.innerHTML += row;
        });
    }
    function promoclearForm() {
        document.getElementById("promoType").value = "";
        document.getElementById("description").value = "";
        document.getElementById("amount").value = "";
    }


</script>

</body>
</html>