

<%@page import="Func.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard || Rule Search</title>
        
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
 
 
  <link rel="stylesheet" href="css/RuleHome.css">
        
        
         
		  <link rel="shortcut icon" href="images/bee.png" />
	 

<!--==================================CSS Internal==========================================================-->


<!--==================================CSS internal Ends=====================================================-->
        
    </head>
    <body>
     
         <%
		if (session.getAttribute("name") == null) { //Change address when delpoying to Project
			request.getRequestDispatcher("login.jsp").forward(request,
					response);
		}   
	   %>
	   
    <%!
    
    DB2Connection db2=new DB2Connection();
    Data javaData =new Data();
    Data2 javaData2=new Data2();
    Data3 javaData3=new Data3();
    
    String fieldNameCond[],fieldNameAss[];
    		%>  
        
        
    <%
    System.out.print("Fetching Fieldnames(RS) - ");
    db2.getConnection();
    fieldNameCond= db2.getConditionFieldNames().split(",");
    fieldNameAss= db2.getAssignmentFieldNames().split(",");
       
     %>
  
     
<!--==================================Java scripts==========================================================-->

 

 <script type="text/JavaScript">
 
 
 

 

               
         function createNewElement() {
    // First create a DIV element.
	var txtNewInputBox = document.createElement('tr');


    
	txtNewInputBox.innerHTML =  "<td><select  class='form-control' name='fieldname' id='box' style='width:250px;height:28px'><option  selected='selected' value=''> -- Select-- </option><% for(int i=0;i<fieldNameCond.length;i++){ %><option><%= fieldNameCond[i] %></option><% } %></td><td><select id='box' class='form-control' name='operators' style='width:250px;height:28px'><option>*</option><option>EQ</option><option>NE</option><option>SW</option><option>EW</option></select></td>\n\
	<td><input id='box' class='form-control' type='text' name='fieldvalue' placeholder='Field Value' size='20' onfocus='this.value=''' /></td>\n\
	<td><input id='box' type='button' onClick='remove();' value='X'/></td>";
	
	
   
	document.getElementById("newElementId").appendChild(txtNewInputBox);
	
           }
           
           
           function remove() {
    var elem = document.getElementById('box');
    elem.parentNode.removeChild(elem);
    return false;
                            }
                            
        function createNewElement2() {
    // First create a DIV element.
	var txtNewInputBox = document.createElement('tr');
	
    // Then add the content (a new input box) of the element.
	txtNewInputBox.innerHTML = "<td><select id='box2' style='width:250px;height:28px' class='form-control' name='assfield'><option selected='selected' value=''>--Select--</option><%for(int j=0;j<fieldNameAss.length;j++){%><option><%=fieldNameAss[j]%></option><%}%></select></td><td><input id='box2' class='form-control' type='text' name='assvalue' placeholder='Field Value' size='20' onfocus='this.value='''</td><td><input type='button' id='box2' value='X' onClick='remove2()'/></td>";

    
    // Finally put it where it is supposed to appear.
	document.getElementById("newElementId2").appendChild(txtNewInputBox);
           }
           
           
           function remove2() {
    var elem = document.getElementById('box2');
    elem.parentNode.removeChild(elem);
    return false;
                            }    
                                
             
</script>
                
