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
		<label><strong>Enter the last 8-digit ticket Number</strong> </label><strong
			style="color: red;">*</strong>&nbsp; <input type="text"
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
	<div>
		<br />  <label><strong>Select type of empty tags : </strong> </label><strong
				style="color: red;">*</strong>
		        <select id="tagType">
  				<option value="<EmptyTag/>">&lt;EmptyTag/&gt;</option>
  				<option value="<EmptyTag></EmptyTag>">&lt;EmptyTag&gt;&lt;/EmptyTag&gt;</option>
				</select> <br /><br />
	</div>

</div>




<script>
	$(document)
			.ready(
					function() {
						$("#developmentTag").hide();
						$("#paratureTag").hide();
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
													alert("Please enter a valid ticket number. Ticket number does not contain alphabets");
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
												extension = fileName.substring(fileName.length - 4);
												/*if (extension != ".zip") {
													alert("Only zip file can be uploaded");
													return false;
												}*/
												if(validate(extension.toLowerCase()) == false)
												return false;
												
												if($("#tagType").val()==null || $("#tagType").val()=="") {
												alert("Please select empty tag");
												return false;
												}
											}

											var reportType = $("#reportType").val();
											var tagType = $("#tagType").val();
											var urlVal = "UploadServlet?reportName="
													+ reportType
													+ "&usageType=";

											var selectedValue = $(
													"#ticketNumber").val();
											/* if (selectedValue == null
													|| selectedValue == "") {
												selectedValue = $(
														"#selectProjectVal")
														.val();
											} */
											var usageType = $("input:checked")
													.val();

											$("form").attr(
													"action",
													urlVal + usageType
															+ "&selectedValue=" + selectedValue
															+ "&tagType=" + tagType
															+ "&ext=" + extension)
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
</script>