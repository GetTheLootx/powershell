$dir = (Get-Location).Path

Get-ChildItem -Path $dir -Filter *.asd.txt | ForEach-Object {
    $newName = $_.Name -replace " ", "_"
    Rename-Item $_.FullName -NewName $newName
}