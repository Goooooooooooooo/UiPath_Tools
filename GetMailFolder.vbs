
Set obj = CreateObject("Outlook.Application")
Set Eml = obj.CreateItemFromTemplate("\\scflsrvr\フリートコントラクト部\RPA\未名変お伺い書発送時の竜馬入力\実稼動\99テンプレート\営業宛メール.msg")

Set objMapi = obj.GetNamespace("MAPI")
'Set folder = objMapi.Folders("Fleet_RPA").Folders("受信トレイ").Folders("07PartnersCompassVerifyQuotation")

Set folder = obj.Session.Folders("Fleet_RPA").Folders("下書き")

Eml.Save
Eml.Move folder

MsgBox folder