//Builds the HTML Table out of myList.
function buildHtmlTable(id,myList) {

	var columns = addAllColumnHeaders(myList,id);
	if (myList) {
		for (var i = 0; i < myList.length; i++) {
			var row$ = $('<tr/>');
			for (var colIndex = 0; colIndex < columns.length; colIndex++) {
				var cellValue = myList[i][columns[colIndex]];

				if (cellValue == null) {
					cellValue = "";
				}

				row$.append($('<td/>').html(cellValue));
			}
			$(id).append(row$);
		}
	}
}

//Adds a header row to the table and returns the set of columns.
//Need to do union of keys from all records as some records may not contain
//all records
function addAllColumnHeaders(myList,id) {
	var columnSet = [];
	var headerTr$ = $('<tr/>');

	for (var i = 0; i < myList.length; i++) {
		var rowHash = myList[i];
		for ( var key in rowHash) {
			if ($.inArray(key, columnSet) == -1) {
				columnSet.push(key);
				headerTr$.append($('<th/>').html(key));
			}
		}
	}
	$(id).append(headerTr$);
	return columnSet;
}
	var cookies;
	function readCookie(name) {
		if (cookies) {
			return cookies[name];
		}

		var c = document.cookie.split('; ');
		cookies = {};
		var C;
		for (var i = c.length - 1; i >= 0; i--) {
			C = c[i].split('=');
			cookies[C[0]] = C[1];
		}

		return cookies[name];
	}

	window.readCookie = readCookie; // or expose it however you want

	function showProducts() {
		var form = document.getElementById("formId");
		form.setAttribute("action", "/shoppingApplication/application/show");
		form.setAttribute("method", "get");
		form.submit();

	}


	function createInputBuyProducts() {
		if (readCookie("ACCESS-TOKEN")) {
			$('#userInput').html("");
			$('#userInput')
					.html(
							"<form id='buyProductTemplate' method='get' action='/shoppingApplication/application/buy'><input type='text' name='productCode'/> "
									+ "<input type='submit' id='buyProducts' value='Buy' /></form>");
		} else {
			authenticateUser();
		}
	}

	function  authenticateUser() {
		var form = document.getElementById("formId");
		form.setAttribute("action", "/shoppingApplication/application/authenticate");
		form.setAttribute("method", "get");
		form.submit();
		
	}