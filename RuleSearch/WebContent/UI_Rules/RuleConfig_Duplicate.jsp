
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Func.*" %>

<!DOCTYPE html>
<html lang="en">
    
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="../css/RuleConfig.css">
  <link rel="shortcut icon" href="../images/bee.png" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  
  
<head>
    
  <title>Rule Configurations</title>
  
</head>

<h2 align="center">This Rule has Duplicate Entries</h2>
<%!
  String name,alias,ruleset, en,enAc[], def, stateEn=" ", stateDef=" ", action[];  String ass[]={};
  String ruleId="",EnabledAction,tmpRuleId,RuleIdArray[];
  
  
  String actionIds[];
  
  String cond[];
  Structures fileStruct=new Structures();
 
  DB2Connection DuplicateDbStruct=new DB2Connection();

%>
<%
		if (session.getAttribute("name") == null) { //Change path in server
			request.getRequestDispatcher("SessionTimeOut.jsp").forward(request,
					response);
		}
	%>
		<%
		
		  
		System.out.println("*********Reconnecting************");
		DuplicateDbStruct.getConnection();
		System.out.println("*********Reconnected*************");
		
		tmpRuleId=request.getAttribute("RuleId").toString();
		
		RuleIdArray=tmpRuleId.split(",");
		
		for(int COUNT=0;COUNT<RuleIdArray.length;COUNT++) //COUNT is the number of Rule Ids a rule holds
		{
			
			
			
		
	    EnabledAction=request.getAttribute("EnabledAction").toString();
		
		name=DuplicateDbStruct.getName(RuleIdArray[COUNT]); 
		
		alias=DuplicateDbStruct.getAlias(RuleIdArray[COUNT]);
		
		ruleset=DuplicateDbStruct.getRuleSet(RuleIdArray[COUNT]);
		
		en=DuplicateDbStruct.getEnabled(RuleIdArray[COUNT]);
		stateEn=" ";
		if(en.equals("0"))
		stateEn="checked";
		
		
		def=DuplicateDbStruct.getDefault(RuleIdArray[COUNT]);
		stateDef=(" ");
		if(def.equals("0"))
		stateDef="checked";
		
		
		enAc=DuplicateDbStruct.getActionEnabled(RuleIdArray[COUNT]).split(",");
		
			for(int i=0;i<enAc.length;i++)
			{
			if(enAc[i].equals("0"))
				enAc[i]="checked";
			else
				enAc[i]="";
			}
		
		cond=DuplicateDbStruct.getCond(RuleIdArray[COUNT]).split(",");
		
		actionIds=DuplicateDbStruct.getActionId(RuleIdArray[COUNT]).split(",");
		action=DuplicateDbStruct.getAction(RuleIdArray[COUNT]).split(",");
		
		
		%>

<body>
    <h2 align="center">Rule Configurations&nbsp;<%= COUNT+1 %>&nbsp;<input form="previous" type="image" name="submit" src="../images/previous.png" style="height:20px; width:20px"></h2>


<div >
<form id="previous" action="../RuleSearch.jsp" class="table table-striped"></form>

 
    
    
     <h3>Basic Info</h3>
    <table border="0" width="1" cellspacing="5" cellpadding="5">
        
        <tbody>
            <tr>
                <td>Business Alias</td>
                <td>&nbsp;&nbsp;<input type="text" size="65" name="Alias" value="<%= alias%>" readonly /></td>
            </tr>
            <tr>
                <td>Rule Name</td>
                <td>&nbsp;&nbsp;<input type="text" name="name" size="65" value="<%= name%>" readonly /></td>
            </tr>
             <tr>
                <td>Rule ID</td>
                <td>&nbsp;&nbsp;<input type="text" name="name" size="65" value="<%= RuleIdArray[COUNT]%>" readonly /></td>
            </tr>
            <tr>
                <td>Rule Set</td>
                <td>&nbsp;&nbsp;<input type="text" name="ruleset"size="65" value="<%= ruleset%>" readonly /></td>
            </tr>
            <tr>
                <td>Enabled</td>
                <td><input type="checkbox" name="enabled" <%=stateEn%> readonly disabled /></td>
            </tr>
            <tr>
                <td>Default</td>
                <td><input type="checkbox" name="default" <%=stateDef%> readonly disabled /></td>
            </tr>
            
        </tbody>
        
    </table>
    
    
     <% int z=0; for(int i=0;i<cond.length/3;i++){
     
     if(i==0 && !(cond[0].contains("null") || cond[0].equals(null))){
     %>
     <hr>
     <h3>Condition</h3>
     <%} %>
     <table border="0" width="1" cellspacing="5" cellpadding="5">
        
        <tbody>
        <% if(!(cond[0].contains("null") || cond[0].equals(null)) ){ %>
            <tr>
                <td>Field Name</td>
                <td>Operator</td>
                <td>Field Value</td>
            </tr>
         
            <tr>
              
              
                    <td><input type="text" name="fieldname" value=" <%=cond[z++]%>" style="width: 150px" readonly></td>
                    <td><input type="text" name="op" value="<%=cond[z++]%>" style="width: 75px" readonly> </td>
                    <td><input type="text" name="fieldvalue" value="<%=cond[z++]%>" style="width: 150px" readonly></td>                
                   
            </tr>
           
            <%}} %>
        </tbody>
        
    </table>

   
    
        
     
    <%  
    
      
          
   
    int acts=-1,next=0;
    int runOnce=0;
    
    //Outer Loop for Actions
     
    for(int i=0;i<action.length/2;i++){
    	
        	acts++;
        	
        	%> 
     
    
     
    
     <table border="0" width="1" cellspacing="5" cellpadding="5">
       
        <tbody>
        
        <%
        if(EnabledAction.equals("EnabledAction")) {
        
        	if(enAc[acts].equals("checked")){
        %>
        
         <%if(runOnce==0){ %><h3>Action</h3><% runOnce=1;} %>
        <th>Action</th>
        <tr><td>Enabled<input type="checkbox" <%= enAc[acts] %> disabled/></td></tr>
            <tr>
                <td>Action</td>
                <td>&nbsp;&nbsp;<input type="text" name="action" value="<%= action[next]%>" readonly/></td>
            </tr>
            <tr>
                <td>BPName</td>
                <td>&nbsp;&nbsp;<input type="text" name="bpn" value="<%= action[next+1]%>" readonly/></td>
            </tr>

        <tr>
        
        <td> </br></td>
        
        </tr>
           
      
        
    
    <% 
    
    ass=DuplicateDbStruct.getAssignment(actionIds[i]).split(",");
    
    
    int x=0; for(int j=0;j<(ass.length/2);j++){
    
    	if(x==0 && !(ass[x].contains("null"))){%> <th>Assignment</th><%}
    if(!(ass[x].equals(null) || ass[x].contains("null")) ){
    	
    %>
    
  
        <%  if(!(ass[x].equals(null) || ass[x].contains("null")) && x==0){
        
        %>
        
         
           <tr>
           <td><em>Field Name&nbsp;</em></td>
           <td><em>Field Value&nbsp;</em></td>
           </tr>
           
         <%} %>
         <tr><td></td></tr>
            <%if(!(ass[x].equals(null) || ass[x].contains("null"))){ %>
            <tr>
             
                <td><input type="text" name="assfield"  value="<%= ass[x++]%>" style="width: 175px" readonly></td>
                        
                <td><input type="text" name="assvalue" value="<%= ass[x++]%>" style="width: 175px" readonly> </td>                           
                      
            </tr>
            
         <% }
    }
    }
    
        	}else{}
        }else{

            if(runOnce==0){ %><h3>Action</h3><% runOnce=1;} %>
           <th>Action</th>
           <tr><td>Enabled<input type="checkbox" <%= enAc[acts] %> disabled/></td></tr>
               <tr>
                   <td>Action</td>
                   <td>&nbsp;&nbsp;<input type="text" name="action" value="<%= action[next]%>" readonly/></td>
               </tr>
               <tr>
                   <td>BPName</td>
                   <td>&nbsp;&nbsp;<input type="text" name="bpn" value="<%= action[next+1]%>" readonly/></td>
               </tr>

           <tr>
           
           <td> </br></td>
           
           </tr>
              
         
           
       
       <% 
       
       ass=DuplicateDbStruct.getAssignment(actionIds[i]).split(",");
      
       int x=0; for(int j=0;j<(ass.length/2);j++){
       
       	if(x==0 && !(ass[x].contains("null"))){%> <th>Assignment</th><%}
       if(!(ass[x].equals(null) || ass[x].contains("null")) ){
       	
       %>
       
     
           <%  if(!(ass[x].equals(null) || ass[x].contains("null")) && x==0){
           
           %>
           
            
              <tr>
              <td><em>Field Name&nbsp;</em></td>
              <td><em>Field Value&nbsp;</em></td>
              </tr>
              
            <%} %>
            <tr><td></td></tr>
               <%if(!(ass[x].equals(null) || ass[x].contains("null"))){ %>
               <tr>
                
                   <td><input type="text" name="assfield"  value="<%= ass[x++]%>" style="width: 175px" readonly></td>
                           
                   <td><input type="text" name="assvalue" value="<%= ass[x++]%>" style="width: 175px" readonly> </td>                           
                         
               </tr>
               
            <% }
       }
       }
      	
        }//if-else ends
        
    %><hr><% 
    
    next=next+2;
    
    } //Action Loop ends 
    
    
     
    %>
    
    
        </tbody>
        
    </table>
    
  </div>
 
 <%} %>

</body>
</html>


