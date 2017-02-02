var Observable = require("FuseJS/Observable");
var Stripe = require("Stripe");

var cardNumber = Observable("4242424242424242");
var expiryMonth = Observable("12");
var expiryYear = Observable("18");
var cvc = Observable("123");

var info = Observable("");

var testPay = function() {
	console.log("createToken");

	var cardParams = {
		"number": cardNumber.value,
		"exp_month": expiryMonth.value,
		"exp_year": expiryYear.value,
		"cvc": cvc.value
	};

    Stripe.createToken(cardParams).then(function(token) {
		var json_info = JSON.stringify(token);
		info.value = json_info;
        console.log("testPay worked!\n" + json_info);
    }).catch(function(e) {
        console.log("testPay failed:" + e);
    });
};

var validateCardParams = function() {
	console.log("validateCardParams");

	var cardParams = {
		"number": cardNumber.value,
		"exp_month": expiryMonth.value,
		"exp_year": expiryYear.value,
		"cvc": cvc.value
	};

    Stripe.validateCard(cardParams).then(function(result) {
		var json_info = JSON.stringify(result);
		info.value = json_info;
        console.log("validateCardParams worked!\n" + json_info);
    }).catch(function(e) {
        console.log("validateCardParams failed:" + e);
    });
};

module.exports = {
	validateCardParams: validateCardParams,
    testPay: testPay,
	info: info,
	cardNumber: cardNumber,
	expiryMonth: expiryMonth,
	expiryYear: expiryYear,
	cvc: cvc
};
