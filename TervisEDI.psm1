function Convert-EDIFileCharacterEncodingToASCII {
    param (
        [Parameter(Mandatory)]$SourcePath,
        $DestinationPath
    )
    $Files = Get-ChildItem -Path $SourcePath -File

    $FilePathDirectory = if ($DestinationPath) {
        $DestinationPath
    } else {
        "$SourcePath\Converted"
    }

    New-Item -Path $FilePathDirectory -ItemType Directory -Force | Out-Null

    foreach ($File in $Files) {
        [xml]$XML = $File | Get-Content        

        $XML.EdiPlaceHolder.Line.content | 
        Out-File -FilePath $FilePathDirectory\$($File.Name) -NoNewline -Encoding ascii
        out-
    }
}
