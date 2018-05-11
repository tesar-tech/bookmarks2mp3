$pathToBookmarksFile ="$env:LOCALAPPDATA\Vivaldi\User Data\Default\Bookmarks"
$bookmarkFolder = "MusicToDownload"
$outputFolder = "mp3_files/"

$json = (Get-Content $pathToBookmarksFile -Raw) | ConvertFrom-Json
$folderWithLinksToDownload = $json.roots.bookmark_bar.children | Where-Object { $_.name -eq $bookmarkFolder }  
$urls =  $folderWithLinksToDownload.children | Select-Object {$_.url} 

Foreach ($url in $urls) 
{
    youtube-dl.exe --download-archive downloaded.txt --output "$outputFolder%(title)s.%(ext)s" --extract-audio --audio-format mp3 $url.'$_.url'   
}
