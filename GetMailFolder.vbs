
Set obj = CreateObject("Outlook.Application")
Set Eml = obj.CreateItemFromTemplate("\\scflsrvr\�t���[�g�R���g���N�g��\RPA\�����ς��f�����������̗��n����\���ғ�\99�e���v���[�g\�c�ƈ����[��.msg")

Set objMapi = obj.GetNamespace("MAPI")
'Set folder = objMapi.Folders("Fleet_RPA").Folders("��M�g���C").Folders("07PartnersCompassVerifyQuotation")

Set folder = obj.Session.Folders("Fleet_RPA").Folders("������")

Eml.Save
Eml.Move folder

MsgBox folder