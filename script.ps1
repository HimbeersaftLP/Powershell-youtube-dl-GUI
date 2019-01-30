Add-Type -Assembly System.Windows.Forms

$form = New-Object System.Windows.Forms.Form
$panel = New-Object System.Windows.Forms.FlowLayoutPanel
$panel.AutoSize = $True
$panel.Height = 1

$form.Text = "youtube-dl GUI"

$urlLabel = New-Object System.Windows.Forms.Label
$urlLabel.Text = "URL:"

$urlInput = New-Object System.Windows.Forms.TextBox
$urlInput.Size = New-Object System.Drawing.Size -ArgumentList 197

$searchLabel = New-Object System.Windows.Forms.Label
$searchLabel.Text = "Search:"

$searchInput = New-Object System.Windows.Forms.TextBox
$searchInput.Size = New-Object System.Drawing.Size -ArgumentList 197

$submitBtn = New-Object System.Windows.Forms.Button
$submitBtn.Text = "Ok"

$submitBtn.Add_Click({
    $form.Close()
    $url = $urlInput.Text
    $search = $searchInput.Text

    if ($url -ne "") {
        Write-Host "Downloading from URL: $url" | Write-Host
        $ErrorActionPreference = 'SilentlyContinue'
        youtube-dl "$url" | Write-Host
        $ErrorActionPreference = 'Continue'
    } elseif ($search -ne "") {
        Write-Host "Searching for: $search" | Write-Host
        $ErrorActionPreference = 'SilentlyContinue'
        youtube-dl "ytsearch:$search" | Write-Host
        $ErrorActionPreference = 'Continue'
    } else {
        Write-Host "Empty"
    }
})

$form.Controls.Add($panel)

$panel.Controls.Add($urlLabel)
$panel.Controls.Add($urlInput)
$panel.Controls.Add($searchLabel)
$panel.Controls.Add($searchInput)
$panel.Controls.Add($submitBtn)

$form.AcceptButton = $submitBtn

$Form.AutoSize = $True
$Form.AutoSizeMode = "GrowAndShrink"
$form.ShowDialog()
