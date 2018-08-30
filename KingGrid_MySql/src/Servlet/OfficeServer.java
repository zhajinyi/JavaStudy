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
 * @author ������
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
    String mFilePath; //ȡ�÷�����·��
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		  mFilePath = request.getSession().getServletContext().getRealPath("");       //ȡ�÷�����·��
		   try{
			   if(request.getMethod().equalsIgnoreCase("POST")){//�ж�����ʽ
				   MsgObj.setSendType("JSON");
				   MsgObj.Load(request); //��������
				   mOption = MsgObj.GetMsgByName("OPTION");//�������
				   mUserName = MsgObj.GetMsgByName("USERNAME");  //ȡ��ϵͳ�û�
				   System.out.println(mOption);
				   if(mOption.equalsIgnoreCase("LOADFILE")){
					    mRecordID = MsgObj.GetMsgByName("RECORDID");                        //ȡ���ĵ����
				        mFileName = MsgObj.GetMsgByName("FILENAME");//ȡ���ĵ�����
				        MsgObj.MsgTextClear();//����ı���Ϣ
				        System.out.println(mFilePath+"\\Document\\"+mFileName);
				        if (MsgObj.MsgFileLoad(mFilePath+"\\Document\\"+mFileName)){
				       // if (MsgObj.MsgFileLoad(mFilePath+"\\Document\\11.doc")){
				        	System.out.println(mRecordID+"�ĵ��Ѿ�����");
				        }
				   }else if(mOption.equalsIgnoreCase("SAVEFILE")){
					   System.out.println(mRecordID+"�ĵ��ϴ���");
					    mRecordID = MsgObj.GetMsgByName("RECORDID");                        //ȡ���ĵ����
				        mFileName = MsgObj.GetMsgByName("FILENAME");//ȡ���ĵ�����
				        MsgObj.MsgTextClear();//����ı���Ϣ
				        if (MsgObj.MsgFileSave(mFilePath+"\\Document\\"+mFileName)){
				        	System.out.println(mRecordID+"�ĵ��Ѿ�����ɹ�");
				        }					   
				   }else if(mOption.equalsIgnoreCase("SAVEPDF")){
					   System.out.println("�ĵ�תPDF");
					   mRecordID = MsgObj.GetMsgByName("RECORDID");                        //ȡ���ĵ����
				       mFileName = MsgObj.GetMsgByName("FILENAME");//ȡ���ĵ�����
				       MsgObj.MsgTextClear();//����ı���Ϣ
				        if (MsgObj.MsgFileSave(mFilePath+"\\PDF\\"+mFileName)){
				        	System.out.println(mRecordID+"�ĵ��Ѿ�ת���ɹ�");
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
