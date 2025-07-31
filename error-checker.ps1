# Scriptname : 
# Purpose    : 
# Created on : 
# Version    : 
# Helps on   : Serial log error throws a lot of files 
#            : 
# usage      :
#  .\error-checker.ps1 -searchFile .\seriallogtocheck.log -keywordFile .\keywords.txt -outputFile output.txt
# 

param (
    [string]$searchFile,                 # Archivo donde buscar
    [string]$keywordFile,  # Archivo con palabras clave
    [string]$outputFile, # Resultado de búsqueda
    [string]$duplicatedLines = "duplicates.txt" # Líneas duplicadas
)

Clear

# Check if file exist
if (-not (Test-Path $searchFile)) {
    Write-Host " File : '$searchFile' not found." -ForegroundColor Red
    exit
}

# Check if file exist
if (-not (Test-Path $keywordFile)) {
    Write-Host " File : '$keywordFile' not found." -ForegroundColor Red
    exit
}

# Read keywords
$keywords = Get-Content $keywordFile

# clear old files
Remove-Item $outputFile, $duplicatedLines -ErrorAction SilentlyContinue

# search inside the target file
foreach ($word in $keywords) {
    cmd /c "findstr /I /C:`"$word`" `"$searchFile`"" >> $outputFile
}

write-Host " found  : $searchFile"
write-Host " found  : $keywordFile"
Write-Host " Search done. Checking for duplicated lines..." -ForegroundColor Cyan


# Do stuff with the duped lines
$txtLines = Get-Content $outputFile
$duplicatedText = $txtLines | Group-Object | Where-Object { $_.Count -gt 1 } | ForEach-Object { $_.Name }
$duplicatedText | Set-Content $duplicatedLines

$txtLines = Get-Content $outputFile | Select-Object -Unique
$txtLines | Set-Content "no_duplicates.txt"


Write-Host " Found $($duplicatedText.Count) duplicated lines." -ForegroundColor Green
Write-Host " Output     : $outputFile" -ForegroundColor Gray
Write-Host " Duplicates : $duplicatedLines " -ForegroundColor Gray
Write-Host " No Dups    : no_duplicates.txt" -ForegroundColor Gray


