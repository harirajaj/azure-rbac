$editedFiles = git ls-tree --full-tree -r --name-only HEAD
Write-Output $editedFiles
$resultArray = @() 
Foreach ($file in $editedFiles) {
           if ($file -like "roleDefnitions/*") {
           $filePath = "$(Build.SourcesDirectory)\$file"
           $resultArray += $filePath
           }
       }
Write-Output "The following role definitions have been created / changed:"
Write-Output "$resultArray"

#Create a useable pipeline variable array to string that will be used in powershell script
$psStringResult = @()
$resultArray | ForEach-Object {
    $psStringResult += ('"' + $_.Split(',') + '"')
}
$psStringResult = "@(" + ($psStringResult -join ',') + ")"

#Set VSO variable to use in powershell script as input
Write-Output "##vso[task.setvariable variable=roledefinitions;]$psStringResult"

Write-Output "Convert array to psString:"
Write-Output $psStringResult
