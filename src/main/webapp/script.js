

function submitProduct() {
    const data = new URLSearchParams();
    data.append("productName", document.getElementById("productName").value);
    data.append("sku", document.getElementById("sku").value);
    data.append("category", document.getElementById("category").value);
    data.append("size", document.getElementById("size").value);
    data.append("color", document.getElementById("color").value);
    data.append("price", document.getElementById("price").value);
    data.append("inventory", document.getElementById("inventory").value);

    fetch("add-product", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded",
        },
        body: data.toString()
    })
        .then(response => response.json())
        .then(products => {
            renderTable1(products);
            clearForm();
        })
        .catch(error => {
            alert("Error in saving product!");
            console.error(error);
        });

    return false;
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

createBtn.onclick = function () {
    promoModal.style.display = "block";
};

closeBtn.onclick = function () {
    promoModal.style.display = "none";
};

window.onclick = function (event) {
    if (event.target === promoModal) {
        promoModal.style.display = "none";
    }
};

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

    const randomNumber = Math.floor(Math.random() * 91) + 10;
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
