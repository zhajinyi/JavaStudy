package DBstep;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
//import org.apache.commons.fileupload.disk.DiskFileItemFactory;
//import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.DefaultFileItemFactory;
import org.apache.commons.fileupload.DiskFileUpload;
/**
 * 
 * @author ������
 *
 */
public class iMsgServer2015 {
    private Hashtable<String, String> saveFormParam = new Hashtable<String, String>();  //����form������
    private Hashtable<String, String> sendFormParam = new Hashtable<String, String>();  //����form������
	private InputStream fileContentStream;
	private String fileName = "";
	private byte[] mFileBody = null;
	private boolean isLoadFile = false;
	private String sendType ="";
	
	private static final String MsgError = "404"; //���ó���404��˵��û���ҵ���Ӧ���ĵ�
	
	
	public String getSendType() {
		return sendType;
	}

	public void setSendType(String sendType) {
		this.sendType = sendType;
	}

	/**
	 * @throws FileUploadException 
	 * @throws IOException 
	 * @deprecated:��̨������ӿ�
	 * @time:2015-01-09
	 */
	public void Load(HttpServletRequest request) throws FileUploadException, IOException{
		 request.setCharacterEncoding("gb2312");
		 //DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
		 //ServletFileUpload fileUpload = new ServletFileUpload(diskFileItemFactory);
		 DefaultFileItemFactory diskFileItemFactory = new DefaultFileItemFactory();
		DiskFileUpload fileUpload = new DiskFileUpload(diskFileItemFactory);
		List fileList =  fileUpload.parseRequest(request);
		 //List<FileItem> fileList =  fileUpload.parseRequest(request);
		 //Iterator iter = fileList.iterator();
		 if (fileList != null && fileList.size() > 0) {
			    for (int i=0; i<fileList.size(); i++) {
			        FileItem item = (FileItem)fileList.get(i);
			        if(item.isFormField()) {
			        	 processFormField(item);
			        }else{
			        	processUploadedFile(item);
			        }
			    }
			}
	/*	 while (iter.hasNext()) {
		 	 FileItem item = iter.next();
			 if (item.isFormField()) {
			    processFormField(item);
			 }else {
			    processUploadedFile(item);
			 }
		 }*/
	}
   
	/**
	 * @deprecated�������������
	 * @param item:������
	 * @throws UnsupportedEncodingException 
	 * @time:2015-01-09
	 */
	public void processFormField(FileItem item) throws UnsupportedEncodingException{
		String fieldName = item.getFieldName();
		String fieldValue = "";
		fieldValue = item.getString("utf-8");
		if(this.sendType.equalsIgnoreCase("JSON")){
			JSONObject json = JSONObject.fromObject(fieldValue);
			Iterator iter = json.keySet().iterator();   
			 while (iter.hasNext()) {   
			   fieldName = (String) iter.next();   
			   fieldValue = json.getString(fieldName); 
			   saveFormParam.put(fieldName, fieldValue);
			}
			 return;
		}
		saveFormParam.put(fieldName, fieldValue);
	}
	
	
	/**
	 * @deprecated�������ĵ�����
	 * @param item:�ĵ�����
	 * @throws IOException 
	 * @throws UnsupportedEncodingException
	 * @time:2015-01-09 
	 */	
	public void processUploadedFile(FileItem item) throws IOException{
		fileName = item.getName();
		if(fileName.indexOf("/")>=0){
			fileName = fileName.substring(fileName.lastIndexOf("/")+1);	
		}else if(fileName.indexOf("\\")>=0){
			fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
		}
	    fileContentStream =  item.getInputStream();
	
	}
	/**
	 * @deprecated�������ĵ�����
	 * @param fieldName:��������
	 * @return���������ڵ�ֵ
	 * @time:2015-01-09
	 */	
	public String GetMsgByName(String fieldName){
		return saveFormParam.get(fieldName);
	}

	/**
	 * �������SetMsgByName��������
	 * @time:2015-01-09
	 */
	public void MsgTextClear(){
		saveFormParam.clear();
	}
	
	
	public byte[] MsgFileBody() throws IOException{
		 mFileBody = null;
		 isLoadFile = false;
		 ByteArrayOutputStream output = new ByteArrayOutputStream();
		 byte[] buffer = new byte[4096];
		 int n = 0;
		 while (-1 != (n = fileContentStream.read(buffer))) {
		        output.write(buffer, 0, n);
		 }
	    mFileBody = output.toByteArray();
		return mFileBody;
	}
	
	
	/** 
     * ���ֽ����鱣��Ϊһ���ļ� 
     *  
     * @param b 
     * @param outputFile 
     * @return 
     */  
    public  boolean MsgFileSave(String outputFile) {  
    	 try {
    	File f = new File(outputFile);
    	FileOutputStream fos = null;    
        BufferedInputStream bis = null;    
        int BUFFER_SIZE = 1024; 
        byte[] buf = new byte[BUFFER_SIZE];    
        int size = 0;    
        bis = new BufferedInputStream(fileContentStream);    
		fos = new FileOutputStream(f);
        while ( (size = bis.read(buf)) != -1)     
          fos.write(buf, 0, size);    	        
        fos.close();    
        bis.close();
        return true;
    	 } catch (Exception e) {
 			e.printStackTrace();
 			return false;
 		}    
    }  
	

    
    public boolean MsgFileLoad(String fileName) throws IOException{
    	File file = new File(fileName);
    	if(file.exists()){
    	fileContentStream = new FileInputStream(new File(fileName));
    	MsgFileBody();
    	}else{
    		mFileBody = new byte[0];
    	}
    	isLoadFile = true;
    	return true;
    }
    
    
    /**
     * @deprecated:���ļ��Ķ������������õ���Ϣ����
     * @param response
     * @throws IOException
     */
    public void Send(HttpServletResponse response) throws IOException{
    	try{
	    	if(isLoadFile){
	    		    if(mFileBody.length != 0){
			    		response.setCharacterEncoding("utf-8");
				   		response.setContentType("application/x-msdownload;charset=utf-8");
				   		response.setContentLength(mFileBody.length);
				   	    response.setHeader("Content-Disposition","attachment;filename=");
				   	    response.getOutputStream().write(mFileBody,0,mFileBody.length);
	    		    }else{
	    		    	response.setHeader("MsgError",iMsgServer2015.MsgError);
	    		    }
	    	}    	
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
    	}catch(Exception e){
    		//e.printStackTrace();
    	}
    } 	
}
