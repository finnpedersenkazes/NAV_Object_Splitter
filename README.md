# NAV 2018 Object Splitter

## Problem
Microsoft offers you the PowerShell Cmdlet: 
Split-NAVApplicationObjectFile

https://docs.microsoft.com/en-us/powershell/module/microsoft.dynamics.nav.model.tools/split-navapplicationobjectfile?view=dynamicsnav-ps-2018

It will split your object text file and put all of the objects into individual text files named TAB18.txt for exampel. This is so 1980's. 

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

Inside each folder you will find your text objects named like this. 

````
3_Payment_Terms.al
5_Finance_Charge_Terms.al
15_G_L_Account.al
````

This should make it easy for you to find what you are looking for.

The AL extension alows Visual Studio Code to open the file and show you your code in colors. So nice. And so 2018. 

