/**
 * cordova is available under *either* the terms of the modified BSD license *or* the
 * MIT License (2008). See http://opensource.org/licenses/alphabetical for full text.
 *
 * Copyright (c) Matt Kane 2010
 * Copyright (c) 2011, IBM Corporation
 */


var exec = require("cordova/exec");

/**
 * Constructor.
 *
 * @returns {QRCodeScanner}
 */
function QRCodeScanner() {};

/**
 * Read code from scanner.
 *
 * @param {Function} successCallback This function will recieve a result object: {
 *        text : '12345-mock',    // The code that was scanned.
 *        cancelled : true/false, // Was canceled.
 *    }
 * @param {Function} errorCallback
 * @param {Object} config: { cancelButtonTitle: 'Cancel' }
 */
QRCodeScanner.prototype.scan = function(success, error, config) {
	var configDefault = { cancelButtonTitle: 'Cancel' };

	if(!!config && typeof config == 'object'){
		configDefault.cancelButtonTitle = config.cancelButtonTitle || configDefault.cancelButtonTitle;
	}

    exec(success, error, "QRCodeScanner", "scan", [configDefault.cancelButtonTitle]);
};

var qrcodeScanner = new QRCodeScanner();
module.exports = qrcodeScanner;