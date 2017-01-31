var Observable = require("FuseJS/Observable");
var Stripe = require("Stripe");

var info = Observable("");

var testPay = function() {
	console.log("Hear we goo");

	var cardParams = {
		"number": '4242424242424242',
		"exp_month": 12,
		"exp_year": 2018,
		"cvc": '123'
	};

    Stripe.createToken(cardParams).then(function(token) {
		var json_info = JSON.stringify(token);
		info.value = json_info;
        console.log("testPay worked!\n" + json_info);
    }).catch(function(e) {
        console.log("testPay failed:" + e);
    });
};

module.exports = {
    testPay: testPay,
	info: info
};
