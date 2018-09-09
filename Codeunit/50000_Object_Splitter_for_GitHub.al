OBJECT Codeunit 50000 Object Splitter for GitHub
{
  OBJECT-PROPERTIES
  {
    Date=09/09/18;
    Time=22:27:29;
    Modified=Yes;
    Version List=FPE;
  }
  PROPERTIES
  {
    OnRun=BEGIN
            ReadSourceFile('E:\NAV2018\NAV_Object_Splitter\AllObj.txt','E:\NAV2018\NAV_Object_Splitter\');
          END;

  }
  CODE
  {
    VAR
      SourceInStream@1104000002 : InStream;
      SourceFile@1104000003 : File;
      TextBuffer@1104000004 : Text;
      TargetFile@1104000000 : File;
      TargetOutStream@1104000001 : OutStream;

    LOCAL PROCEDURE ReadSourceFile@1104000000(SourceFilePath@1104000002 : Text;TargetFolderPath@1104000001 : Text);
    VAR
      TargetFilePath@1104000000 : Text;
      TargetFileIsOpen@1104000003 : Boolean;
    BEGIN
      TargetFileIsOpen := FALSE;
      SourceFile.OPEN(SourceFilePath);
      SourceFile.CREATEINSTREAM(SourceInStream);
      WHILE NOT SourceInStream.EOS DO BEGIN
        SourceInStream.READTEXT(TextBuffer);
        IF ObjectFound(TextBuffer) THEN BEGIN
          TargetFilePath := ObjectFileName(TextBuffer);
          CreateDirectory(TargetFolderPath + ObjectTypeDirectory(TextBuffer),FALSE);
          IF TargetFileIsOpen THEN BEGIN
            TargetFile.CLOSE;
            TargetFileIsOpen := FALSE;
          END;
          TargetFile.CREATE(TargetFolderPath + TargetFilePath);
          TargetFile.CREATEOUTSTREAM(TargetOutStream);
          TargetFileIsOpen := TRUE;
        END;
        TargetOutStream.WRITETEXT(TextBuffer);
        TargetOutStream.WRITETEXT;
      END;
      SourceFile.CLOSE;
      IF TargetFileIsOpen THEN
        TargetFile.CLOSE;
      MESSAGE('End of file reached');
    END;

    LOCAL PROCEDURE ObjectFileName@1104000005(Text@1104000000 : Text) : Text;
    VAR
      ObjectTypeText@1104000001 : Text;
      ObjectIdText@1104000002 : Text;
      ObjectNameText@1104000003 : Text;
    BEGIN
      // OBJECT Table 3 Payment Terms
      // Table\3_Payment_Terms.al
      Text := StripFirstElement(Text);
      ObjectTypeText := CopyFirstElement(Text);
      Text := StripFirstElement(Text);
      ObjectIdText := CopyFirstElement(Text);
      Text := StripFirstElement(Text);
      ObjectNameText := ObjectName2FileName(Text);
      EXIT(ObjectTypeText + '\' + ObjectIdText + '_' + ObjectNameText + '.al');
    END;

    LOCAL PROCEDURE ObjectTypeDirectory@1104000003(Text@1104000000 : Text) : Text;
    VAR
      ObjectTypeText@1104000001 : Text;
      ObjectIdText@1104000002 : Text;
      ObjectNameText@1104000003 : Text;
    BEGIN
      // OBJECT Table 3 Payment Terms
      // Tables\
      Text := StripFirstElement(Text);
      EXIT(CopyFirstElement(Text) + '\');
    END;

    LOCAL PROCEDURE ObjectFound@1104000001(VAR Text@1104000000 : Text) : Boolean;
    BEGIN
      EXIT(COPYSTR(Text,1,7) = 'OBJECT ');
    END;

    LOCAL PROCEDURE CopyFirstElement@1104000007(Text@1104000000 : Text) : Text;
    BEGIN
      EXIT(COPYSTR(Text,1,SpacePosition(Text) - 1));
    END;

    LOCAL PROCEDURE StripFirstElement@1104000008(Text@1104000000 : Text) : Text;
    BEGIN
      EXIT(COPYSTR(Text,SpacePosition(Text) + 1));
    END;

    LOCAL PROCEDURE SpacePosition@1104000006(Text@1104000000 : Text) : Integer;
    BEGIN
      EXIT(STRPOS(Text,' '))
    END;

    LOCAL PROCEDURE ObjectName2FileName@1104000002(Text@1104000000 : Text) FileName : Text;
    BEGIN
      FileName := '';
      WHILE STRLEN(Text) > 0 DO BEGIN
        IF Text[1] IN ['a'..'z','A'..'Z'] THEN
          FileName := FileName + COPYSTR(Text,1,1)
        ELSE
          FileName := FileName + '_';
        Text := COPYSTR(Text,2);
      END;
      EXIT(FileName);
    END;

    LOCAL PROCEDURE CreateDirectory@1000000027(path@1000000000 : Text;showconfirmation@1000000003 : Boolean) : Boolean;
    VAR
      SystemIODirectory@1000000001 : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.Directory";
      SystemIODirectoryInfo@1000000002 : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.DirectoryInfo";
      DirectoryCreatedMsg@1104000000 : TextConst 'ENU=Directory %1 created.';
    BEGIN
      IF NOT SystemIODirectory.Exists(path) THEN BEGIN
        SystemIODirectoryInfo := SystemIODirectory.CreateDirectory(path);
        IF showconfirmation THEN BEGIN
          MESSAGE(STRSUBSTNO(DirectoryCreatedMsg,SystemIODirectoryInfo.Name));
        END;
      END;
    END;

    LOCAL PROCEDURE DeleteDirectory@1000000023(path@1000000000 : Text;recursive@1000000004 : Boolean;showconfirmation@1000000003 : Boolean);
    VAR
      SystemIODirectory@1000000002 : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.Directory";
      SystemIODirectoryInfo@1000000001 : DotNet "'mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'.System.IO.DirectoryInfo";
      DirectoryDeletededMsg@1104000000 : TextConst 'ENU=Directory deleted.';
    BEGIN
      IF SystemIODirectory.Exists(path) THEN BEGIN
        SystemIODirectory.Delete(path, recursive);
        IF showconfirmation THEN BEGIN
          IF NOT SystemIODirectory.Exists(path) THEN
            MESSAGE(DirectoryDeletededMsg);
        END;
      END;
    END;

    BEGIN
    END.
  }
}
