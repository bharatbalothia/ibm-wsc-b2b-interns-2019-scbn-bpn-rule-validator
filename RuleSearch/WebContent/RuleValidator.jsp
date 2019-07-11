
<%@page import="java.util.*"%>
<%@page import="Func.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard || Rule Validator</title>
        
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" href="images/bee.png" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <link rel="stylesheet" href="css/RuleHome.css"> 
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
  <script src="javascript/Validator.js"></script>
  <script src="/javascript/RuleValidator.js"></script>
     
     
     <!-------------- SESSION MANAGEMENT ------------------------------------->
     <%
		if (session.getAttribute("name") == null) { //Change path in server
			request.getRequestDispatcher("SessionTimeOut.jsp").forward(request,
					response);
		}
	%>
	
	 <%
      System.out.print("Fetching Fieldnames(RV) - ");
      db2.getConnection();
      fieldNameCond= db2.getConditionFieldNames().split(",");
      fieldNameAss= db2.getAssignmentFieldNames().split(",");
            
      %>
	<!------------ -- SESSION MANAGEMENT ENDS -------------------------------->
    
   
  <!--**************** JS FUNCTIONS FOR ADDITION/DELETION OF FIELDS IN UI ************************************************ -->   
  <script>
  
  //To Add an Action set on ADD ACTION BUTTON CLICK
  function AddSection() {
	  
	  var sections = $('*[id^="Clone_this_"]:last');
	 
	  var id= sections[0].id;
	  var num = parseInt(id.substr(id.length -1))+1;
	  
	
       $('#Clone_this_0').clone().prop("id",'Clone_this_'+num).appendTo("#Clone_here");
   
    
      
       document.getElementById('Clone_this_'+num).getElementsByTagName("tbody")[1].id="Assignment_Section_"+num;
       
       
       var Ass_Row = $('*[id^="Assignment_Row"]:last');
       var Ass_num = parseInt(Ass_Row.substr(Ass_Row.length -1))+1;
 	  
       document.getElementById('Clone_this_'+num).getElementsByTagName("tr")[3].id="Assignment_Row_"+num;
      
  }

  // To add an Assignment with each ACTION SECTION
  function addAssignmentFunction(id,rowId) {
	  
	  var ROWS = $('*[id^="Assignment_Row_"]:last');
	  
	 
	  
	  var id_row= ROWS[0].id;
	 
	  
	  var row = parseInt(id.substr(id.length -1));
	  
  	  var txtNewInputBox = document.createElement('tr');
  	
  	
  	
  	 txtNewInputBox.innerHTML = "<td><select id=Assignment_Row_"+row+" style='width:250px;height:28px' class='form-control' name='assfield'><option selected='selected' value=''>--Select--</option><%for(int j=0;j<fieldNameAss.length;j++){%><option><%=fieldNameAss[j]%></option><%}%></select></td><td><input id= Assignment_Row_"+row+" class='form-control' type='text' name='assvalue' placeholder='Field Value' size='20' onfocus='this.value='''</td>";
      
  	 document.getElementById('Assignment_Section_'+row).appendChild(txtNewInputBox);
     }


  
  
  
  
  //This Code is to give an option to see existing Rule Names with same name
  function confirmBox(err, ResultNames) {
	  
	  
	  
	  if (confirm(err+'\n\nGo to Existing Rules?')) {
	   window.location='CheckExistingRules.jsp?Rules='+ResultNames;
	  } else {
	   window.location='RuleValidator.jsp';
	  }
	  
  }
  
  
  //This Code is to give an option to see existing Rule Names with same Conditions under same Alias
  function confirmBoxCond(err, ResultNames) {
	  
	  
	  if (confirm(err+'\n\nGo to Existing Rules?')) {
	   window.location='CheckExistingRules.jsp?Rules='+ResultNames;
	  } else {
	   window.location='RuleValidator.jsp';
	  }
	  
  }
  
  //-------------This code is to alert for general errors---------------
  function Error(Err){
		
	    alert(Err);
	    windows.location="RuleValidator.jsp"
  	  }
  	  
  //This part deals with element creation

  function createNewElement() {
		  	var txtNewInputBox = document.createElement('tr');
		
		  	txtNewInputBox.innerHTML =  "<td><select  class='form-control' name='fieldname' id='box' style='width:250px;height:28px'><option  selected='selected' value=''> -- Select-- </option><% for(int i=0;i<fieldNameCond.length;i++){ %><option><%= fieldNameCond[i] %></option><% } %></td><td><select id='box' class='form-control' name='operators' style='width:250px;height:28px'><option>*</option><option>EQ</option><option>LE</option><option>GE</option><option>NE</option><option>CO</option><option>SW</option><option>EW</option></select></td>\n\
		  	<td><input id='box' class='form-control' type='text' name='fieldvalue' placeholder='Field Value' size='20' onfocus='this.value=''' /></td>\n\
		  	<td><input id='box' type='button' onClick='remove();' value='X'/></td>";
		  	
		  	
		     
		  	document.getElementById("newElementId").appendChild(txtNewInputBox);
		  	
             }
             
             
             function remove() {
		      var elem = document.getElementById('box');
		      elem.parentNode.removeChild(elem);
		      return false;
		                             
             }
                              
         
             
             
             function remove2(id) {
	      var elem = document.getElementById(id);
	      elem.parentNode.removeChild(elem); 
	      return false;
	                       
             }    
                                  
             
             
          
  
