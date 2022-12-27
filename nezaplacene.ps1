$csv = Import-Csv -Path ".\seznam.csv" -Header @(1..13) | Select-Object -skip 1 
$name = $csv | foreach { $_.5 } | Select-Object -Unique 
$i = 0


while ($i -lt $name.Count) {
    "   "
    $table = $csv | Where-Object { $_.5 -Match $name[$i] }
    $table | ft
    $name[$i]
    "Celkem   " + ($table.8 | Measure-Object -Sum).Sum
    $i++
}

