$data = Import-csv "./odpisy.csv" -Header @(1..11) | Select-Object -skip 1

$myObject = [PSCustomObject] @{
    Name    = $data.10
    Surname = $data.11
    cash    = $data.8
}

$name = $myObject.Name | select -Unique
$celkem = ($myObject.Cash | Measure-Object -Sum).Sum
$limit = ($name | Measure-Object).Count
$i = 0
$sum = 0

while ($i -lt $limit) {
    foreach ($zakaznik in $data) {
        if ($name[$i] -eq $zakaznik.10) {
            $klient = $name[$i]
            foreach ($total in $zakaznik.8) {
                $sum += ($total | Measure-Object -Sum).Sum

            }
        }
    }
    $i++ 
    $klient + "         " + $sum 
    Clear-Variable sum
    
}
"celkem" + "  " + $celkem
