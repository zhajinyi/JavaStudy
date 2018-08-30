package Servlet;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.File;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import DBstep.iDBManager2000;
import DBstep.iMsgServer2015;

/**
 * 
 * @author 陈益特
 * @time  2015-01-09
 */

public class OfficeServer  extends HttpServlet{
    private iMsgServer2015 MsgObj = new iMsgServer2015();
	String mOption;
	String mUserName;
	String mRecordID;
	String mFileName;
	String mFileType;
	byte[] mFileBody;	
	int mFileSize = 0;
    String mFilePath; //取得服务器路径
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  mFilePath = request.getSession().getServletContext().getRealPath("");       //取得服务器路径
		   try{
			   if(request.getMethod().equalsIgnoreCase("POST")){//判断请求方式
				   MsgObj.setSendType("JSON");
				   MsgObj.Load(request); //解析请求
				   mOption = MsgObj.GetMsgByName("OPTION");//请求参数
				   mUserName = MsgObj.GetMsgByName("USERNAME");  //取得系统用户
				   System.out.println(mOption);
				   if(mOption.equalsIgnoreCase("LOADFILE")){
					    mRecordID = MsgObj.GetMsgByName("RECORDID");                        //取得文档编号
				        mFileName = MsgObj.GetMsgByName("FILENAME");//取得文档名称
				        MsgObj.MsgTextClear();//清除文本信息
				        System.out.println(mFilePath+"\\Document\\"+mFileName);
				        if (MsgObj.MsgFileLoad(mFilePath+"\\Document\\"+mFileName)){
				       // if (MsgObj.MsgFileLoad(mFilePath+"\\Document\\11.doc")){
				        	System.out.println(mRecordID+"文档已经加载");
				        }
				   }else if(mOption.equalsIgnoreCase("SAVEFILE")){
					   System.out.println(mRecordID+"文档上传中");
					    mRecordID = MsgObj.GetMsgByName("RECORDID");                        //取得文档编号
				        mFileName = MsgObj.GetMsgByName("FILENAME");//取得文档名称
				        MsgObj.MsgTextClear();//清除文本信息
				        if (MsgObj.MsgFileSave(mFilePath+"\\Document\\"+mFileName)){
				        	System.out.println(mRecordID+"文档已经保存成功");
				        }					   
				   }else if(mOption.equalsIgnoreCase("SAVEPDF")){
					   System.out.println("文档转PDF");
					   mRecordID = MsgObj.GetMsgByName("RECORDID");                        //取得文档编号
				       mFileName = MsgObj.GetMsgByName("FILENAME");//取得文档名称
				       MsgObj.MsgTextClear();//清除文本信息
				        if (MsgObj.MsgFileSave(mFilePath+"\\PDF\\"+mFileName)){
				        	System.out.println(mRecordID+"文档已经转换成功");
				        }					   
				   
				   }
				 System.out.println("SendPackage");
				 MsgObj.Send(response);   
			   }
			}catch (Exception e) {
				e.printStackTrace();   
		    }
	}

}
