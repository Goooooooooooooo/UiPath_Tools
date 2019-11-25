Dim OlApp
Dim Eml
Dim Arg
Set Arg = WScript.Arguments

Set OlApp = CreateObject("Outlook.Application")


'Set Eml = OlApp.CreateItemFromTemplate("""" & Arg(0) & """")
Set Eml = OlApp.CreateItemFromTemplate(Arg(0))
Download(Eml)

Sub Download(objEml)
	For Each Attch In objEml.Attachments
		Attch.SaveAsFile "AttachFolder" & "\" & Attch.FileName
	Next
End Sub