<% 
String buyResult = (String)request.getAttribute("buyResult");
if(buyResult!=null){%>
<div class="result">
			<%= buyResult %>
</div>	
<%}
String showResult = (String)request.getAttribute("showProducts");
if(showResult!=null && !showResult.isEmpty()){
%>
<div class="result">
	<table class="resultsDisplay" id="showProducts">
	</table>
</div>

	
<script>
var myList= <%=showResult %>;

$( document ).ready(function() {
	 		buildHtmlTable();
	});



//Builds the HTML Table out of myList.
function buildHtmlTable() {

 var columns = addAllColumnHeaders(myList);

 for (var i = 0 ; i < myList.length ; i++) {
     var row$ = $('<tr/>');
     for (var colIndex = 0 ; colIndex < columns.length ; colIndex++) {
         var cellValue = myList[i][columns[colIndex]];

         if (cellValue == null) { cellValue = ""; }

         row$.append($('<td/>').html(cellValue));
     }
     $("#showProducts").append(row$);
 }
}

//Adds a header row to the table and returns the set of columns.
//Need to do union of keys from all records as some records may not contain
//all records
function addAllColumnHeaders(myList)
{
 var columnSet = [];
 var headerTr$ = $('<tr/>');

 for (var i = 0 ; i < myList.length ; i++) {
     var rowHash = myList[i];
     for (var key in rowHash) {
         if ($.inArray(key, columnSet) == -1){
             columnSet.push(key);
             headerTr$.append($('<th/>').html(key));
         }
     }
 }
 $("#showProducts").append(headerTr$);
 return columnSet;
}
</script>
<%}%>