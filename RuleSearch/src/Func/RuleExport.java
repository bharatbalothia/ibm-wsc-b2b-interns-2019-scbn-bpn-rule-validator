//Results written into a file saved in the local server (Static Tomcat Folder)
package Func;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class RuleExport {

	
	public void storeRules(String results) throws IOException
	{
		
		String res[]=results.split(",");
		
		
		
		 BufferedWriter b2=new BufferedWriter(new FileWriter("C:/Users/DebanshuVENDORMajumd/Desktop/Rules/RuleNames.txt"));

		
		 for(int i=0;i<res.length;i++)
		 {
			 
			 b2.write((i+1)+"."+res[i]+"\n");
			 
		 }
		 
	b2.close();	 
		
		
	}
	
}
