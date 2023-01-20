$destination = "G:\Photoshop\Lilliestudio\Galerie"
$folder = "Vybrane"

Get-ChildItem -Path $destination -Filter *.JPG | ForEach-Object {
    $filename = $_.Name
    $num = $filename.Split('_')[1].Split('.')[0]
    $sort = @(9773, 9767, 9745, 9754, 9689, 9683, 9618, 9604, 9600, 9598, 9590, 9588, 9505, 9583, 9584, 9579, 9566, 9535, 9529, 9518, 9507, 9502)

    if ($sort -eq $num) {
        Move-Item -Path $_.FullName -Destination "$destination\$folder"
        Write-Output "Moving file $filename with number $num to $destination\$folder."

    }
}
