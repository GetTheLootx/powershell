$location = (Get-Location).Path
$Files = Get-ChildItem $location -Filter *.asd.txt -Recurse 

$Filecount = 0

$ObjectCollectionArray = @()

#Fist parse and collect each row in an array.. While keeping the datetime information from filename. 

foreach ($File in $Files) {

    $Filecount++
    Write-Host $Filecount 

    $DateTime = $File.fullname.split(" ").split(".")[1]

    $Content = Get-Content $File.FullName

    foreach ($Row in $Content) {

        $Split = $Row.Split("`t")

        if ($Split[0] -ne 'Wavelength') {

            $Object = [PSCustomObject]@{
                'Datetime'   = $DateTime
                'Number'     = $Split[0]
                'Wavelength' = $Split[1]
            }

            $ObjectCollectionArray += $Object
        }
    }    
}


#Match by number and create a new object with relation to the number and different datetime. 

$GroupedCollection = @()
$Grouped = $ObjectCollectionArray | Group-Object number

foreach ($GroupedNumber in $Grouped) {
    $NumberObject = [PSCustomObject]@{
        'Number' = $GroupedNumber.Name
    }


    foreach ($Occurance in $GroupedNumber.Group) {
        $NumberObject | Add-Member -NotePropertyName $Occurance.Datetime -NotePropertyValue $Occurance.wavelength
    }

    $GroupedCollection += $NumberObject

}

$GroupedCollection | Export-Csv -Path ".\output.csv" -NoClobber -NoTypeInformation