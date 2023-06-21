$sourceFolder = "C:\Path\to\source\folder"
$destinationFolder = "C:\Path\to\destination\folder"
$daysThreshold = 30

# Get files older than the specified number of days
$files = Get-ChildItem -Path $sourceFolder -Recurse | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$daysThreshold) }

foreach ($file in $files) {
    # Get the relative path of the file, preserving the subfolder structure
    $relativePath = $file.FullName.Substring($sourceFolder.Length)
    $destinationPath = Join-Path -Path $destinationFolder -ChildPath $relativePath

    # Create the destination folder if it doesn't exist
    $destinationFileDir = Split-Path -Path $destinationPath -Parent
    if (!(Test-Path -Path $destinationFileDir)) {
        New-Item -ItemType Directory -Path $destinationFileDir | Out-Null
    }

    # Move the file to the destination folder
    Move-Item -Path $file.FullName -Destination $destinationPath
}