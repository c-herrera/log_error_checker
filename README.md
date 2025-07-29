## log_error_checker

![Static Badge](https://img.shields.io/badge/script-blue)

![Static Badge](https://img.shields.io/badge/powershell-blue?style=for-the-badge&logo=gnubash&labelColor=000000)
### little script to filter common error messages from serial output

Written for system testing, not the real one I had before but a more lighter version, just a fun project from my last job
Usage is easy 
* Copy the log serial file from SUT to your PC
* Copy the script and keywords file to the same folder
* Open a terminal or powershelll windows with permisions to run scripts
* type in terminal :   .\error-checker.ps1 -searchFile .\seriallogtocheck.log -keywordFile .\keywords.txt -outputFile output.txt
* Wait and check your folder with the results

  



