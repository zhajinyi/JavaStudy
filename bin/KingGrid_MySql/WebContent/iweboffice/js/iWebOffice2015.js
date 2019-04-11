var str = '';
var copyright = "金格科技iWebOffice2015智能文档中间件[演示版];V5.0S0xGAAEAAAAAAAAAEAAAAHABAACAAQAALAAAAO98naKRJ/x1wD47iJF5G4zPGELwHDAiSU1UFfkGHerydasPoOUL5vcnQXV22z1X3+JeME0bL5Epd8WmfHOKZR4oK4IuEoUjDMjjvtsoPgvwmtD3weIwWlaOqb7JoAVQj+oorgBBbc2CuttNj0VW/axaJc9ZSGZoHCSw5gAIYq6fYeMbrXil+w3FjTKB3HP37kd75BB4762kXrN8VNnQ9yeSkrpHrJOT5T1rJuY37tc57Aam3Mnw8XVFNtoBuJi/CPXIvPQGbbaw9EOnPEtrsY8q2PW7hUkHqvQKKdXVBSZ7+g5v5USWbAq9IbYMuwqtFior5gNR9vSohnRT/4ayfrrtYfLh6SflvjP8NcDPv/xOPXV3ahq3i6Sxa4GaZwDp+ZUXiWJQa2MAtq4og+i0L5wLt4tP48AlC0Sl67/J9ct9XJ3I77Moj6/53xrB+KH4WRGVqbeqFqGdXZIraWuWy/CJ+iZlxkz/puoy9ZYwoIAE80nelMPVx6qhM6suqdBqUuGbvq1AP1nf75tR1C+Bels=";
str += '<object id="WebOffice2015" ';

str += ' width="100%"';
str += ' height="100%"';

if ((window.ActiveXObject!=undefined) || (window.ActiveXObject!=null) ||"ActiveXObject" in window)
{
	str += ' CLASSID="CLSID:D89F482C-5045-4DB5-8C53-D2C9EE71D025"  codebase="iWebOffice2015.cab#version=12,2,0,382"';
	str += '>';
	str += '<param name="Copyright" value="' + copyright + '">';
}
else
{
	str += ' progid="Kinggrid.iWebOffice"';
	str += ' type="application/iwebplugin"';
	str += ' OnCommand="OnCommand"';
	str += ' OnReady="OnReady"';
	str += ' OnOLECommand="OnOLECommand"';
	str += ' OnExecuteScripted="OnExecuteScripted"';
	str += ' OnQuit="OnQuit"';
	str += ' OnSendStart="OnSendStart"';
	str += ' OnSending="OnSending"';
	str += ' OnSendEnd="OnSendEnd"';
	str += ' OnRecvStart="OnRecvStart"';
	str += ' OnRecving="OnRecving"';
	str += ' OnRecvEnd="OnRecvEnd"';
	str += ' OnRightClickedWhenAnnotate="OnRightClickedWhenAnnotate"';
	str += ' OnFullSizeBefore="OnFullSizeBefore"';
	str += ' OnFullSizeAfter="OnFullSizeAfter"';	
	str += ' Copyright="' + copyright + '"';
	str += '>';
}
str += '</object>';
document.write(str); 