</script>

 <!--***************** JS FUNCTIONS END ********************************************************************************** -->
  
 
    </head> 
   
   
    <body>
     
       	   
    <%!
    DB2Connection db2=new DB2Connection();
    
    //Some Static Data references
    Data javaData =new Data();    
    Data2 javaData2=new Data2();
    Data3 javaData3=new Data3();
    
    String fieldNameCond[],fieldNameAss[];
    int ActionCounts=0;
    %>  
               
     
	<div id="header" class="container"  >
		  <div class="page-header">
		  <h1 class="font-weight-bold" ><img src="images/HeaderIBMLogo.png" style="height:45px; width:100px"/> Rule Validator(Under Construction)</h1> 
		  </div>
		 
    </div>
    
<div  class="container" style="margin-left:250px; width:65%; height:450px;">  
        
  <form id="search-form" action="ValidatorResults.jsp" method="post"  >
    
    <table>
       
        
        <th> Credentials</th>
        
      
            <tr>
         
                <td><input class="form-control" id="t1" autocomplete="off" list ="ALIAS" type="text" onfocus="this.value=''" name="t1" placeholder="Business Alias" required /></td>
                <td><input  class="form-control" type="text"  id="t2" name="t2" placeholder="Rule Name" size="20" onfocus="this.value=''" required /></td>
                <td><input  class="form-control" id="t4" autocomplete="off" list ="RULESETNAME" type="text"   name="t4" placeholder="RuleSet Name" size="20" onfocus="this.value=''"  /></td>
              
              </tr>
              <tr>   
                
                
               
                
                
            </tr>
           
            
            <!-- Use of Static Data as Drop Down menu -->
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
			<!-- Use of Static Data as Drop Down menu -->
			
			         
            
            <tr>
                <td><input id="c1" type="checkbox" name="c1" value="ON" />&nbsp;Enabled</td> 
                <td><input id="c2" type="checkbox" name="c2" value="Default" />&nbsp;Default</td> 
                
           
                
            </tr>
            
            <tr>
                <th style="text-align: left">Conditions</th>
            
               
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
                        <option>LE</option>
                        <option>GE</option>
                        <option>NE</option>
                        <option>CO</option>
                        <option>SW</option>
                        <option>EW</option>
                        
                    </select></td>
                    <td><input  class="form-control" type="text" name="fieldvalue" placeholder="Field Value" size="20" onfocus="this.value=''" /></td>
           
                
            </tr>
            
            </tbody>
            
            
            
            <tr>
                
                <td><input onClick="createNewElement()" type="button" value="+" name="add" />&nbsp;Add Condition</td>
            
            </tr>
            
            
         
         </table>
         
         
         <div id="Clone_here">
         
           &nbsp;<label>Add Action</label>         
          <input type="button" id="Button1" value="+" onClick="AddSection()"/>
          
         <div id="Clone_this_0">
         <table id="ActionTable_0" >
            <tr >
                <th style="text-align: left">Action</th>
            
            </tr>
        
       
            <tr >
            
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


                
                <td>Enabled<input type="checkbox" name="EnabledAction" value="EnabledAction"></td>                
            </tr>
           
        
 

    
    
   
            <tr>
                <th style="text-align: left">Assignments:</th>
                <th></th>
            </tr>
        
        
        <tbody id="Assignment_Section_0">
            <tr id="Assignment_Row_0">
                
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
                <td><input  id="row_0" type='button' value='+' onclick="addAssignmentFunction(this.parentNode.parentNode.parentNode.parentNode.parentNode.id, this.id);">Add</td>
         
       </tr>
        </tbody>
        
    
    </table>
    </div>
    </div><!-- Clone Here -->
     
              </form>
              
            
              <form id="formId" action="./RuleHome.jsp ">
                <table>
                <tr>
                <td></td>
                </tr>
                </table>
                
                </form>
                
                
                <div style="margin-top:1px;position:relative">
     
         <table>
    
      <tr>
            
            <td>
            
            
            <input class="button" form="search-form" type="submit" value="Create Rule"  />
            
            <input form="search-form" class="button" type="reset" value="Clear">
          <input form="formId" class="button" type="submit" value="Back"/>
          
          
          </td></tr>
    </table>
        </div>
            
        </div>
        
        
        
       
       
       <%
       
       int ErrorId=0,pos=0;
       Enumeration<String> ch=request.getAttributeNames();
       
       int flag=0;
       while(ch.hasMoreElements())
       {
    	   
    	   if(ch.nextElement().toString()=="Error")
    		   {flag=1;break;}
    	
       }
      
      if(flag==1){
    	  String Error=request.getAttribute("Error").toString();
    	  
    	  String ErrorDisplay[]=Error.split(",");
    	  
    	  String Err="";
    	  for(int i=0;i<ErrorDisplay.length;i++)
    	  {
    		  Err+=ErrorDisplay[i]+";";
    		  
    	  }
    	  
    	  
    	  if(Error=="NONE"){
        %>
        
	       
		<script>
		
		alert('VALID RULE!!!') ;
		window.location='RuleValidator.jsp';
		</script> 

       <%} else{
    	   ErrorId=0;
       
       for(int k=0;k<ErrorDisplay.length;k++)
       {
    	   System.out.println("\n"+ErrorDisplay[k]+"\n");
    	   if(ErrorDisplay[k].contains("Name")){ErrorId=1;pos=k;}
    	   
    	   else if(ErrorDisplay[k].contains("Condition")){ErrorId=2;pos=k;}
       }
       System.out.println("Rule Validator Error ID "+ErrorId);
       
       if(ErrorId==1){
    	   
    	   String ResultNames=Validator.ResultNames;
    	   
    	   
       %>
       
    	  <script>
    	  
    	  var err='<%= ErrorDisplay[pos]%>';
    	  var res='<%= ResultNames%>';
		  confirmBox(err,res);
		
    	  
    	  </script> 
    	
      <%}else if(ErrorId==2){
   	   
   	   String ResultNamesCond=Validator.ResultConds;
   	   
   	   
      %>
      
   	  <script>
   	  
   	  var err='<%= ErrorDisplay[pos]%>';
   	  var res='<%= ResultNamesCond%>';
		  confirmBoxCond(err,res);
		
   	  
   	  </script> 
   	
     <%}
       
       else{%>
    	  <script>
    	 
    	  Error('<%=Err%>');
      	  
      	  </script> 
      	  
      	  
    <%  } 
       
       }}
      
    %>
       
        
    </body> 
</html>
