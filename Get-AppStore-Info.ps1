# Ask for Appstore ID
$AppID = Read-Host "What is the AppStore ID of the App?"

# Get all app information from Apple
$response = Invoke-RestMethod "https://itunes.apple.com/gb/lookup?id=$AppID" -Method 'GET' -Headers $headers -Body $body -SkipCertificateCheck | `
    Convertto-Json | `
    ConvertFrom-Json | `
    Select-Object -ExpandProperty "results"

# Create the table for output
$AppInfo = 
[pscustomobject]@{
        "App Name" = $response.trackName
        "BundleID" = $response.bundleID
        "Version" = $response.version
        "Minimum OS Version" = $response.minimumOsVersion
        "Price" = $response.formattedPrice
}

# Show the table
$AppInfo