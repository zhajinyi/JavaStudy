<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%@page import="java.net.URLDecoder"%>
<%!

  /**
   * 功能或作用：格式化日期时间
   * @param DateValue 输入日期或时间
   * @param DateType 格式化 EEEE是星期, yyyy是年, MM是月, dd是日, HH是小时, mm是分钟,  ss是秒
   * @return 输出字符串
   */

  public String FormatDate(String DateValue,String DateType)
  {
    String Result;
    SimpleDateFormat formatter = new SimpleDateFormat(DateType);
    try{
      Date mDateTime = formatter.parse(DateValue);
      Result = formatter.format(mDateTime);
    }catch(Exception ex){
      Result = ex.getMessage();
    }
    if (Result.equalsIgnoreCase("1900-01-01")){
      Result = "";
    }
    return Result;
  }
%>
<%
  ResultSet result=null;
  
  String mStatus=null;
  String mAuthor=null;
  String mFileName=null;
  String mFileDate=null;
  String mHTMLPath="";

  String mDisabled="";
  String mDisabledSave="";
  String mWord="";
  String mExcel="";

  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="OfficeServer";

  String mServerUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;//取得OfficeServer文件的完整URL
  String mHttpUrl="http://"+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/";
  String mRecordID=request.getParameter("RecordID");
  String mTemplate=request.getParameter("Template");
  String mFileType=request.getParameter("FileType");
  String mEditType=request.getParameter("EditType");
  System.out.println(mEditType);

  String mSubject= "";
  String mUserName=URLDecoder.decode( request.getParameter("UserName") ,"utf-8"); // new String(request.getParameter("UserName").getBytes("utf-8"));
  boolean isNewDocument = false;
  //设置编号初始值
  if (mRecordID==null){
     mRecordID="";
  }

  //设置编辑状态初始值
  if (mEditType==null || mEditType==""){
    mEditType="1";

  }

  //设置文档类型初始值
  if (mFileType==null || mFileType==""){
    mFileType=".doc";
  }

  //设置用户名初始值
  if (mUserName==null || mUserName==""){
    mUserName="金格科技";
  }

  //设置模板初始值
  if (mTemplate==null){
    mTemplate="";
  }
  

  
  //打开数据库
  DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
  if (DbaObj.OpenConnection()){
    String mSql="Select * From Document Where RecordID='"+ mRecordID + "'";
    try{
      result=DbaObj.ExecuteQuery(mSql);
      if (result.next()){
        mRecordID=result.getString("RecordID");
        mTemplate=result.getString("Template");
        mSubject=result.getString("Subject");
        mAuthor=result.getString("Author");
         mFileDate=FormatDate(result.getString("FileDate"),"yyyy-MM-dd HH:mm:ss");
        mStatus=result.getString("Status");
        mFileType=result.getString("FileType");
        mHTMLPath=result.getString("HTMLPath");
        isNewDocument = false;
      }
      else{
        //取得唯一值(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
        //初始化值
        mRecordID=ld.toString();//保存的是文档的编号，通过该编号，可以在里找到所有属于这条纪录的文档
        mTemplate=mTemplate;
        mSubject="请输入主题";
        mAuthor=mUserName;
        mFileDate=DbaObj.GetDateTime();
        mStatus="DERF";
        mFileType=mFileType;
        mHTMLPath="";
        isNewDocument = true;
      }
      result.close();
    }
    catch(SQLException e){
      System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
  }
   String mWPS="";
   if (mEditType.equalsIgnoreCase("0")){
    mDisabled="disabled";
    mDisabledSave="disabled";

  }else{
	if (mFileType.equalsIgnoreCase(".doc") || mFileType.equalsIgnoreCase(".docx")){
		mWPS ="";
		mWord="";
		mExcel = "disabled";
	  }else if(mFileType.equalsIgnoreCase(".wps")){
		mWPS ="disabled";
		mWord="";
		mExcel = "disabled";
	  }
	  else if (mFileType.equalsIgnoreCase(".xls")||mFileType.equalsIgnoreCase(".xlsx")){
		mWord="disabled";
		mWPS ="";
		mExcel = "";
	  }
	  else{
		mDisabled="disabled";
	  }
  }
  mFileName=mRecordID + mFileType;  //取得完整的文档名称
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <title>金格科技-iWebOffice2015智能文档中间件示例程序</title>
 <meta http-equiv="X-UA-Compatible" content="IE=9" />
 <script src="js/jquery-1.4.2.min.js"></script>
 <script src="js/WebOffice.js"></script>
 <script type="text/javascript">
 $(function(){
    var isNotLoad = true;/**公共方法**/	
	$(".tableAll").click(function(){
        if(isNotLoad){
            isNotLoad = false;	 
			  var noneY = $(this).next().css("display");
			  $(".tableAll").next().css("display","none");
			  $(".tableAll").find('td:eq(0)').css({'background-color':'#E6DBEC'});
			  $(".tableAll").find('span:eq(0)').html('+');
				  if( noneY== 'none'){
					  var s = $(this).find('td:eq(0)').html();                
					  $(this).find('td:eq(0)').html(s.replace("+", "-")) ;                              
					  $(this).find('td:eq(0)').css({'background-color':'#FFFFFF'});
		              $(this).next().slideToggle(function(){isNotLoad = true;});
				  }else{
					  isNotLoad = true;
				  }
            }
	});
	var hide = false;	//下拉
	$("#disPlayNone").click(function(){
		 if(hide){
			 $('#showTD').width('204px');
			 $(this).siblings().css("display", "")
			 hide = false;
		 }else{	
			 $('#showTD').width('25px');
			 $(this).siblings().css("display", "none")
			 hide = true;
		 }
	});		
})
</script>
<link rel='stylesheet' type='text/css' href='css/iWebProduct.css' />


<!-- 以下为2015主要方法 -->
<script type="text/javascript">
 	var WebOffice = new WebOffice2015(); //创建WebOffice对象
</script>
<script type="text/javascript">
 	function Load(){
 	  try{
 	  		WebOffice.WebUrl="<%=mServerUrl%>";             //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
		    WebOffice.RecordID="<%=mRecordID%>";            //RecordID:本文档记录编号
		    WebOffice.FileName="<%=mFileName%>";            //FileName:文档名称
		    WebOffice.FileType="<%=mFileType%>";            //FileType:文档类型  .doc  .xls  
		    WebOffice.UserName="<%=mUserName%>";            //UserName:操作用户名，痕迹保留需要
		    WebOffice.AppendMenu("1","打开本地文件(&L)");    //多次给文件菜单添加
		    WebOffice.AppendMenu("2","保存本地文件(&S)");
			WebOffice.AppendMenu("3","-");
			WebOffice.AppendMenu("4","打印预览(&C)");
			WebOffice.AppendMenu("5","退出打印预览(&E)");
			WebOffice.AddCustomMenu();                       //一次性多次添加包含二次菜单
			WebOffice.Skin('purple');                        //设置皮肤
		    WebOffice.HookEnabled();
		    WebOffice.SetCaption(); 
		    WebOffice.SetUser("<%=mUserName%>");
		    if(WebOffice.WebOpen()){                             //打开该文档    交互OfficeServer  调出文档OPTION="LOADFILE"
			    WebOffice.setEditType("<%=mEditType%>");         //EditType:编辑类型  方式一   WebOpen之后
			    WebOffice.VBASetUserName(WebOffice.UserName);    //设置用户名
				getEditVersion();//判断是否是永中office
			    WebOffice.AddToolbar();//打开文档时显示手写签批工具栏
			    WebOffice.ShowCustomToolbar(false);//隐藏手写签批工具栏
			    StatusMsg(WebOffice.Status);
		    }
 	  }catch(e){
 	     alert(e.description);       
 	  }
 	}
	 //作用：保存文档
	function SaveDocument(){
	  if (WebOffice.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"
	     document.getElementById("iWebOfficeForm").submit();
	     return true;
	  }else{
	     StatusMsg(WebOffice.Status);
	     return false;
	  }
	}
 	
 	
 	//设置页面中的状态值
 	function StatusMsg(mValue){
 	   try{
	   document.getElementById('state').innerHTML = mValue;
	   }catch(e){
	     return false;
	   }
	}
	
	//作用：获取文档Txt正文
	function WebGetWordContent(){
	  try{
	    alert(WebOffice.WebObject.ActiveDocument.Content.Text);
	  }catch(e){alert(e.description);}
	}
	
	//作用：写Word内容
	function WebSetWordContent(){
	  var mText=window.prompt("请输入内容:","测试内容");
	  if (mText==null){
	     return (false);
	  }else{
	     WebOffice.WebObject.ActiveDocument.Application.Selection.Range.Text= mText+"\n";
	  }
	}

	//作用：获取文档页数
	function WebDocumentPageCount(){
	    if (WebOffice.FileType==".doc"||WebOffice.FileType==".docx"){
		var intPageTotal = WebOffice.WebObject.ActiveDocument.Application.ActiveDocument.BuiltInDocumentProperties(14);
		intPageTotal = WebOffice.blnIE()?intPageTotal:intPageTotal.Value();
		alert("文档页总数："+intPageTotal);
	    }
	    if (WebOffice.FileType==".wps"){
			var intPageTotal = WebOffice.WebObject.ActiveDocument.PagesCount();
			alert("文档页总数："+intPageTotal);
	    }
	}
	
	//作用：显示或隐藏痕迹[隐藏痕迹时修改文档没有痕迹保留]  true表示隐藏痕迹  false表示显示痕迹
	function ShowRevision(mValue){
	  if (mValue){
	     WebOffice.WebShow(true);
	     StatusMsg("显示痕迹...");
	  }else{
	     WebOffice.WebShow(false);
	     StatusMsg("隐藏痕迹...");
	  }
	}
	
	//接受文档中全部痕迹
	function WebAcceptAllRevisions(){
	  WebOffice.WebObject.ActiveDocument.Application.ActiveDocument.AcceptAllRevisions();
	  var mCount = WebOffice.WebObject.ActiveDocument.Application.ActiveDocument.Revisions.Count;
	  if(mCount>0){
	    return false;
	  }else{
	    return true;
	  }
	}
	
		//作用：VBA套红
	function WebInsertVBA(){
		//画线
		try{
		var object=WebOffice.WebObject.ActiveDocument;
		var myl=object.Shapes.AddLine(100,60,305,60);
		var myl1=object.Shapes.AddLine(326,60,520,60);
	   	var myRange=WebOffice.WebObject.ActiveDocument.Range(0,0);
		myRange.Select();
		var mtext="★";
		WebOffice.WebObject.ActiveDocument.Application.Selection.Range.InsertAfter (mtext+"\n");
	   	var myRange=WebOffice.WebObject.ActiveDocument.Paragraphs(1).Range;
	   	myRange.ParagraphFormat.LineSpacingRule =1.5;
	   	myRange.font.ColorIndex=6;
	   	myRange.ParagraphFormat.Alignment=1;
	   	myRange=WebOffice.WebObject.ActiveDocument.Range(0,0);
		myRange.Select();
		mtext="金格发[２０１２]１５４号";
		WebOffice.WebObject.ActiveDocument.Application.Selection.Range.InsertAfter (mtext+"\n");
		myRange=WebOffice.WebObject.ActiveDocument.Paragraphs(1).Range;
		myRange.ParagraphFormat.LineSpacingRule =1.5;
		myRange.ParagraphFormat.Alignment=1;
		myRange.font.ColorIndex=1;
		mtext="金格电子政务文件";
		WebOffice.WebObject.ActiveDocument.Application.Selection.Range.InsertAfter (mtext+"\n");
		myRange=WebOffice.WebObject.ActiveDocument.Paragraphs(1).Range;
		myRange.ParagraphFormat.LineSpacingRule =1.5;
		myRange.Font.ColorIndex=6;
		myRange.Font.Name="仿宋_GB2312";
		myRange.font.Bold=true;
		myRange.Font.Size=50;
		myRange.ParagraphFormat.Alignment=1;
		WebOffice.WebObject.ActiveDocument.PageSetup.LeftMargin=70;
		WebOffice.WebObject.ActiveDocument.PageSetup.RightMargin=70;
		WebOffice.WebObject.ActiveDocument.PageSetup.TopMargin=70;
		WebOffice.WebObject.ActiveDocument.PageSetup.BottomMargin=70;
		}catch(e){
		 alert(e);
		}
	}

	//作用：设置书签值  vbmName:标签名称，vbmValue:标签值   标签名称注意大小写
	function SetBookmarks(){
		try{
			var mText=window.prompt("请输入书签名称和书签值，以','隔开。","例如：book1,book2");
			var mValue = mText.split(",");
			BookMarkName = mValue[0];
			BookMarkValue = mValue[1];
			WebOffice.WebSetBookmarks(mValue[0],mValue[1]);
			StatusMsg("设置成功");
			return true;
		}catch(e){
			StatusMsg("书签不存在");
			return false;
		}
	}
	//打开书签窗口
	function WebOpenBookMarks(){	
			WebOffice.WebOpenBookMarks();
		 }
	//添加书签
	function WebAddBookMarks(){//书签名称，书签值
		WebOffice.WebAddBookMarks("JK","KingGrid");
	}
	 //定位书签
	function WebFindBookMarks(){
		WebOffice.WebFindBookMarks("JK");
	 }
	 //删除书签
	function WebDelBookMarks(){//书签名称，
	    WebOffice.WebDelBookMarks("JK");//删除书签
	 }
         
	function DelFile(){
	   var mFileName = WebOffice.FilePath+WebOffice.FileName;
       WebOffice.Close(); 
       WebOffice.WebDelFile(mFileName);
	}
	//作用：用Excel求和
	function WebGetExcelContent(){
	  if(!WebOffice.WebObject.ActiveDocument.Application.Sheets(1).ProtectContents){
		  WebOffice.WebObject.ExitExcelEditMode();
		  WebOffice.WebObject.Activate(true);  
		  WebOffice.WebObject.ActiveDocument.Application.Sheets(1).Select();
		  WebOffice.WebObject.ActiveDocument.Application.Range("C5").Select();
		  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "126";
		  WebOffice.WebObject.ActiveDocument.Application.Range("C6").Select();
		  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "446";
		  WebOffice.WebObject.ActiveDocument.Application.Range("C7").Select();
		  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "556";
		  WebOffice.WebObject.ActiveDocument.Application.Range("C5:C8").Select();
		  WebOffice.WebObject.ActiveDocument.Application.Range("C8").Activate();
		  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "=SUM(R[-3]C:R[-1]C)";
		  WebOffice.WebObject.ActiveDocument.Application.Range("D8").Select();
		  WebOffice.WebObject.ActiveDocument.application.sendkeys("{ESC}");
		  StatusMsg(WebOffice.WebObject.ActiveDocument.Application.Range("C8").Text);
	  }
	
	}
	
		//作用：保护工作表单元
	function WebSheetsLock(){
		 if(!WebOffice.WebObject.ActiveDocument.Application.Sheets(1).ProtectContents){
	  WebOffice.WebObject.ActiveDocument.Application.Range("A1").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "产品";
	  WebOffice.WebObject.ActiveDocument.Application.Range("B1").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "价格";
	  WebOffice.WebObject.ActiveDocument.Application.Range("C1").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "详细说明";
	  WebOffice.WebObject.ActiveDocument.Application.Range("D1").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "库存";
	  WebOffice.WebObject.ActiveDocument.Application.Range("A2").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "书签";
	  WebOffice.WebObject.ActiveDocument.Application.Range("A3").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "毛笔";
	  WebOffice.WebObject.ActiveDocument.Application.Range("A4").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "钢笔";
	  WebOffice.WebObject.ActiveDocument.Application.Range("A5").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "尺子";
	
	  WebOffice.WebObject.ActiveDocument.Application.Range("B2").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "0.5";
	  WebOffice.WebObject.ActiveDocument.Application.Range("C2").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "樱花";
	  WebOffice.WebObject.ActiveDocument.Application.Range("D2").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "300";
	
	  WebOffice.WebObject.ActiveDocument.Application.Range("B3").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "2";
	  WebOffice.WebObject.ActiveDocument.Application.Range("C3").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "狼毫";
	  WebOffice.WebObject.ActiveDocument.Application.Range("D3").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "50";
	
	  WebOffice.WebObject.ActiveDocument.Application.Range("B4").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "3";
	  WebOffice.WebObject.ActiveDocument.Application.Range("C4").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "蓝色";
	  WebOffice.WebObject.ActiveDocument.Application.Range("D4").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "90";
	
	  WebOffice.WebObject.ActiveDocument.Application.Range("B5").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "1";
	  WebOffice.WebObject.ActiveDocument.Application.Range("C5").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "20cm";
	  WebOffice.WebObject.ActiveDocument.Application.Range("D5").Select();
	  WebOffice.WebObject.ActiveDocument.Application.ActiveCell.FormulaR1C1 = "40";
	
	  //保护工作表
	  WebOffice.WebObject.ActiveDocument.Application.Range("B2:D5").Select();
	  WebOffice.WebObject.ActiveDocument.Application.Selection.Locked = false;
	  WebOffice.WebObject.ActiveDocument.Application.Selection.FormulaHidden = false;
	  WebOffice.WebObject.ActiveDocument.Application.ActiveSheet.Protect(true,true,true);
	  StatusMsg("已经保护工作表，只有B2-D5单元格可以修改。");
		 }
	}
	
	//根据当空打开的文档类型保存文档
	function WebOpenLocal(){
	   WebOffice.WebOpenLocal();
	   //WebOffice.WebDelFile(WebOffice.FilePath+WebOffice.FileName);
	   //WebOffice.FileType = WebOffice.WebGetDocSuffix();
	   //WebOffice.FileName = WebOffice.FileName.substring(0,WebOffice.FileName.lastIndexOf("."))+WebOffice.FileType;
	   //document.getElementById('FileType').value = WebOffice.FileType;
	}
	//调用模板
	function WebUseTemplate(fileName){
	    var currFilePath;
	    if(WebOffice.WebAcceptAllRevisions()){//清除正文痕迹的目的是为了避免痕迹状态下出现内容异常问题。
	       currFilePath = WebOffice.getFilePath(); //获取2015特殊路径
	       WebOffice.WebSaveLocalFile(currFilePath+WebOffice.iWebOfficeTempName);//将当前文档保存下来
	       if(WebOffice.DownloadToFile(fileName,currFilePath)){//下载服务器指定的文件
	          WebOffice.OpenLocalFile(currFilePath+fileName);//打开该文件
	          if(!WebOffice.VBAInsertFile("Content",currFilePath+WebOffice.iWebOfficeTempName)){//插入文档
	           StatusMsg("插入文档失败"); 
	           return;
	          }
	          StatusMsg("模板套红成功"); 
	          return; 
	       }
	       StatusMsg("下载文档失败"); 
	       return;
	    }
	    StatusMsg("清除正文痕迹失败，套红中止"); 
	}
	//手写签批
	function HandWriting(){
	 	var penColor=document.getElementById("PenColor").value;
	 	var penWidth=document.getElementById("PenWidth").value;
	 	WebOffice.HandWriting(penColor,penWidth);
	}
	function getEditVersion(){
		var getVersion=WebOffice.getEditVersion(); //获取当前编辑器软件版本
		if (getVersion == "YozoWP.exe" || getVersion == "YozoSS.exe")  //如果是永中office,隐藏手写功能等
		{
		    document.getElementById("handWriting1").style.display='none';
		    document.getElementById("handWriting2").style.display='none';
		    document.getElementById("expendFunction").style.display='none';
		    document.getElementById("enableCopy1").style.display='none';
		    document.getElementById("enableCopy2").style.display='none';
		    document.getElementById("OpenBookMarks").style.display='none';
		    document.getElementById("areaProtect").style.display='none';
		    document.getElementById("areaUnprotect").style.display='none';
		    
		}else if(getVersion == "WINWORD.EXE" || getVersion == "wps.exe") {
			WebOffice.ShowWritingUser(true);
		}
		
	}
	//全屏
	function FullSize(mValue){
		WebOffice.FullSize(mValue);
	}
	//添加区域保护
	function WebAreaProtect(){	
		var mText = window.prompt("请输入书签名称", "KingGrid","");
		if(mText!=null)	WebOffice.WebAreaProtect(mText);
	}
	//取消区域保护
	function WebAreaUnprotect(){
		var mText = window.prompt("请输入书签名称", "KingGrid","");
		if(mText!=null) WebOffice.WebAreaUnprotect(mText);
	}
	//执行宏命令
	function WebRunMacro(){		
		window.open("MacroForm.htm",'','height=250px,width=450px,top=300,left=350,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
		
	}
</script>
<script language="javascript" for="WebOffice2015" event="OnReady()">
   WebOffice.setObj(document.getElementById('WebOffice2015'));//给2015对象赋值
   Load();//避免页面加载完，控件还没有加载情况
</script>
<script language="javascript" for="WebOffice2015" event="OnRightClickedWhenAnnotate()">
   WebOffice.ShowToolBars(true);//停止签批时显示工具栏
   WebOffice.ShowMenuBar(true);//停止签批时显示菜单栏
</script>
<script language="JavaScript" for=WebOffice2015 event="OnFullSizeBefore(bVal)">
    if(bVal == true){
    	var getVersion=WebOffice.getEditVersion();
    	if(getVersion == "WINWORD.EXE" || getVersion == "wps.exe") {
			WebOffice.ShowCustomToolbar(true);//显示手写签批工具栏
		}
    }
</script>
<script language="JavaScript" for=WebOffice2015 event="OnFullSizeAfter(bVal)">
    if(bVal == false){
    	WebOffice.ShowCustomToolbar(false);	//隐藏控件的手写签批工具栏
    }
</script>

<script language="javascript" for=WebOffice2015 event="OnRecvStart(nTotleBytes)">
    nSendTotleBytes = nTotleBytes;
    nSendedSumBytes = 0;
</script>
<script language="javascript" for=WebOffice2015 event="OnRecving(nRecvedBytes)">
    nSendedSumBytes += nRecvedBytes;
</script>
<script language="javascript" for=WebOffice2015 event="OnRecvEnd(bSucess)">

</script>
<script language="javascript" for=WebOffice2015 event="OnSendStart(nTotleBytes)">
    nSendTotleBytes = nTotleBytes;
    nSendedSumBytes = 0;
</script>
<script language="javascript" for=WebOffice2015 event="OnSending(nSendedBytes)">
    nSendedSumBytes += nSendedBytes;
</script>
<script language="javascript" for=WebOffice2015 event="OnSendEnd(bSucess)">
    if (bSucess){
        if(WebOffice.sendMode == "LoadImage"){
          var httpclient = WebOffice.WebObject.Http;
          WebOffice.hiddenSaveLocal(httpclient,WebOffice,false,false,WebOffice.ImageName);
          WebOffice.InsertImageByBookMark();
          WebOffice.ImageName = null;
          WebOffice.BookMark = null;
          StatusMsg("插入图片成功");
          return
	     } 
	      StatusMsg("插入图片失败"); 
    }
</script>
<script language="JavaScript" for=WebOffice2015 event="OnCommand(ID, Caption, bCancel)">
   switch(ID){
	    case 1:WebOpenLocal();break;//打开本地文件
	    case 2:WebOffice.WebSaveLocal();break;//另存本地文件
		case 4:WebOffice.PrintPreview();break;//启用
		case 5:WebOffice.PrintPreviewExit();WebOffice.ShowField();break;//启用
		case 17:WebOffice.SaveEnabled(true);StatusMsg("启用保存");break;//启用保存
		case 18:WebOffice.SaveEnabled(false);StatusMsg("关闭保存");break;//关闭保存
		case 19:WebOffice.PrintEnabled(true);StatusMsg("启用打印");break;//启用打印
		case 20:WebOffice.PrintEnabled(false);StatusMsg("关闭打印");break;//关闭打印
		case 301:WebOffice.HandWriting("255","4");StatusMsg("手写签批");break;//手写签批
		case 302:WebOffice.StopHandWriting();StatusMsg("停止手写签批");break;//停止手写签批
		case 303:WebOffice.TextWriting();StatusMsg("文字签名");break;//文字签名
		case 304:WebOffice.ShapeWriting();StatusMsg("图形签批");break;//图形签批
		case 305:WebOffice.RemoveLastWriting();StatusMsg("取消上一次签批");break;//取消上一次签批
		case 306:WebOffice.ShowWritingUser(false,WebOffice.UserName);StatusMsg("显示签批用户");break;//显示签批用户
		default:;return;  
  }   
</script>

<script language="javascript" for=WebOffice2015 event="OnQuit()">
//DelFile();
</script>


<!--以下是多浏览器的事件方法 -->
<script >
function OnReady(){
 WebOffice.setObj(document.getElementById('WebOffice2015'));//给2015对象赋值
 //Load();//避免页面加载完，控件还没有加载情况
 window.onload = function(){Load();} //IE和谷歌可以直接调用Load方法，火狐要在页面加载完后去调用
}
//停止签批时显示工具栏和菜单栏
function OnRightClickedWhenAnnotate(){
	WebOffice.ShowToolBars(true);
    WebOffice.ShowMenuBar(true);
}
//全屏显示控件的手写签批工具栏
function OnFullSizeBefore(bVal){
	 if(bVal == true){
    	var getVersion=WebOffice.getEditVersion();
    	if(getVersion == "WINWORD.EXE" || getVersion == "wps.exe") {
			WebOffice.ShowCustomToolbar(true);//显示手写签批工具栏
		}	
    }
}
//退出全屏隐藏控件的手写签批工具栏
function OnFullSizeAfter(bVal){
	if(bVal == false){
    	WebOffice.ShowCustomToolbar(false);	
    }
}
//上传下载回调用事件
function OnSendStart(nTotleBytes){
 nSendTotleBytes = nTotleBytes;nSendedSumBytes = 0;
}
function OnSending(nSendedBytes){
        nSendedSumBytes += nSendedBytes;
}
//异步上传
function OnSendEnd() {
    if(WebOffice.sendMode == "LoadImage"){
    	var httpclient = WebOffice.WebObject.Http;
    	WebOffice.hiddenSaveLocal(httpclient,WebOffice,false,false,WebOffice.ImageName);
     	WebOffice.InsertImageByBookMark();
        WebOffice.ImageName = null;
        WebOffice.BookMark = null;
        StatusMsg("插入图片成功");
        return;
	} 
	StatusMsg("插入图片失败"); 
}
function OnRecvStart(nTotleBytes){
    nSendTotleBytes = nTotleBytes;nSendedSumBytes = 0;
}
function OnRecving(nRecvedBytes){
   nSendedSumBytes += nRecvedBytes;
}
//异步下载
function OnRecvEnd() {
}
function OnCommand(ID, Caption, bCancel){
   switch(ID){
	    case 1:WebOpenLocal();break;//打开本地文件
	    case 2:WebOffice.WebSaveLocal();break;//另存本地文件
		case 4:WebOffice.PrintPreview();break;//启用
		case 5:WebOffice.PrintPreviewExit();WebOffice.ShowField();break;//启用
		case 17:WebOffice.SaveEnabled(true);StatusMsg("启用保存");break;//启用保存
		case 18:WebOffice.SaveEnabled(false);StatusMsg("关闭保存");break;//关闭保存
		case 19:WebOffice.PrintEnabled(true);StatusMsg("启用打印");break;//启用打印
		case 20:WebOffice.PrintEnabled(false);StatusMsg("关闭打印");break;//关闭打印
		case 301:WebOffice.HandWriting("255","4");StatusMsg("手写签批");break;//手写签批
		case 302:WebOffice.StopHandWriting();StatusMsg("停止手写签批");break;//停止手写签批
		case 303:WebOffice.TextWriting();StatusMsg("文字签名");break;//文字签名
		case 304:WebOffice.ShapeWriting();StatusMsg("图形签批");break;//图形签批
		case 305:WebOffice.RemoveLastWriting();StatusMsg("取消上一次签批");break;//取消上一次签批
		case 306:WebOffice.ShowWritingUser(false,WebOffice.UserName);StatusMsg("显示签批用户");break;//显示签批用户
		default:;return;  
  }   
}
     
</script>
<!--End以下是多浏览器的事件方法 -->



<!--End 为2015主要方法 -->


</head>
<body onresize="init()"  style="overflow-y:hidden;overflow-x:hidden" onUnload="WebOffice.WebClose()">
<table id="maintable"  cellspacing='0' cellpadding='0' >
 <!-- head -->
 <tr><td colspan="2"  height="61px"><table cellspacing='0' cellpadding='0' cellspacing='0' cellpadding='0'  id="header"><tr ><td ><img src="css/logo.jpg"/></td><td><span>　iWebOffice2015</span> 在线管理中间件示例程序</td></tr></table></td></tr> 
 <tr><td height="34px" class="title" width="80%">
    <span>主题：<input type=text name="Subject1" id="Subject1"   onchange=" document.getElementById('Subject').value = this.value;" value="<%=mSubject %>" class="InputLine2"  onblur="if(this.value.length>20){this.value='请输入主题';StatusMsg('主题不能超过50个字');}"/> </span>
	<span style="margin-left: 50px;">作者：<input type=text onchange=" document.getElementById('Author').value = this.value;" name="Author1"  id="Author1" value="<%=mUserName %>" class="InputLine2" onblur="if(this.value.length>8){this.value='体验用户';StatusMsg('作者不能超过8个字');}" /></span>
 </td>
 <td class="title"><span><a href="#" onclick="SaveDocument()">保存文档</a></span><span><a href="#" onclick="window.opener.location.reload();window.close()">返回列表</a></span></td>
 </tr> 
 <!-- end head -->
 
 <!-- showList -->
 <tr><td id="showtr" colspan="2"  valign="top">
  <table id="functionBox" border="0">
    <tr>
     <td  id="showTD" width="204px" height="30px"  valign="top">
       <table id="functionTable"   cellspacing='4' cellpadding='0'  >    
        <tr  id="disPlayNone"><td height="30px" class="tableFather" >    功能列表&lt;  </td></tr>
         <tr id="handWriting2" class="<%=mDisabled+mWord%>" class="test"><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0'  style="height:30px" cellpadding='0'><tr><td class="titleStyle">签批　　<span>+</span></td></tr></table>
	       <div id="read8"  class="hideDiv">
			 <table id="readT8" width="100%" cellspacing='0' cellpadding='0'><!-- 附加功能示例子菜单 -->
				<tr><td class="dot-size"><a href="#"  onClick="HandWriting();">手写签名</a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.StopHandWriting();">停止签批</a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.TextWriting();">文字签名</a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.ShapeWriting();">图形签名</a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.RemoveLastWriting();">返回上一次</a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.ShowWritingUser(false,WebOffice.UserName);">显示当前用户签批</a></td></tr>
 			 </table><!--END 附加功能示例能子菜单 -->
		  </div>
		  </td></tr>  
        <tr  class="test"><td valign="middle" class="tableFather">
  		  <table class="tableAll" cellspacing='0' style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 文件　　<span>+</span></td></tr></table>
	       <div id="read0"  class="hideDiv" >
				<table id="readT0"   width="100%" cellspacing='0' cellpadding='0'><!-- 文档阅读功能子菜单 -->
					<tr <%=mEditType.equalsIgnoreCase("0")?"class=\"disabled\"":""%>><td class="dot-size"><a href="#" onclick='WebOffice.CreateFile();'>新建文件</a></td></tr>
					<tr <%=mEditType.equalsIgnoreCase("0")?"class=\"disabled\"":""%>><td class="dot-size"><a href="#" onclick="WebOpenLocal();">打开本地文件</a></td></tr>
					<tr><td class="dot-size"><a href="#" onClick="WebOffice.WebSaveLocal();">另存为</a>  <!--true禁止,false启用--></td></tr>
					<tr <%=mEditType.equalsIgnoreCase("0")?"class=\"disabled\"":""%>><td   class="dot-size"><a href="#" onClick="WebOffice.WebPageSetup()">页面设置</a> <!--true显示,false隐藏--></td></tr>
					<tr><td class="dot-size"><a href="#" onClick="WebOffice.WebOpenPrint()">打印文档</a> <!--true显示,false隐藏--></td></tr>
					<tr><td class="dot-size"><a href="#" onClick="alert('当前控件版本为：'+WebOffice.Version());">显示版本</a> <!--true显示,false隐藏--></td></tr>
					<tr><td class="dot-size"><a href="#" onClick="WebOffice.Close()">关闭文档</a> <!--true显示,false隐藏--></td></tr>
				 </table><!--END 文档阅读功能子菜单 -->
		   </div>
		  </td></tr> 
		 <tr class="<%=mDisabled+mWord%>" class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0' style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 插入　　<span>+</span></td></tr></table>
	       <div id="read1"  class="hideDiv">
				       <table id="readT1" width="100%" cellspacing='0' cellpadding='0'><!-- 文档制功能子菜单 -->
					          <tr  class="<%=mDisabled+mWord%>"><td class="dot-size" ><a href="#" <%=mDisabled%>  onClick="WebOffice.WebInsertImage('image','GoldgridLogo.jpg');">插入远程图片</a></td></tr>
					          <tr  class="<%=mDisabled+mWord%>"><td class="dot-size"  ><a href="#" <%=mDisabled%>  onClick="WebGetWordContent();">取Word内容</a></td></tr>
					          <tr  class="<%=mDisabled+mWord%>"><td class="dot-size"  ><a href="#" <%=mDisabled%> onClick="WebSetWordContent();">写Word内容</a></td></tr>
					          <tr  class="<%=mDisabled+mWord%>"><td class="dot-size"><a href="#" <%=mDisabled%>   onClick="WebOffice.WebObject.ActiveDocument.ActiveWindow.ActivePane.View.SeekView=9;">插入页眉</a></td></tr>
					          <tr  class="<%=mDisabled+mWord%>"><td class="dot-size"><a href="#" <%=mDisabled%> onClick="WebOffice.WebPageCode()">插入页码</a></td></tr>
					          <tr  class="<%=mDisabled+mWord%>"><td class="dot-size"><a href="#"  onclick="WebDocumentPageCount();">文档页数</a></td></tr>	
					          <tr  class="<%=mDisabled+mWord%>"><td class="dot-size"><a href="#"  onclick="WebInsertVBA();">VBA套红定稿</a></td></tr>
					    </table><!--END 文档控制功能子菜单 -->
		  </div>
		  </td></tr>
		 
		 <%if(mWord.equalsIgnoreCase("disabled")){ %>
		 
		 <tr  class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0' style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 插入　　<span>+</span></td></tr></table>
	       <div id="read8"  class="hideDiv">
				       <table id="readT8" width="100%" cellspacing='0' cellpadding='0'><!-- 文档制功能子菜单 -->
						<tr  class="<%=mDisabled+mExcel%>"><td class="dot-size"><a href="#"   onClick="WebGetExcelContent();">用Excel求和</a></td></tr>
					       <tr  class="<%=mDisabled+mExcel%>"><td class="dot-size"><a href="#"  onClick="WebSheetsLock();">锁定工作表</a></td></tr>
					    </table><!--END 文档控制功能子菜单 -->
		  </div>
		  </td></tr>		 
		 
		 
		 <%} %>
		 
		 <tr  class="<%=mDisabled+mWord%>" class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0' style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 痕迹　　<span>+</span></td></tr></table>
	       <div id="read2"  class="hideDiv">
				       <table id="readT2" width="100%" cellspacing='0' cellpadding='0'><!-- 文档制功能子菜单 -->
					          <tr  class="<%=mDisabled+mWord%>" style="height:30px"><td class="dot-size"><a href="#" style="height:30px" <%=mDisabled%> onClick="ShowRevision(true)">显示痕迹</a></td></tr>
					          <tr  class="<%=mDisabled+mWord%>" style="height:30px"><td class="dot-size"><a href="#" style="height:30px" <%=mDisabled%> onClick="ShowRevision(false)">隐藏痕迹</a></td></tr>
					          <tr  class="<%=mDisabled+mWord%>" style="height:30px"><td class="dot-size"><a href="#" style="height:30px" <%=mDisabled%> onClick="WebAcceptAllRevisions()">清除痕迹</a></td></tr> 
					    </table><!--END 文档控制功能子菜单 -->
		  </div>
		  </td></tr>		  
		  <tr class="test"><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0'  style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 视图　　<span>+</span></td></tr></table>
	       <div id="read3"  class="hideDiv">
			 <table id="readT3" width="100%" cellspacing='0' cellpadding='0'><!-- 附加功能示例子菜单 -->
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowTitleBar(true)">显示标题栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowTitleBar(false)">隐藏标题栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowMenuBar(true);">显示菜单栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowMenuBar(false);">隐藏菜单栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowToolBars(true)">显示工具栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowToolBars(false)">隐藏工具栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowStatusBar(true)">显示状态栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="WebOffice.ShowStatusBar(false)">隐藏状态栏</a></td></tr>
	          <tr><td class="dot-size"><a href="#"  onclick="FullSize(true)">全屏切换</a></td></tr>
 			 </table><!--END 附加功能示例能子菜单 -->
		  </div>
		  </td>
		  </tr>  
       		 <tr class="<%=mDisabled+mWord%>" class="test"><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0'  style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 权限　　<span>+</span></td></tr></table>
	       <div id="read4"  class="hideDiv">
			 <table id="readT4" width="100%" cellspacing='0' cellpadding='0'><!-- 附加功能示例子菜单 -->
				<tr><td class="dot-size"><a href="#"  onclick="WebOffice.WebSetProtect(true,'123')">保护文档</a></td></tr>
				<tr><td class="dot-size"><a href="#" onclick="WebOffice.WebSetProtect(false,'123')">解除保护</a></td></tr>
				<tr id="enableCopy1"><td class="dot-size"><a href="#" onclick="WebOffice.WebEnableCopy(true)">允许拷贝</a></td></tr>
				<tr id="enableCopy2"><td class="dot-size"><a href="#" onclick="WebOffice.WebEnableCopy(false)">禁止拷贝</a></td></tr>
				<tr id="areaProtect"><td class="dot-size"><a href="#" onclick="WebAreaProtect()">添加区域保护</a></td></tr>
				<tr id="areaUnprotect"><td class="dot-size"><a href="#" onclick="WebAreaUnprotect()">取消区域保护</a></td></tr>
 			 </table><!--END 附加功能示例能子菜单 -->
		  </div>
		  </td></tr>
		   <tr class="<%=mDisabled+mWord%>" class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0' style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 模板　　<span>+</span></td></tr></table>
	       <div id="read5"  class="hideDiv">
				       <table id="readT5" width="100%" cellspacing='0' cellpadding='0'><!-- 文档制功能子菜单 -->
					          <tr  class="<%=mDisabled+mWord%>"><td class="dot-size"><a href="#" <%=mDisabled%> onClick="WebUseTemplate('Temone.doc')">模板套红一</a></td></tr>
					          <tr  class="<%=mDisabled+mWord%>"><td class="dot-size"><a href="#" <%=mDisabled%> onClick="WebUseTemplate('Temtwo.doc')">模板套红二</a></td></tr>
					    </table><!--END 文档控制功能子菜单 -->
		  </div>
		  </td></tr>
		  	        
 		  <tr class="<%=mDisabled+mWord%>" class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0'  style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 书签　　<span>+</span></td></tr></table>
	       <div id="read6"  class="hideDiv">
			 <table id="readT6" width="100%" cellspacing='0' cellpadding='0'><!-- 附加功能示例子菜单 -->
				<tr><td class="dot-size"><a href="#"  onClick="SetBookmarks();">书签填充</a></td></tr>
				<tr id="OpenBookMarks"><td class="dot-size"><a href="#"  onClick="WebOpenBookMarks();">打开书签窗体</a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebAddBookMarks();">添加书签</a></td></tr>
 			    <tr><td class="dot-size"><a href="#"  onClick="WebFindBookMarks();">定位书签</a></td></tr>
 			 <!--    <tr><td class="dot-size"><a href="#"  onClick="WebDelBookMarks();">删除书签</a></td></tr> -->
 			 </table><!--END 附加功能示例能子菜单 -->
		  </div>
		  
		  </td></tr>   
 		  <tr class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0'  style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 皮肤　　<span>+</span></td></tr></table>
	       <div id="read7"  class="hideDiv">
			 <table id="readT7" width="100%" cellspacing='0' cellpadding='0'><!-- 附加功能示例子菜单 -->
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.Skin('purple');">　紫色</a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.Skin('black');">　黑色</a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.Skin('white');">　银色</a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.Skin('blue');">　蓝色</a></td></tr>
 			    <tr><td class="dot-size"><a href="#"  onClick="WebOffice.Skin('yellow');">　金黄色</a></td></tr>
 			 
 			 </table><!--END 附加功能示例能子菜单 -->
		  </div>
		  </td></tr>  
		  
    <tr id="expendFunction" class="<%=mDisabled+mWord%>" class="test" ><td valign="middle" class="tableFather">
		   <table class="tableAll" cellspacing='0'  style="height:30px" cellpadding='0'><tr><td class="titleStyle"> 扩展功能　　<span>+</span></td></tr></table>
	       <div id="read9"  class="hideDiv">
			 <table id="readT9" width="100%" cellspacing='0' cellpadding='0'><!-- 附加功能示例子菜单 -->
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.WebSavePDF();">保存为PDF </a></td></tr>
				<tr><td class="dot-size"><a href="#"  onClick="WebOffice.WebSaveHtml();">保存为本地html</a></td></tr>
 			 	<tr class="<%=mDisabled+mWord+mWPS%>"><td class="dot-size"><a href="#"  onClick="WebRunMacro();">运行宏</a></td></tr>
 			 </table><!--END 附加功能示例能子菜单 -->
		  </div>
		  </td></tr> 
		  <tr><td>&nbsp;</td></tr>     
        		   	<tr>
					<td style="border: 0">&nbsp;
					<form id="iWebOfficeForm"   method="post" action="DocumentSave.jsp" >
					    <input type="hidden" name="RecordID" value="<%=mRecordID%>"/>
					    <input type="hidden" name="Template" value="<%=mTemplate%>"/>
					    <input type="hidden" id="FileType" name="FileType" value="<%=mFileType%>"/>
					    <input type="hidden" name="EditType" value="<%=mEditType%>"/>
					    <input type="hidden" name="HTMLPath" value="<%=mHTMLPath%>"/>
					    <input type="hidden" id="Subject" name="Subject" value="<%=mSubject%>"/>
					    <input type="hidden" id="Author" name="Author" value="<%=mAuthor%>"/> 
					    <input type="hidden" name="FileDate" value="<%=mFileDate%>"/>
                   </form></td>
				  </tr>
       </table>

     </td>
     <td id="activeBox">        
      <table id="activeTable">
        <tr id="handWriting1" class="<%=mDisabled+mWord%>">
     	<td class="handWriting" style="width:8%">手写批注颜色:</font></td>
		  	<td style="width:7%"><select id="PenColor">
		  		<option value="255"  selected="selected">红色</option>
		  		<option value="16711680"  >蓝色</option>
		  		<option value="65535"  >黄色</option>
		  		<option value="0"  >黑色</option>
		  		<option value="32768"  >绿色</option>
		  	</select></td>
     <td class="handWriting" style="width:8%">手写批注笔宽:</td>
		  	<td style="width:7%"><select id="PenWidth">
		  		<option value="1">一线</option>
		  		<option value="2">二线</option>
		  		<option value="3">三线</option>
		  		<option value="4" selected="selected">四线</option>
		  		<option value="5">五线</option>
		  		<option value="6">六线</option>
		  		<option value="7">七线</option>
		  		<option value="8">八线</option>
		  	</select>
	 </td>	 
	 <td style="width:10%"><input type="button" value="手写签批" class="hand2" onclick="HandWriting();"/></td>
	 <td style="width:10%"><input type="button" value="停止签批" class="hand2" onclick="WebOffice.StopHandWriting();"/></td>
	 <td style="width:10%"><input type="button" value="返回上一次" class="hand2" onclick="WebOffice.RemoveLastWriting();"/></td>
	 <td class="handhint" style="width:40%"></>温馨提示:鼠标右健可停止签批!</td>
	</tr>
        <tr>
		<td colspan="8" id="activeTd" >&nbsp;<script src="js/iWebOffice2015.js"></script></td>
	    </tr>
	    <tr>
			<td colspan="6" height="10px" align="left" class="statue">状态：<span id="state"></span></td>
			<td colspan="2" align="right"  style="time">时间：<%=mFileDate%></td>
		</tr>
	   </table>
     </td>
    </tr>
  </table>
 </td></tr>
 <!-- end showList -->
  
 <!-- footer -->
 <tr ><td colspan="2" height="30px"  class="footer"><table><tr><td align="center">江西金格科技股份有限公司 版权所有</td></tr></table></td></tr>
 <!-- end footer --> 
</table>
</body> 
</html>
 <script language="javascript">
 self.moveTo(0,0);
 self.resizeTo(screen.availWidth,screen.availHeight);
 init();
 function init(){
   document.getElementById('WebOffice2015').height =document.documentElement.clientHeight- 160 +"px";
   var functionTableLength = getHeight('showTD')-document.getElementById("functionTable").rows.length*32;
   for(var i =0;i<document.getElementById("functionTable").rows.length-3;i++){
       try{
        var readivLength = document.getElementById("readT"+i).rows.length*30;
      
	    if(readivLength+30 < functionTableLength){
	      document.getElementById('readT'+i).style.height =  readivLength+ 8 + "px";
	      document.getElementById('read'+i).style.height =  readivLength+ 8 + "px";
	    }else{
	        document.getElementById('readT'+i).style.height =  functionTableLength-50 + "px";
	        document.getElementById('read'+i).style.height =  functionTableLength -50 + "px";
	    }
	   }catch(e){
         continue;
        }
    }
    $("tr").remove(".disabled");
  }
  //获取id的高度
  function  getHeight(id){
    return document.getElementById(id).offsetHeight; 
  }
 </script>