# NAV 2018 Object Splitter

## Problem
Microsoft offers you the PowerShell Cmdlet: 
[Split-NAVApplicationObjectFile](https://docs.microsoft.com/en-us/powershell/module/microsoft.dynamics.nav.model.tools/split-navapplicationobjectfile?view=dynamicsnav-ps-2018)

It will split your object text file and put all of the objects into individual text files named TAB18.txt for exampel. And put all 5600 files in the same folder. This is so 1980's. 

## Solution

This Object Splitter is a modern version that will help you save your objects to GitHub and use GitHub to track and document your changes and even get feedback from your team. 

First of all the splitter puts the files in a folder structure equal to the one you have in the Object designer. Like this:

````
YourProject/
    Table/
    Page/
    Report/
    Codeunit/
    Query/
    XMLport/
````

Exactly as you would expect it. 

Each object type folder is devided into subfolders according to object ranges. Each range is a thousand objects. There are two reasons for this. First GitHub can show a maximum of 1000 files per folder and second it makes easier to navigate. 

Inside each object range folder you will find your text objects named like this. 

````
Table_003_Payment_Terms.al
Codeunit_13_600_OIOUBL_Document_Encode.al
Codeunit_99_000_752_Check_Routing_Lines.al
````

This should make it easy for you to find what you are looking for.

The AL extension alows Visual Studio Code to open the file and show you your code in colors. So nice. And so 2018. 

To learn more about how to install the AL language extension in Visual Studio Code, please read the [Getting Started with AL](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-get-started) in the Microsoft docs. 

## Full Size Example

To illustrate the potential of this tool, I made this GitHub repository that compares all released Cumulative Updates for NAV 2018. The Danish version. 

[Compare of all Released Cumulative Updates for Microsoft Dynamics NAV 2018](https://github.com/finnpedersenkazes/Cumulative-Updates-for-Microsoft-Dynamics-NAV-2018-DK)