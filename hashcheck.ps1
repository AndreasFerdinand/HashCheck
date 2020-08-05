param(
[switch]$generatehash,
[string]$hashfile,
[string]$hashdir
)

$Hashstorefile = $hashfile

if ( $generatehash -eq $true )
{
    Write-Host "Generating hash-file $Hashstorefile for directory $hashdir"

    $Hashstore = dir $hashdir -Recurs | Get-FileHash | ConvertTo-Csv

    $Hashstore | Out-file $Hashstorefile

    exit
}
################################


[int]$countdifffiles = 0
[int]$countmissingfiles = 0

Write-Host "Checking files agianst hash-file $Hashstorefile"
Write-Host "---------------------------------------------"

$hashtab = Get-Content $Hashstorefile | ConvertFrom-Csv 

ForEach ($oldhash in $hashtab)
{
    $filepath = $oldhash.Path

    if ( Test-Path $oldhash.Path )
    {
        $newhash = Get-FileHash $oldhash.Path

        if ( $newhash.Hash -ne $oldhash.hash  )
        {
            write-host "Different file: $filepath" -ForegroundColor "Red"
			
			$countdifffiles = $countdifffiles + 1
        }
    }
    else
    {
        write-host "Missing file: $filepath" -ForegroundColor "Red"
		
		$countmissingfiles = $countmissingfiles + 1
    }
}

Write-Host "---------------------------------------------"
Write-Host "Different files count: $countdifffiles"
Write-Host "Missing files count: $countmissingfiles"