# Ask for Appstore ID
$AppID = Read-Host "What is the App Store ID of the App?"
$cc = Read-Host "What is your country code? (gb, se, fr , etc)"

# Get all app information from Apple
$response = Invoke-RestMethod "https://itunes.apple.com/$cc/lookup?id=$AppID" -Method 'GET' -Headers $headers -Body $body -SkipCertificateCheck | `
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