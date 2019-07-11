package Func;

import java.io.*;




/**
 *
 * @author DebanshuVENDORMajumd
 */
public class Structures {
    
    FileNames getFilePath= new FileNames();
    String fieldName, fieldValue, Op;
    
    
    
    public Structures()
    {
    
    }
    
    public String getAlias(String name) throws FileNotFoundException, IOException
    {
        System.out.println(name);
   BufferedReader b2=new BufferedReader(new FileReader("C:\\Users\\DebanshuVENDORMajumd\\Desktop\\WORK\\Rules_Application\\cteDumps\\Rules.csv"));
  
   
    String s[];
    String file;
   label: while((file=b2.readLine())!=null)
   {
       s=file.split(",");
       try {
    if(name.equals(s[2]))
    {
    return s[3];
    }
       }catch(IndexOutOfBoundsException e)
       {
    	   
    	   continue label;
       }
   
   }
   b2.close();
   return "NONE";
    
    }
    
    
     public String getRuleSet(String name) throws FileNotFoundException, IOException
    {
        
   BufferedReader b2=new BufferedReader(new FileReader("C:\\Users\\DebanshuVENDORMajumd\\Desktop\\WORK\\Rules_Application\\cteDumps\\Rules.csv"));
   BufferedReader b3=new BufferedReader(new FileReader("C:\\Users\\DebanshuVENDORMajumd\\Desktop\\WORK\\Rules_Application\\cteDumps\\Rulesets.csv"));
  
   
    String s[],s1[];
    String file,file2;
   label: while((file=b2.readLine())!=null)
   {  
       s=file.split(",");
       try {
    if(name.equals(s[2]))
    {
        
      while((file2=b3.readLine())!=null)
   {
       s1=file2.split(",");
       if(s[4].equals(s1[0]))
       return s1[2];
        
    }
   
   
   }}catch(IndexOutOfBoundsException e)
   {
	   
	   continue label;
   }
    
   
    
    }
    b2.close();
    return "NONE";
    
    
}
     
      public String getEnabled(String name) throws FileNotFoundException, IOException
    {
        
   BufferedReader b2=new BufferedReader(new FileReader("C:\\Users\\DebanshuVENDORMajumd\\Desktop\\WORK\\Rules_Application\\cteDumps\\Rules.csv"));
  
   
    String s[];
    String file;
  label: while((file=b2.readLine())!=null)
   {
       s=file.split(",");
       try {
    if(name.equals(s[2]))
    {
        
   	
    return s[5];
    }
       }catch(IndexOutOfBoundsException e)
       {
    	   
    	   continue label;
       }
   
   }
    
   return "NONE";
    
    }
     
      
      public String getDefault(String name) throws FileNotFoundException, IOException
    {
        
   BufferedReader b2=new BufferedReader(new FileReader("C:\\Users\\DebanshuVENDORMajumd\\Desktop\\WORK\\Rules_Application\\cteDumps\\Rules.csv"));
  
   
    String s[];
    String file;
   label:while((file=b2.readLine())!=null)
   {
       s=file.split(",");
       try {
    if(name.equals(s[2]))
    {
        
    	System.out.println(s[6]+"Strcu");
    return s[6];
    }
   
   
   }catch(IndexOutOfBoundsException e)
   {
	   
	   continue label;
   } }
    
   return "NONE";
    
    }
     
       public String getCond(String name) throws FileNotFoundException, IOException
    {
        
   BufferedReader b2=new BufferedReader(new FileReader("C:\\Users\\DebanshuVENDORMajumd\\Desktop\\WORK\\Rules_Application\\cteDumps\\Rules.csv"));
   BufferedReader b3=new BufferedReader(new FileReader("C:\\Users\\DebanshuVENDORMajumd\\Desktop\\WORK\\Rules_Application\\cteDumps\\Conditions.csv"));

   
    String s[],s2[], res="";
    String file,file2;
   label: while((file=b2.readLine())!=null)
   {
       s=file.split(",");
       try {
    if(name.equals(s[2]))
    { 
      
         while((file2=b3.readLine())!=null)
           {
               s2=file2.split(",");
               if(s[0].equals(s2[7]))
               {  
                   res+=s2[3]+","+s2[4]+","+s2[5]+",";
               }
           }
    
    
   }}catch(IndexOutOfBoundsException e)
   {
	   
	   continue label;
   }
   
   }
    
   return res;
    
    }

       
       
       public String getAction(String name) throws FileNotFoundException, IOException
    {
        
   BufferedReader b2=new BufferedReader(new FileReader("C:\\Users\\DebanshuVENDORMajumd\\Desktop\\WORK\\Rules_Application\\cteDumps\\Rules.csv"));
   BufferedReader b3=new BufferedReader(new FileReader("C:\\Users\\DebanshuVENDORMajumd\\Desktop\\WORK\\Rules_Application\\cteDumps\\Actions.csv"));

   
    String s[],s2[], res="";
    String file,file2;
   label:while((file=b2.readLine())!=null)
   {
       s=file.split(",");
       try {
    if(name.equals(s[2]))
    { 
      
         while((file2=b3.readLine())!=null)
           {
               s2=file2.split(",");
               if(s[0].equals(s2[7]))
               {  
                   res+= s2[2]+","+s2[3]+",";
               }
           }
    
    
   }}catch(IndexOutOfBoundsException e)
       {
	   
	   continue label;
   }
   
    
    
    
    
   }
    
   return res;
    
    }
       
       
       
         public String getAssignment(String name) throws FileNotFoundException, IOException
    {
        
   BufferedReader b2=new BufferedReader(new FileReader("C:\\Users\\DebanshuVENDORMajumd\\Desktop\\WORK\\Rules_Application\\cteDumps\\JoinFileAssignment.csv"));


   System.out.println("Inside getAssignment");
    String s[], res="";
    String file, recovery;
    
 
   label:while((file=b2.readLine())!=null)
   {
	   
	   
       s=file.split(",");
       recovery=file;
       try {
    if(name.equals(s[2]))
    { 
      
    	 res+= s[22]+","+s[23]+",";
    	
    	
        
               } }catch(IndexOutOfBoundsException e)
               {
            	     
            		 continue label;
            	 }
           
    
    
      }
   

    
   
 
   return res;
    }
         
         
         
         public String getActionEnabled(String name) throws FileNotFoundException, IOException
         {
         
        	   BufferedReader b2=new BufferedReader(new FileReader(getFilePath.JoinFileAction));
        	   String s[];
        	   String file;
        	  label: while((file=b2.readLine())!=null)
        	   {
        	       s=file.split(",");
        	       try {
        	    if(name.equals(s[2]))
        	    {
        	        
        	    return s[17];
        	    }
        	       }catch(IndexOutOfBoundsException e)
        	       {
        	    	   
        	    	   continue label;
        	       }
        	   
        	   }
        	    
        	   return "NONE";
        	    
        	   

        	 
         }


         public String getDateModified(String name)throws FileNotFoundException, IOException
         {
      	   BufferedReader b2=new BufferedReader(new FileReader(getFilePath.Rules));

        	 
      	 String s[];
  	   String file;
  	  label: while((file=b2.readLine())!=null)
  	   {
  	       s=file.split(",");
  	       try {
  	    if(name.equals(s[2]))
  	    {
  	        
  	    return s[10];
  	    }
  	       }catch(IndexOutOfBoundsException e)
  	       {
  	    	   
  	    	   continue label;
  	       }
  	   
  	   }
  	    
  	   return "-----";
         }

}