<!--==================================Java scripts Ends==========================================================-->
                
                
                
                
	<div id="header" class="container"  >
		  <div class="page-header">
		  <h1 class="font-weight-bold" ><img src="images/HeaderIBMLogo.png" style="height:45px; width:100px"/> Rule Search</h1> 
		  </div>
		 
    </div>
    
       
   
   
   
        <div class="container" style="margin-left:250px; width:65%; height:450px;border-top:inset;border-left:inset;border-right:inset;  ">  
        
        
       
        
        
  <form id="search-form" action="UI_Rules/results.jsp" method="post"  >
    
    <table >
       
        
        <th>   Search by Credentials</th>
        
      
            <tr>
         
                <td><input class="form-control" id="X" autocomplete="off" list ="ALIAS" type="text" onfocus="this.value=''" name="t1" placeholder="Business Alias"  /></td>
                <td><input  class="form-control" type="text"   name="t2" placeholder="Rule Name" size="20" onfocus="this.value=''"  /></td>
              </tr>
              <tr>   
                
                
                <td><input  class="form-control"  id ="YY" autocomplete="off"  type="text"  name="t3" placeholder="Rule ID" size="20" onfocus="this.value=''"  /></td>
                <td><input  class="form-control" id="Y" autocomplete="off" list ="RULESETNAME" type="text"   name="t4" placeholder="RuleSet Name" size="20" onfocus="this.value=''"  /></td>
               
                
                
            </tr>
           
            
            
						            <datalist id="ALIAS">
						            <% for(int x=0;x<javaData.AliasName.length;x++){ %>
						               <option value="<%= javaData.AliasName[x]%>">
						               <%} %>
									</datalist>
									  <datalist id="RULESETNAME">
						            <% for(int z=0;z<javaData3.RuleSet.length;z++){ %>
						               <option value="<%= javaData3.RuleSet[z]%>">
						               <%} %>
									</datalist>
									
						            <datalist id="RULESID">
						               <% for(int z=0;z<javaData2.RuleId.length;z++){ %>
						               <option value="<%= javaData2.RuleId[z]%>">
						               <%} %>
									</datalist>            
            
            <tr>
                <td><input type="checkbox" name="c1" value="ON" />&nbsp;Enabled</td> 
                <td><input type="checkbox" name="c2" value="Default" />&nbsp;Default</td> 
                
           
                
            </tr>
            
            <tr>
                <th style="text-align: left"> Search by Conditions</th>
            </tr>
            
            
            <tbody id="newElementId">
        
        
            <tr class="tr_clone">
  
                <td>
                <select  class="form-control" name="fieldname" id='list' style="width:250px;height:28px">
                <option  selected="selected" value=""> -- Select-- </option>
                  <% for(int i=0;i<fieldNameCond.length;i++){ %>
                    <option> <%= fieldNameCond[i] %> </option>
                    <% } %>
                    
                </select>
                </td>
                
               <td><select  class="form-control" name="operators" style="width:250px;height:28px" >
                        <option selected="selected">*</option>
                        <option>EQ</option>
                        <option>NE</option>
                        <option>SW</option>
                        <option>EW</option>
                        
                    </select></td>
                    <td><input  class="form-control" type="text" name="fieldvalue" placeholder="Field Value" size="20" onfocus="this.value=''" /></td>
           
                
            </tr>
            
            </tbody>
            
            
            
            <tr>
                
                <td><input onClick="createNewElement()" type="button" value="+" name="add" />&nbsp;Add Condition</td>
            
            </tr>
            
        
         
        
         
         
         </tr>
         
        
            <tr>
                <th style="text-align: left">Search by Action</th>
                <th></th>
            </tr>
        
       
            <tr>
            
                <td><select  class="form-control" name="bpnname" id='list' size='1' style=" width: 250px; height:">
			                <option  selected="selected" value=""> -- Select-- </option>
			                <option>﻿860)</option>
							<option>BPN_BasicTranslation</option>
							<option>BPN_CarbonCopy</option>
							<option>BPN_DocExtractFlat</option>
							<option>BPN_DocExtractXML</option>
							<option>BPN_Finish</option>
							<option>BPN_ReceiveAS2CentreTrack</option>
							<option>BPN_ReceiveAS2PublicTrack</option>
							<option>BPN_ReceiveAS2Track</option>
							<option>BPN_ReceiveEinvoiceArchiveTrack</option>
							<option>BPN_ReceiveFSLocalTrack</option>
							<option>BPN_ReceiveFTPTrack</option>
							<option>BPN_ReceiveHTTPTrack</option>
							<option>BPN_ReceiveMQBusinessToneTrack</option>
							<option>BPN_ReceiveMQCdt2Track</option>
							<option>BPN_ReceiveMQCdt3Track</option>
							<option>BPN_ReceiveMQCdt4Track</option>
							<option>BPN_ReceiveMQCNetTrack</option>
							<option>BPN_ReceiveMQDemandTecTrack</option>
							<option>BPN_ReceiveMQHsds2Track</option>
							<option>BPN_ReceiveMQHsdsTrack</option>
							<option>BPN_ReceiveMQJMSTrack</option>
							<option>BPN_ReceiveMQMSftpTrack</option>
							<option>BPN_ReceiveMQOftpTrack</option>
							<option>BPN_ReceiveMQPublicTrack</option>
							<option>BPN_ReceiveMQSCVTrack</option>
							<option>BPN_ReceiveMQSibTrack</option>
							<option>BPN_ReceiveMQSwiftFileActTrack</option>
							<option>BPN_ReceiveMQSwiftTrack</option>
							<option>BPN_ReceiveMQTMSCommTrack</option>
							<option>BPN_ReceiveMQTMSTrack</option>
							<option>BPN_ReceiveMQWebEnablementTrack</option>
							<option>BPN_ReceiveMQWebformsTrack</option>
							<option>BPN_ReceiveMQWMSTrack</option>
							<option>BPN_ReceiveOFTP2Track</option>
							<option>BPN_ReceivePEPPOLTrack</option>
							<option>BPN_ReceiveRNIFTrack</option>
							<option>BPN_ReceiveRTPDropoffTrack</option>
							<option>BPN_ReceiveSAPTrack</option>
							<option>BPN_ReceiveSFTPTrack</option>
							<option>BPN_ReceiveWSGDropoffTrack</option>
							<option>BPN_ReceiveX400DeliveryNotifTrack</option>
							<option>BPN_ReceiveX400NonDeliveryNotifTrack</option>
							<option>BPN_ReceiveX400Track</option>
							<option>BPN_Router</option>
							<option>BPN_SendAS2Centre</option>
							<option>BPN_SendFSLocal</option>
							<option>BPN_SendMQAs2NA</option>
							<option>BPN_SendMQCaaS</option>
							<option>BPN_SendMQCdt2</option>
							<option>BPN_SendMQCdt3</option>
							<option>BPN_SendMQCdt4</option>
							<option>BPN_SendMQCNet</option>
							<option>BPN_SendMQDemandTec</option>
							<option>BPN_SendMQFtpEMEA</option>
							<option>BPN_SendMQFtpNA</option>
							<option>BPN_SendMQHttpNA</option>
							<option>BPN_SendMQJMS</option>
							<option>BPN_SendMQMSftp</option>
							<option>BPN_SendMQOftp</option>
							<option>BPN_SendMQOftp2</option>
							<option>BPN_SendMQPublic</option>
							<option>BPN_SendMQSCV</option>
							<option>BPN_SendMQSftpEMEA</option>
							<option>BPN_SendMQSftpNA</option>
							<option>BPN_SendMQSib</option>
							<option>BPN_SendMQTMS</option>
							<option>BPN_SendMQTMSComm</option>
							<option>BPN_SendMQWebEnablement</option>
							<option>BPN_SendMQWebforms</option>
							<option>BPN_SendMQWSG</option>
							<option>BPN_SendMQX400</option>
							<option>BPN_SendPod</option>
							<option>BPN_SwiftRouterFileAct</option>
							<option>BPN_Turn</option>
							</select>


                
                <td>Enabled<input type="checkbox" name="EnabledAction" value="EnabledAction" title="This will filter out Enabled Actions in the Rules"></td>                
            </tr>
           
        
 

    
    
   
            <tr>
                <th style="text-align: left">Assignments:</th>
                <th></th>
            </tr>
        
        
        <tbody id="newElementId2">
            <tr>
                
                 <td>
                <select  class="form-control" name="assfield" style=" width:250px ;height:28px">
                <!--hidden ="hidden"-->
                <option  selected="selected" value=""> -- Select-- </option>
                  <% for(int i=0;i<fieldNameAss.length;i++){ %>
                    <option> <%= fieldNameAss[i] %> </option>
                    <% } %>
                    
                </select>
                </td>
                <td><input  class="form-control" type="text" name="assvalue" placeholder="Field Value" size="20" onfocus="this.value=''" /></td>
                <td><input  type='button' value='+' onclick="createNewElement2();">Add</td>
                
            </tr>
            
        
        </tbody>
         
        
    </table>
    &nbsp;
    <input class="button"  type="submit" value="Search"  />
    <input class="button" type="reset" value="Clear">
    <input form="formId" class="button" type="submit" value="Back"/>
     
  </form>
            
            
</div>
        
             
              
              <form id="formId" action="./RuleHome.jsp ">
                <table>
                <tr>
                <td></td>
                </tr>
                </table>
                
                </form>
            
        
        
    </body> 
</html>
