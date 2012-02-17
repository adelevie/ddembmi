VERSION 2.00
Begin Form Form1 
   Caption         =   "MapInfo DDE"
   ClientHeight    =   3855
   ClientLeft      =   2055
   ClientTop       =   1890
   ClientWidth     =   4695
   Height          =   4545
   Icon            =   DDE.FRX:0000
   Left            =   1995
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   ScaleHeight     =   3855
   ScaleWidth      =   4695
   Top             =   1260
   Width           =   4815
   Begin ListBox List1 
      Height          =   3150
      Left            =   120
      TabIndex        =   2
      Top             =   600
      Width           =   4455
   End
   Begin TextBox Text1 
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Text            =   "print ""Hello World!"""
      Top             =   120
      Width           =   3615
   End
   Begin CommandButton bMake 
      Caption         =   "&Send"
      Default         =   -1  'True
      Height          =   375
      Left            =   3840
      TabIndex        =   0
      Top             =   120
      Width           =   735
   End
   Begin Menu mFile 
      Caption         =   "&File"
      Begin Menu mFileAbout 
         Caption         =   "&About..."
      End
      Begin Menu mSep1 
         Caption         =   "-"
      End
      Begin Menu mFileExit 
         Caption         =   "E&xit"
      End
   End
   Begin Menu mnuEdit 
      Caption         =   "&Edit"
      Begin Menu mnuEditRemoveItem 
         Caption         =   "&Remove Item"
      End
   End
End
Option Explicit

Const DEFAULT = 0        ' 0 - Default
Const HOURGLASS = 11     ' 11 - Hourglass

Const NONE = 0         ' 0 - None
Const LINK_SOURCE = 1    ' 1 - Source (forms only)
Const LINK_AUTOMATIC = 1 ' 1 - Automatic (controls only)
Const LINK_MANUAL = 2    ' 2 - Manual (controls only)
Const LINK_NOTIFY = 3    ' 3 - Notify (controls only)

Const Link_Topic_MapInfo = "MapInfo|system"

Sub bMake_Click ()
    ddetalk (Text1.Text)
    List1.AddItem Text1.Text
    DoEvents
End Sub

Sub ddetalk (TalkString As String)
    On Error Resume Next
    
    Screen.MousePointer = HOURGLASS
    
    Text1.LinkMode = NONE
    Text1.LinkTimeout = 50  '5 seconds
    Text1.LinkTopic = Link_Topic_MapInfo
    Text1.LinkMode = LINK_MANUAL
    
    Text1.LinkExecute TalkString
    DoEvents

    Text1.LinkMode = NONE
    Screen.MousePointer = DEFAULT

End Sub

Sub List1_Click ()
    Text1.Text = List1.List(List1.ListIndex)
    DoEvents
End Sub

Sub List1_DblClick ()
    ddetalk (List1.List(List1.ListIndex))
    DoEvents
End Sub

Sub List1_MouseDown (Button As Integer, Shift As Integer, X As Single, Y As Single)
    If (Button And 2) And (List1.ListIndex > -1) Then
	PopupMenu mnuEdit, 6, X + List1.Left + 800, Y + List1.Top - 150
    End If
End Sub

Sub mFileAbout_Click ()
    Dim TheText As String

    TheText = "This program uses DDE to talk to MapInfo." + Chr(13)
    TheText = TheText + "Writen by Michael R. Davis" + Chr(13)
    TheText = TheText + "mdavis@fcc.gov" + Chr(13)
    
    MsgBox TheText, 64, "About MapInfo DDE"
End Sub

Sub mFileExit_Click ()
    Unload Form1
End Sub

Sub mnuEdit_Click ()
    If List1.ListIndex > -1 Then
	mnuEditRemoveItem.Enabled = True
    Else
	mnuEditRemoveItem.Enabled = False
    End If
End Sub

Sub mnuEditRemoveItem_Click ()
    List1.RemoveItem (List1.ListIndex)
End Sub

