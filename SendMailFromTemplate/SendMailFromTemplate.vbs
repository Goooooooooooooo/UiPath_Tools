Const PR_ATTACH_MIME_TAG = "http://schemas.microsoft.com/mapi/proptag/0x370E001E"
Const PR_ATTACH_CONTENT_ID = "http://schemas.microsoft.com/mapi/proptag/0x3712001E"
Const PR_ATTACHMENT_HIDDEN = "http://schemas.microsoft.com/mapi/proptag/0x7FFE000B"
Const PR_SMTP_ADDRESS = "http://schemas.microsoft.com/mapi/proptag/0x39FE001E"

Dim OlApp
Dim Eml
Dim Arg
Dim Names
Dim SenderName
Set Arg = WScript.Arguments

'Argumens Named List
Set Names = Arg.Named

Set OlApp = CreateObject("Outlook.Application")
Set Eml = OlApp.CreateItemFromTemplate(Arg(0))
Eml.BodyFormat = 2
Eml.SentOnBehalfOfName = ""


SenderName = "JAPANOPCM2ChukaiTeaminclTemp.CAPITAL@smasfleet.co.jp"

Dim Recips
Dim Recip
Dim Pa
Dim StrAddress

Set recips = Eml.Recipients

For Each Recip In Recips
    Set Pa = Recip.PropertyAccessor
    'WScript.echo Recip.Name & " SMTP=" & Pa.GetProperty(PR_SMTP_ADDRESS)
    StrAddress = Pa.GetProperty(PR_SMTP_ADDRESS)
    
    If InStrRev(StrAddress,"@smflc.co.jp") = 0 AND InStrRev(StrAddress, "@smasfleet.co.jp") = 0 Then
    	Eml.To = SenderName
		Eml.CC = SenderName
		Eml.HtmlBody = "<p>社外メールアドレス（ " + StrAddress + " ）がふくまれたため、強制的に配信先を( SenderName )に変更しています</p>" + Eml.HtmlBody
    	Exit For
    End If
Next


'Set Subject,Body
ReplaceMailMessage()


'添付ファイル
If Names.Exists("Att") Then
	Atts = Split(Arg.Named.Item("Att"),",")
    for each a in Atts
        Eml.Attachments.Add(a)
    next
End If

If Names.Exists("img") Then
	
	Dim oPA
	Dim realAttachment
	MsgBox Arg.Named.Item("img")
    Set realAttachment = Eml.Attachments.Add(Arg.Named.Item("img"))
    Set oPA = realAttachment.PropertyAccessor
	MsgBox "1"
    oPA.SetProperty PR_ATTACH_MIME_TAG, "image/jpeg"
    oPA.SetProperty PR_ATTACH_CONTENT_ID, "myident"
	MsgBox "2"
    Eml.HTMLBody = Eml.HTMLBody & "<img src=cid:myident />"
End If

'Set To,CC テスト用
If Names.Exists("To") Then
    Eml.To = Arg.Named.Item("To")
End If

If Names.Exists("Cc") Then
    Eml.CC = Arg.Named.Item("Cc")
End If



Eml.Send()



'///////////////////////////
'/////////関数
'///////////////////////////
Sub ReplaceMailMessage()
  Dim Keywords
  Keywords = Array("Att", "To", "Cc")
  
  For Each parName In Names
      'MsgBox "Name:" & parName & "  Value:" & Arg.Named.Item(parName)
      If Not strExists(Keywords, parName) Then
          Eml.Subject = Replace(Eml.Subject, parName, Arg.Named.Item(parName))
          Eml.HtmlBody = Replace(Eml.HtmlBody, parName, Arg.Named.Item(parName))
      End IF
  Next
End Sub


Function strExists(arr,obj)
  strExists = False
  For Each val in arr
      If val = obj Then
          strExists = True
          Exit For
      End If
  Next
End Function

