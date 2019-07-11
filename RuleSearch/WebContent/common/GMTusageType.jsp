<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>


	<div>
		<label for="UsageType"><strong>Select the usage type</strong></label><strong
			style="color: red;">*</strong> <input type="radio" name="usageType"
			value="parature"> <label for="parature">Map Change</label> <input
			type="radio" name="usageType" value="development"> <label
			for="development">Development</label> <br /> <br />
	</div>
	<div id="paratureTag">
		<label><strong>Enter the last 8-digit ticket Number</strong>
		</label><strong style="color: red;">*</strong>&nbsp; <input type="text"
			name="ticketNumber" id="ticketNumber" required="required"
			placeholder="Ticket number" maxlength="8"> <br /> <br />
	</div>
	<div id="developmentTag">
		<label><strong>Select the Project Name</strong></label>
		<!--  <select
			name="select" id="selectProjectVal">
			<option value="Toshiba">Toshiba</option>
			<option value="CEVA V2">CEVA V2</option>
			<option value="CEVA V5.2">CEVA V5.2</option>
			<option value="Merk Millipore">Merk Millipore</option>
			<option value="Justin Brands">Justin Brands</option>
			<option value="CVG">CVG</option>
			<option value="PDC">PDC</option>
			<option value="Petco">Petco</option>
			<option value="BBU Phase 1">BBU Phase 1</option>
			<option value="Saint Gobain">Saint Gobain</option>
			<option value="Kronoply">Kronoply</option>
			<option value="Allied Mills">Allied Mills</option>
		</select> -->
		<select name="select" id="selectProjectVal">
			<c:forEach var="projectName" items="${projectNames}">
				<option value="${projectName}">${projectName}</option>
			</c:forEach>
		</select>
	</div>
	<br /> <br />
	
	<label><strong>Select character encoding : </strong> </label><strong
				style="color: red;">*</strong>
		        <select id="encoding">
  				<option value="cp1252">Cp1252 (Cp1252)</option>
  				<option value="utf-8">UTF8 (UTF8)</option>
				</select> <br /><br />
	<label><strong>Do you want to add presession rule ?</strong> </label><strong
	style="color: red;">*</strong>			

<label for="chkYes">
    <input type="radio" id="chkYes" name="chkPresession" onclick="ShowHideDiv_Presession()" />
    Yes
</label>
<label for="chkNo">
    <input type="radio" id="chkNo" name="chkPresession" onclick="ShowHideDiv_Presession()" />
    No
</label><br/>
<!-- <hr /> -->
<div id="dvPresession" style="display: none">
   <br/> <label><strong>Please enter your name :</strong> </label><strong
				style="color: red;">*</strong>&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="text" id="PresessionName" onkeypress="return onlyAlphabets(event,this);" />
</div><br />

 <label><strong>Is positional output layout ?</strong> </label><strong
	style="color: red;">*</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

<label for="chk_Yes">
    <input type="radio" id="chk_Yes" name="chkPositional" onclick="ShowHideDiv_Positional()" />
    Yes
</label>
<label for="chk_No">
    <input type="radio" id="chk_No" name="chkPositional" onclick="ShowHideDiv_Positional()" />
    No
</label><br/>
<!-- <hr /> -->
<div id="dvPositional" style="display: none">
   <br/> <label><strong>Delimiter 1 :</strong> </label><!-- <strong
				style="color: red;">*</strong> -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="text" id="delimiter_1" onkeypress="return onlyAlphabets(event,this);" />
    <br/> <label><strong>Delimiter 2 :</strong> </label><!-- <strong
				style="color: red;">*</strong> -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="text" id="delimiter_2" onkeypress="return onlyAlphabets(event,this);" />
</div><br />
	
</div>




