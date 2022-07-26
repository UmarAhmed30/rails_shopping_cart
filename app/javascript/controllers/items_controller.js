import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  initialize() {}

  connect() {}

  toggleQuantity(event) {
    event.preventDefault();
    event.stopPropagation();

    const addBtnID = event.params["add"];
    const minusBtnID = event.params["minus"];
    const quantityID = event.params["quantity"];
    const priceID = event.params["price"];
    const subtotalID = event.params["subtotal"];

    const addBtn = document.getElementById(addBtnID);
    const minusBtn = document.getElementById(minusBtnID);
    const quantity = document.getElementById(quantityID);
    const price = document.getElementById(priceID);
    const subtotal = document.getElementById(subtotalID);
    const total = document.getElementById("total");

    if (addBtn !== null) {
      this.addQuantity(quantity);
      total.innerText = (
        parseInt(total.innerText) + parseInt(price.innerText)
      ).toFixed(1);
    }

    if (minusBtn !== null && quantity.innerText > 1) {
      this.minusQuantity(quantity);
      total.innerText = (
        parseInt(total.innerText) - parseInt(price.innerText)
      ).toFixed(1);
    }

    subtotal.innerText = (
      parseInt(quantity.innerText) * parseInt(price.innerText)
    ).toFixed(1);
  }

  addQuantity(quantity) {
    quantity.innerText = parseInt(quantity.innerText) + 1;
  }

  minusQuantity(quantity) {
    quantity.innerText = parseInt(quantity.innerText) - 1;
  }

  updateQuantity(event) {
    const cartID = event.params["cart"];
    const itemID = event.params["item"];
    const quantityID = event.params["quantity"];

    const quantity = parseInt(document.getElementById(quantityID).innerText);

    var json_obj = {
      quantity: quantity,
    };

    var data = JSON.stringify(json_obj);

    $.ajax({
      url: "/carts/" + cartID + "/items/" + itemID,
      type: "PATCH",
      data: data,
      dataType: "json",
      contentType: "application/json",
      success: function () {
        location.reload();
      },
      error: function (err) {
        console.log(err.responseText);
      }
    });
  }
}
