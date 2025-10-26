$content = Get-Content views\match.html -Raw

# Find and replace the server switching code to add ad trigger
$oldCode = "if (e.target.classList.contains('player-tab')) {"

$adTriggerCode = @"
if (e.target.classList.contains('player-tab')) {
                      // Trigger ad on server switch
                      console.log('Server button clicked - triggering ad');
                      try { triggerAd(); } catch(err) { console.log('Ad error:', err); }
                      
"@

$content = $content -replace [regex]::Escape($oldCode), $adTriggerCode
Set-Content -Path views\match.html -Value $content -NoNewline
Write-Host "Added ad trigger to server switching!" -ForegroundColor Green
