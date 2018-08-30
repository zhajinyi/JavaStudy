<%@ page contentType="text/html; charset=utf-8"%>
<%@ page
	import="java.io.*,java.text.*,java.util.*,java.sql.*,DBstep.iDBManager2000.*"%>
<%
	String mRecordID = request.getParameter("RecordID");
	if (mRecordID == null)
		mRecordID = "";
	String mTemplate = new String(request.getParameter("Template")
			.getBytes("8859_1"));
	String mSubject = new String(request.getParameter("Subject")
			.getBytes("8859_1"));
	String mAuthor = new String(request.getParameter("Author")
			.getBytes("8859_1"));
	String mFileDate = new String(request.getParameter("FileDate")
			.getBytes("8859_1"));
	String mFileType = new String(request.getParameter("FileType")
			.getBytes("8859_1"));
	String mHTMLPath = new String(request.getParameter("HTMLPath")
			.getBytes("8859_1"));
	String mStatus = "READ";

	DBstep.iDBManager2000 DbaObj = new DBstep.iDBManager2000();
System.out.println("mSubject"+mSubject);

	if (DbaObj.OpenConnection()) {
		String mysql = "SELECT RecordID from  Document Where RecordID='"
				+ mRecordID + "'";
		try {
			ResultSet result = DbaObj.ExecuteQuery(mysql);
			if (result.next()) {
				mysql = "update Document set RecordID=?,Template=?,Subject=?,Author=?,FileDate=?,FileType=?,HtmlPath=?,Status=? where RecordID='"
						+ mRecordID + "'";
			} else {
				mysql = "insert into Document (RecordID,Template,Subject,Author,FileDate,FileType,HtmlPath,Status) values (?,?,?,?,?,?,?,?)";
			}
			result.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		java.sql.PreparedStatement prestmt = null;
		try {
			prestmt = DbaObj.Conn.prepareStatement(mysql);
			prestmt.setString(1, mRecordID);
			prestmt.setString(2, mTemplate);
			prestmt.setString(3, mSubject);
			prestmt.setString(4, mAuthor);
			prestmt.setDate(5, DbaObj.GetDate());
			prestmt.setString(6, mFileType);
			prestmt.setString(7, mHTMLPath);
			prestmt.setString(8, "READ");
			// DbaObj.Conn.setAutoCommit(true) ;
			prestmt.executeUpdate();
			//DbaObj.Conn.commit();

		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			prestmt.close();
		}
		DbaObj.CloseConnection();
	} else {
		out.println("OpenDatabase Error");
	}
	out.println("<script language='javascript'>");
	out.println("window.opener.location.reload();");
	out.println("window.close(); ");
	out.println("</script>");
	//response.sendRedirect("DocumentList.jsp");
%>