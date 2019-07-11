package Func;


import java.io.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileExport
 */
@WebServlet("/FileExport")
public class FileExport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileExport() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PrintWriter out =response.getWriter();
		String res[]=request.getParameter("ResultImport").split(",");
	
		System.out.println(res);
		
		 BufferedWriter b2=new BufferedWriter(new FileWriter("C:\\Users\\DebanshuVENDORMajumd\\Documents\\RuleNames.txt"));

		
		 for(int i=0;i<res.length;i++)
		 {
			 
			 b2.write((i+1)+"."+res[i]+"\n");
			 
		 }
		 
		 
	b2.close();	 
	
	out.println("<h2> Find the Result file--> C:\\Users\\DebanshuVENDORMajumd\\Documents\\RuleNames.txt</h2>");
	}
	
	
	

}
