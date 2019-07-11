<!-- Author: Pulkit V Jain, Kritika Agarwal -->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>FileTransmissionUtility</title>
</head>
<body>
	<form id="form1" method="post">
		<div id="File_Type">
			<h3 style="color: black; margin-left: 10px;">Select the type of
				file you want to transmit:</h3>
			<br /> <input type="radio" value="X12" name="fileType"
				onclick="addX12();hide('upload');show('X12_File')" style="margin-left: 20px;"> X12 <br /> <br />
			<div id="X12_File" style="margin-left: 30px;"></div>
			<br /> <br /> <input type="radio" value="RECADV_EDIFACT"
				name="fileType" onclick="addRecadv();hide('upload');show('Recadv_File')" style="margin-left: 20px;">
			RECADV EDIFACT <br /> <br />
			<div id="Recadv_File" style="margin-left: 30px;"></div>
			<br /> <br /> <input type="radio" value="DESADV_EDIFACT"
				name="fileType" onclick="addDesadv();hide('upload');show('Desadv_File')" style="margin-left: 20px;">
			DESADV EDIFACT <br /> <br />
			<div id="Desadv_File" style="margin-left: 30px;"></div>
			<br /> <br /> <input type="radio" value="VDA" name="fileType"
				onclick="addVDA();hide('upload');show('VDA_File')" style="margin-left: 20px;"> VDA <br /> <br />
			<div id="VDA_File" style="margin-left: 30px;"></div>
			<br /> <br /> <input type="radio" value="NON-EDI" name="fileType"
				onclick="warningBEDI();hide('upload');show('nonEDI_File')" style="margin-left: 20px;"> NON-EDI
			<h4 style="color: black; margin-left: 25px;">(Please ensure a
				BEDI is created for <u>SFSH5U6L</u>)</h4>
			<div id="nonEDI_File" style="margin-left: 30px;"></div>
			<br /> <br /> <input type="radio" value="Select_Own_File"
				name="fileType" onclick="show('upload');hide('X12_File');hide('Recadv_File');hide('Desadv_File');hide('VDA_File');hide('nonEDI_File')" style="margin-left: 20px;">
			Select Own File <br /> <br />
			<!-- <br /> <br /> <input type="radio" value="Select Own File"
				name="fileType" onclick="ownFile()" style="margin-left: 20px;">
			Select Own File <br /> <br />
			<div id="selectOwnFile" style="margin-left: 30px;"></div> -->
		</div>
	</form>
	
	<div id = "upload" style="display: none;">
	<form id="form2" method="post" enctype="multipart/form-data">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>Select file to upload</strong>&nbsp;<strong
		 style="color: red;">*</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="file"
		 name="file" size="0" id="file" /> <br /> <br /> <br /> 
		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="Upload">
	</form>
    </div>
    
	<script type="text/javascript">
	
	function show(target) {
	    document.getElementById(target).style.display = 'block';
	}

	function hide(target) {
	    document.getElementById(target).style.display = 'none';
	}
	$(document)
	.ready(
			function() {
				$("form")
						.submit(
								function() {
									    var extension,urlVal;
										var fileType = $("#fileType").val();
									    var selected = $("input[type='radio'][name='fileType']:checked").val();
										var fileName = $("#file").val();
										
										if(selected=="X12") {
											if ($("#senderQualifier_X12").val() == null || $("#senderQualifier_X12").val() == "" || $("#senderID_X12").val() == null || $("#senderID_X12").val() == ""
										     || $("#receiverQualifier_X12").val() == null || $("#receiverQualifier_X12").val() == "" || $("#receiverID_X12").val() == null || $("#receiverID_X12").val() == "") {
											alert('Please fill all details for '+selected);	
											return false;
											}
										}
										else if(selected=="RECADV_EDIFACT") {
											if ($("#senderQualifier_Recadv").val() == null || $("#senderQualifier_Recadv").val() == "" || $("#senderID_Recadv").val() == null || $("#senderID_Recadv").val() == ""
										     || $("#receiverQualifier_Recadv").val() == null || $("#receiverQualifier_Recadv").val() == "" || $("#receiverID_Recadv").val() == null || $("#receiverID_Recadv").val() == "") {
											alert('Please fill all details for '+selected);	
											return false;
										    }
										}
										else if(selected=="DESADV_EDIFACT") {
											if ($("#senderQualifier_Desadv").val() == null || $("#senderQualifier_Desadv").val() == "" || $("#senderID_Desadv").val() == null || $("#senderID_Desadv").val() == ""
										     || $("#receiverQualifier_Desadv").val() == null || $("#receiverQualifier_Desadv").val() == "" || $("#receiverID_Desadv").val() == null || $("#receiverID_Desadv").val() == "") {
											alert('Please fill all details for '+selected);	
											return false;
										    }
										}
										else if(selected=="VDA") {
											if ($("#senderID_VDA").val() == null || $("#senderID_VDA").val() == "" || $("#receiverID_VDA").val() == null || $("#receiverID_VDA").val() == "") {
											alert('Please fill all details for '+selected);	
											return false;
											}
										}
										else if(selected=="Select_Own_File") {
											if ($("#file").val() == null || $("#file").val() == "") {
												alert("Please select the file");
												return false;
											}											
										}
										
										if ($("#file").val() != null && $("#file").val() != "")
										extension = fileName.substring(fileName.length - 4);
										else
									    extension = "";
										
										if(extension == ".zip" || extension == ".ZIP") {
										   alert("Invalid file type, please browse different file.");
										   return false;
										}

									var reportType = $("#reportType").val();
									//if(extension!=null)
									urlVal = "UploadServlet?reportName=" + reportType + "&selected=" + selected + "&ext=" + extension;
									
									$("form").attr(
											"action",
											urlVal)
								});
			}).change();
	
	var x12_one = 1;
	var recadv_one = 1;
	var desadv_one = 1;
	var vda_one = 1;
	//var ownFile_one = 1;
	var nonEDI_one = 1;

	var parentRecadv = document.getElementById("Recadv_File");
	var parentX12 = document.getElementById("X12_File");
	var parentDesadv = document.getElementById("Desadv_File");
	var parentVDA = document.getElementById("VDA_File");
	var parentNonEDI = document.getElementById("nonEDI_File");
	//var parentOwnFile = document.getElementById("selectOwnFile");
	
	function uploadFile() {
		
	}

	function addX12() {
		if (document.getElementById("senderQualifier_Recadv")) {
			parentRecadv.removeChild(document
					.getElementById("senderQualifier_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("senderID_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("receiverQualifier_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("receiverID_Recadv"));
			parentRecadv.removeChild(document.getElementById("Send_Rec"));
			recadv_one = 1;

		}

		if (document.getElementById("senderQualifier_Desadv")) {
			parentDesadv.removeChild(document
					.getElementById("senderQualifier_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("senderID_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("receiverQualifier_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("receiverID_Desadv"));
			parentDesadv.removeChild(document.getElementById("Send_Des"));
			desadv_one = 1;
		}

		if (document.getElementById("senderID_VDA")) {
			parentVDA.removeChild(document.getElementById("senderID_VDA"));
			parentVDA
					.removeChild(document.getElementById("receiverID_VDA"));
			parentVDA.removeChild(document.getElementById("Send_VDA"));
			vda_one = 1;
		}

		if (document.getElementById("Send_NONEDI")) {
			parentNonEDI
					.removeChild(document.getElementById("Send_NONEDI"));
			nonEDI_one = 1;
		}

		/* if (document.getElementById("selectYourOwnFile")) {
			parentOwnFile.removeChild(document
					.getElementById("selectYourOwnFile"));
			parentOwnFile.removeChild(document
					.getElementById("Send_ownFile"));
			ownFile_one = 1;
		} */

		if (x12_one == 1) {

			var element_senderQualifier = document.createElement("input");
			var element_senderID = document.createElement("input");

			var element_receiverQualifier = document.createElement("input");
			var element_receiverID = document.createElement("input");

			element_senderQualifier.setAttribute("type", "text");
			element_senderQualifier.setAttribute("placeholder",
					"Sender Qualifier");
			element_senderQualifier.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_senderQualifier.setAttribute("name",
					"senderQualifier_X12_name");
			element_senderQualifier.setAttribute("maxlength", "4");
			element_senderQualifier.setAttribute("id",
					"senderQualifier_X12");

			parentX12.appendChild(element_senderQualifier);

			element_senderID.setAttribute("type", "text");
			element_senderID.setAttribute("placeholder", "Sender ID");
			element_senderID.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_senderID.setAttribute("name", "senderID_X12_name");
			element_senderID.setAttribute("maxlength", "15");
			element_senderID.setAttribute("id", "senderID_X12");

			parentX12.appendChild(element_senderID);

			element_receiverQualifier.setAttribute("type", "text");
			element_receiverQualifier.setAttribute("placeholder",
					"Receiver Qualifier");
			element_receiverQualifier.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_receiverQualifier.setAttribute("name",
					"receiverQualifier_X12_name");
			element_receiverQualifier.setAttribute("maxlength", "4");
			element_receiverQualifier.setAttribute("id",
					"receiverQualifier_X12");

			parentX12.appendChild(element_receiverQualifier);

			element_receiverID.setAttribute("type", "text");
			element_receiverID.setAttribute("placeholder", "Receiver ID");
			element_receiverID.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_receiverID.setAttribute("name", "receiverID_X12_name");
			element_receiverID.setAttribute("maxlength", "15");
			element_receiverID.setAttribute("id", "receiverID_X12");

			parentX12.appendChild(element_receiverID);

			var element_submit = document.createElement("input");
			element_submit.setAttribute("type", "submit");
			element_submit.setAttribute("value", "Send X12");
			element_submit.setAttribute("id", "Send_X12");

			parentX12.appendChild(element_submit); 

		}
		x12_one = 0;
	}

	function addRecadv() {

		if (document.getElementById("senderQualifier_X12")) {
			parentX12.removeChild(document
					.getElementById("senderQualifier_X12"));
			parentX12.removeChild(document.getElementById("senderID_X12"));
			parentX12.removeChild(document
					.getElementById("receiverQualifier_X12"));
			parentX12
					.removeChild(document.getElementById("receiverID_X12"));
			parentX12.removeChild(document.getElementById("Send_X12"));

			x12_one = 1;
		}

		if (document.getElementById("senderQualifier_Desadv")) {
			parentDesadv.removeChild(document
					.getElementById("senderQualifier_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("senderID_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("receiverQualifier_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("receiverID_Desadv"));
			parentDesadv.removeChild(document.getElementById("Send_Des"));
			desadv_one = 1;
		}

		if (document.getElementById("senderID_VDA")) {
			parentVDA.removeChild(document.getElementById("senderID_VDA"));
			parentVDA
					.removeChild(document.getElementById("receiverID_VDA"));
			parentVDA.removeChild(document.getElementById("Send_VDA"));
			vda_one = 1;
		}

		if (document.getElementById("Send_NONEDI")) {
			parentNonEDI
					.removeChild(document.getElementById("Send_NONEDI"));
			nonEDI_one = 1;
		}

		/* if (document.getElementById("selectYourOwnFile")) {
			parentOwnFile.removeChild(document
					.getElementById("selectYourOwnFile"));
			parentOwnFile.removeChild(document
					.getElementById("Send_ownFile"));
			ownFile_one = 1;
		} */

		if (recadv_one == 1) {

			var br = document.createElement("br");
			var element_senderQualifier = document.createElement("input");
			var element_senderID = document.createElement("input");

			var element_receiverQualifier = document.createElement("input");
			var element_receiverID = document.createElement("input");

			element_senderQualifier.setAttribute("type", "text");
			element_senderQualifier.setAttribute("placeholder",
					"Sender Qualifier");
			element_senderQualifier.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_senderQualifier.setAttribute("maxlength", "4");
			element_senderQualifier.setAttribute("id",
					"senderQualifier_Recadv");
			element_senderQualifier.setAttribute("name",
					"senderQualifier_Rec_name");

			parentRecadv.appendChild(element_senderQualifier);

			element_senderID.setAttribute("type", "text");
			element_senderID.setAttribute("placeholder", "Sender ID");
			element_senderID.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_senderID.setAttribute("id", "senderID_Recadv");
			element_senderID.setAttribute("name", "senderID_Rec_name");

			parentRecadv.appendChild(element_senderID);

			element_receiverQualifier.setAttribute("type", "text");
			element_receiverQualifier.setAttribute("placeholder",
					"Receiver Qualifier");
			element_receiverQualifier.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_receiverQualifier.setAttribute("maxlength", "4");
			element_receiverQualifier.setAttribute("id",
					"receiverQualifier_Recadv");
			element_receiverQualifier.setAttribute("name",
					"receiverQualifier_Rec_name");

			parentRecadv.appendChild(element_receiverQualifier);

			element_receiverID.setAttribute("type", "text");
			element_receiverID.setAttribute("placeholder", "Receiver ID");
			element_receiverID.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_receiverID.setAttribute("id", "receiverID_Recadv");
			element_receiverID.setAttribute("name", "receiverID_Rec_name");

			parentRecadv.appendChild(element_receiverID);

			var element_submit = document.createElement("input");
			element_submit.setAttribute("type", "submit");
			element_submit.setAttribute("value", "Send Rec");
			element_submit.setAttribute("id", "Send_Rec");

			parentRecadv.appendChild(element_submit);
		}
		recadv_one = 0;
	}

	function addDesadv() {
		if (document.getElementById("senderQualifier_X12")) {
			parentX12.removeChild(document
					.getElementById("senderQualifier_X12"));
			parentX12.removeChild(document.getElementById("senderID_X12"));
			parentX12.removeChild(document
					.getElementById("receiverQualifier_X12"));
			parentX12
					.removeChild(document.getElementById("receiverID_X12"));
			parentX12.removeChild(document.getElementById("Send_X12"));
			x12_one = 1;

		}

		if (document.getElementById("senderQualifier_Recadv")) {
			parentRecadv.removeChild(document
					.getElementById("senderQualifier_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("senderID_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("receiverQualifier_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("receiverID_Recadv"));
			parentRecadv.removeChild(document.getElementById("Send_Rec"));
			recadv_one = 1;
		}

		if (document.getElementById("senderID_VDA")) {
			parentVDA.removeChild(document.getElementById("senderID_VDA"));
			parentVDA
					.removeChild(document.getElementById("receiverID_VDA"));
			parentVDA.removeChild(document.getElementById("Send_VDA"));

			vda_one = 1;
		}

		if (document.getElementById("Send_NONEDI")) {
			parentNonEDI
					.removeChild(document.getElementById("Send_NONEDI"));
			nonEDI_one = 1;
		}

		/* if (document.getElementById("selectYourOwnFile")) {
			parentOwnFile.removeChild(document
					.getElementById("selectYourOwnFile"));
			parentOwnFile.removeChild(document
					.getElementById("Send_ownFile"));
			ownFile_one = 1;
		} */

		if (desadv_one == 1) {

			var br = document.createElement("br");
			var element_senderQualifier = document.createElement("input");
			var element_senderID = document.createElement("input");

			var element_receiverQualifier = document.createElement("input");
			var element_receiverID = document.createElement("input");

			element_senderQualifier.setAttribute("type", "text");
			element_senderQualifier.setAttribute("placeholder",
					"Sender Qualifier");
			element_senderQualifier.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_senderQualifier.setAttribute("name",
					"senderQualifier_Des_name");
			element_senderQualifier.setAttribute("maxlength", "4");
			element_senderQualifier.setAttribute("id",
					"senderQualifier_Desadv");

			parentDesadv.appendChild(element_senderQualifier);

			element_senderID.setAttribute("type", "text");
			element_senderID.setAttribute("placeholder", "Sender ID");
			element_senderID.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_senderID.setAttribute("name", "senderID_Des_name");
			element_senderID.setAttribute("id", "senderID_Desadv");

			parentDesadv.appendChild(element_senderID);

			element_receiverQualifier.setAttribute("type", "text");
			element_receiverQualifier.setAttribute("placeholder",
					"Receiver Qualifier");
			element_receiverQualifier.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_receiverQualifier.setAttribute("name",
					"receiverQualifier_Des_name");
			element_receiverQualifier.setAttribute("maxlength", "4");
			element_receiverQualifier.setAttribute("id",
					"receiverQualifier_Desadv");

			parentDesadv.appendChild(element_receiverQualifier);

			element_receiverID.setAttribute("type", "text");
			element_receiverID.setAttribute("placeholder", "Receiver ID");
			element_receiverID.setAttribute("style","height:20px; margin-right:10px;");
			element_receiverID.setAttribute("name", "receiverID_Des_name");
			element_receiverID.setAttribute("id", "receiverID_Desadv");

			parentDesadv.appendChild(element_receiverID);

			var element_submit = document.createElement("input");
			element_submit.setAttribute("type", "submit");
			element_submit.setAttribute("value", "Send Desadv");
			element_submit.setAttribute("id", "Send_Des");

			parentDesadv.appendChild(element_submit);
		}
		desadv_one = 0;
	}

	function addVDA() {

		if (document.getElementById("senderQualifier_X12")) {
			parentX12.removeChild(document
					.getElementById("senderQualifier_X12"));
			parentX12.removeChild(document.getElementById("senderID_X12"));
			parentX12.removeChild(document
					.getElementById("receiverQualifier_X12"));
			parentX12
					.removeChild(document.getElementById("receiverID_X12"));
			parentX12.removeChild(document.getElementById("Send_X12"));
			x12_one = 1;

		}

		if (document.getElementById("senderQualifier_Recadv")) {
			parentRecadv.removeChild(document
					.getElementById("senderQualifier_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("senderID_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("receiverQualifier_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("receiverID_Recadv"));
			parentRecadv.removeChild(document.getElementById("Send_Rec"));
			recadv_one = 1;
		}

		if (document.getElementById("senderQualifier_Desadv")) {
			parentDesadv.removeChild(document
					.getElementById("senderQualifier_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("senderID_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("receiverQualifier_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("receiverID_Desadv"));
			parentDesadv.removeChild(document.getElementById("Send_Des"));

			desadv_one = 1;
		}

		if (document.getElementById("Send_NONEDI")) {
			parentNonEDI
					.removeChild(document.getElementById("Send_NONEDI"));
			nonEDI_one = 1;
		}

		/* if (document.getElementById("selectYourOwnFile")) {
			parentOwnFile.removeChild(document
					.getElementById("selectYourOwnFile"));
			parentOwnFile.removeChild(document
					.getElementById("Send_ownFile"));
			ownFile_one = 1;
		} */

		if (vda_one == 1) {

			var element_senderID = document.createElement("input");
			var element_receiverID = document.createElement("input");

			element_senderID.setAttribute("type", "text");
			element_senderID.setAttribute("placeholder", "Sender ID");
			element_senderID.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_senderID.setAttribute("name", "senderID_VDA_name");
			element_senderID.setAttribute("maxlength", "9");
			element_senderID.setAttribute("id", "senderID_VDA");

			parentVDA.appendChild(element_senderID);

			element_receiverID.setAttribute("type", "text");
			element_receiverID.setAttribute("placeholder", "Receiver ID");
			element_receiverID.setAttribute("style",
					"height:20px; margin-right:10px;");
			element_receiverID.setAttribute("name", "receiverID_VDA_name");
			element_receiverID.setAttribute("id", "receiverID_VDA");
			element_receiverID.setAttribute("maxlength", "9");

			parentVDA.appendChild(element_receiverID);

			var element_submit = document.createElement("input");
			element_submit.setAttribute("type", "submit");
			element_submit.setAttribute("value", "Send VDA");
			element_submit.setAttribute("id", "Send_VDA");

			parentVDA.appendChild(element_submit);
		}
		vda_one = 0;
	}

	function warningBEDI() {
		if (document.getElementById("senderQualifier_X12")) {
			parentX12.removeChild(document
					.getElementById("senderQualifier_X12"));
			parentX12.removeChild(document.getElementById("senderID_X12"));
			parentX12.removeChild(document
					.getElementById("receiverQualifier_X12"));
			parentX12
					.removeChild(document.getElementById("receiverID_X12"));
			parentX12.removeChild(document.getElementById("Send_X12"));
			x12_one = 1;

		}

		if (document.getElementById("senderQualifier_Recadv")) {
			parentRecadv.removeChild(document
					.getElementById("senderQualifier_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("senderID_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("receiverQualifier_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("receiverID_Recadv"));
			parentRecadv.removeChild(document.getElementById("Send_Rec"));
			recadv_one = 1;
		}

		if (document.getElementById("senderQualifier_Desadv")) {
			parentDesadv.removeChild(document
					.getElementById("senderQualifier_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("senderID_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("receiverQualifier_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("receiverID_Desadv"));
			parentDesadv.removeChild(document.getElementById("Send_Des"));

			desadv_one = 1;
		}

		if (document.getElementById("senderID_VDA")) {
			parentVDA.removeChild(document.getElementById("senderID_VDA"));
			parentVDA
					.removeChild(document.getElementById("receiverID_VDA"));
			parentVDA.removeChild(document.getElementById("Send_VDA"));
			vda_one = 1;
		}

		/* if (document.getElementById("selectYourOwnFile")) {
			parentOwnFile.removeChild(document
					.getElementById("selectYourOwnFile"));
			parentOwnFile.removeChild(document
					.getElementById("Send_ownFile"));
			ownFile_one = 1;
		} */

		if (nonEDI_one == 1) {
			var element_submit = document.createElement("input");
			element_submit.setAttribute("type", "submit");
			element_submit.setAttribute("value",
					"Sure to Send NON EDI File?");
			element_submit.setAttribute("id", "Send_NONEDI");

			parentNonEDI.appendChild(element_submit);
		}

		nonEDI_one = 0;
	}

	/* function ownFile() {

		if (document.getElementById("senderQualifier_X12")) {
			parentX12.removeChild(document
					.getElementById("senderQualifier_X12"));
			parentX12.removeChild(document.getElementById("senderID_X12"));
			parentX12.removeChild(document
					.getElementById("receiverQualifier_X12"));
			parentX12
					.removeChild(document.getElementById("receiverID_X12"));
			parentX12.removeChild(document.getElementById("Send_X12"));
			x12_one = 1;

		}

		if (document.getElementById("senderQualifier_Recadv")) {
			parentRecadv.removeChild(document
					.getElementById("senderQualifier_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("senderID_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("receiverQualifier_Recadv"));
			parentRecadv.removeChild(document
					.getElementById("receiverID_Recadv"));
			parentRecadv.removeChild(document.getElementById("Send_Rec"));
			recadv_one = 1;
		}

		if (document.getElementById("senderQualifier_Desadv")) {
			parentDesadv.removeChild(document
					.getElementById("senderQualifier_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("senderID_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("receiverQualifier_Desadv"));
			parentDesadv.removeChild(document
					.getElementById("receiverID_Desadv"));
			parentDesadv.removeChild(document.getElementById("Send_Des"));

			desadv_one = 1;
		}

		if (document.getElementById("senderID_VDA")) {
			parentVDA.removeChild(document.getElementById("senderID_VDA"));
			parentVDA.removeChild(document.getElementById("receiverID_VDA"));
			parentVDA.removeChild(document.getElementById("Send_VDA"));
			vda_one = 1;
		}

		if (document.getElementById("Send_NONEDI")) {
			parentNonEDI
					.removeChild(document.getElementById("Send_NONEDI"));
			nonEDI_one = 1;
		}

		if (ownFile_one == 1) {

			var browseButton = document.createElement("input");

			browseButton.setAttribute("type", "file");
			browseButton.setAttribute("name", "selectYourOwnFile_name");
			browseButton.setAttribute("id", "selectYourOwnFile");
			browseButton.setAttribute("style","height:20px; margin-right:10px;")

			parentOwnFile.appendChild(browseButton);

			var element_submit = document.createElement("input");
			element_submit.setAttribute("type", "submit");
			element_submit.setAttribute("value", "Send Own FIle");
			element_submit.setAttribute("id", "Send_ownFile");

			parentOwnFile.appendChild(element_submit);  
		}
		ownFile_one = 0;
	} */
	</script>
</body>
</html>