package com.yihengliu.web.action;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;

/**
 * Servlet user to accept file upload
 */
public class FileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String serverPath = "e:/upload/";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());

		System.out.println("�����̨...");

		// 1.����DiskFileItemFactory�������û�����
		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();

		// 2. ���� ServletFileUpload����
		ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);

		// 3. �����ļ����Ʊ���
		servletFileUpload.setHeaderEncoding("utf-8");

		// 4. ��ʼ�����ļ�
		// �ļ�md5��ȡ���ַ���
		String fileMd5 = null;
		// �ļ�������
		String chunk = null;
		try {
			List<FileItem> items = servletFileUpload.parseRequest(request);
			for (FileItem fileItem : items) {

				if (fileItem.isFormField()) { // >> ��ͨ����
					String fieldName = fileItem.getFieldName();
					if ("info".equals(fieldName)) {
						String info = fileItem.getString("utf-8");
						System.out.println("info:" + info);
					}
					if ("fileMd5".equals(fieldName)) {
						fileMd5 = fileItem.getString("utf-8");
						System.out.println("fileMd5:" + fileMd5);
					}
					if ("chunk".equals(fieldName)) {
						chunk = fileItem.getString("utf-8");
						System.out.println("chunk:" + chunk);
					}
				} else { // >> �ļ�
					/*// 1. ��ȡ�ļ�����
					String name = fileItem.getName();
					// 2. ��ȡ�ļ���ʵ������
					InputStream is = fileItem.getInputStream();
					
					// 3. �����ļ�
					FileUtils.copyInputStreamToFile(is, new File(serverPath + "/" + name));*/

					// ����ļ���û�д����ļ���
					File file = new File(serverPath + "/" + fileMd5);
					if (!file.exists()) {
						file.mkdirs();
					}
					// �����ļ�
					File chunkFile = new File(serverPath + "/" + fileMd5 + "/" + chunk);
					FileUtils.copyInputStreamToFile(fileItem.getInputStream(), chunkFile);

				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