<script>
  
	$(document)
			.ready(
					function() {
						$("#developmentTag").hide();
						$("#paratureTag").hide();

						/* 	if ($("input[type='file']").val() == null
									|| $("input[type='file']").val() == "") {
								alert("Hello");
								 $("input[type='file']").css("color", "transparent");
							} */

						$("form")
								.submit(
										function() {
								
											var extension;
											if ($("input:checked").val() == null) {
												
												alert("Please select the usage type");
												return false;
											}
											if ($("input:checked").val() == "parature") {
												if ($("#ticketNumber").val() == null
														|| $("#ticketNumber")
																.val() == "") {
													alert("Please enter the ticket number");
													return false;
												}

												var ticketNumber = $(
														"#ticketNumber").val();
												var intRegex = /^[0-9]+$/;
												
												if (!(ticketNumber
														.match(intRegex))) {
													alert("Please enter a valid ticket number. Ticket number does not contain alphabets and special characters.");
													return false;
												}
												if (!(ticketNumber.length == 8)) {
													alert("Please enter a valid ticket number. Ticket value contains 8 numeric characters.");
													return false;
												}

											}
											if ($("#file").val() == null
													|| $("#file").val() == "") {
												alert("Please select the file");

												return false;
											} else {
												
												var fileName = $("#file").val();
												//alert("before ext validation");
												extension = fileName
														.substring(fileName.length - 4);
												
												
												/*if (extension != ".zip") {
													alert("Only zip file can be uploaded");
													return false;
												}*/
											  // alert(validate(extension));
												//alert("extension: "+validate(extension));
												
												if(validate(extension.toLowerCase()) == false)
												 return false;
                                             
												//alert("after ext validation");
											}
											
											if($("#encoding").val()==null || $("#encoding").val()=="") {
												alert("Please select character encoding");
												return false;
											}
											
											if(!document.getElementById("chkYes").checked && !document.getElementById("chkNo").checked) {
												alert("Please select presession rule updation needed or not");
												return false;
											}
											
											if(!document.getElementById("chk_Yes").checked && !document.getElementById("chk_No").checked) {
												alert("Please select positional output layout present or not");
												return false;
											}
											
											if(document.getElementById("chkYes").checked) {
											if($("#PresessionName").val()==null || $("#PresessionName").val()=="") {
												alert("Please provide name to update presession rule");
												return false;
											 }
										    }
											
											/* if(document.getElementById("chk_Yes").checked) {
											if($("#delimiter_1").val()==null || $("#delimiter_1").val()=="" || $("#delimiter_2").val()==null || $("#delimiter_2").val()=="") {
												alert("Please provide delimiter details for positional layout");
												return false;
											 }
											} */

											var reportType = $("#reportType").val();
											var encoding = $("#encoding").val();
											var PresessionName = $("#PresessionName").val();
											var delimiter_1 = $("#delimiter_1").val();
											var delimiter_2 = $("#delimiter_2").val();
											var urlVal = "UploadServlet?reportName="
													+ reportType
													+ "&usageType=";

											var selectedValue = $(
													"#ticketNumber").val();
											if (selectedValue == null
													|| selectedValue == "") {
												selectedValue = $(
														"#selectProjectVal")
														.val();
											}
											var usageType = $("input:checked")
													.val();
											$("form").attr(
													"action",
													urlVal + usageType
															+ "&selectedValue="+ selectedValue
															+ "&encoding=" + encoding
															+ "&PresessionName=" + PresessionName
															+ "&delimiter_1=" + delimiter_1
															+ "&delimiter_2=" + delimiter_2
															+ "&ext="+ extension);
										});
						$("input").on("click", function() {
							if ($("input:checked").val() == "development") {
								$("#paratureTag").hide();
								$("#developmentTag").show();

							}

							if ($("input:checked").val() == "parature") {
								$("#developmentTag").hide();
								$("#paratureTag").show();
							}
						})
					}).change();
	
        function ShowHideDiv_Presession() {
        var chkYes = document.getElementById("chkYes");
        var dvPresession = document.getElementById("dvPresession");
        dvPresession.style.display = chkYes.checked ? "block" : "none";
        }
        
        function ShowHideDiv_Positional() {
        var chkYes = document.getElementById("chk_Yes");
        var dvPositional = document.getElementById("dvPositional");
        dvPositional.style.display = chkYes.checked ? "block" : "none";
        }
        
        function onlyAlphabets(e, t) {
            try {
                if (window.event) {
                    var charCode = window.event.keyCode;
                }
                else if (e) {
                    var charCode = e.which;
                }
                else { return true; }
                if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123))
                    return true;
                else
                    return false;
            }
            catch (err) {
                alert(err.Description);
            }
        }
</script>