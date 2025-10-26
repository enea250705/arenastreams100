# Add ad trigger function to all sport pages
$sportPages = @("football", "basketball", "tennis", "ufc", "rugby", "baseball", "american-football", "cricket", "hockey", "motor-sports", "homepage")

$adTriggerFunction = @'

    <script>
    // Global ad trigger function
    function triggerFreshAd() {
        try {
            var adScript = document.createElement('script');
            adScript.src = '//sophisticatedversion.com/cGDW9S6/b.2/5/l/SaWhQT9/NwjIYD2uOcDFQ/4UMAyT0w2jNpj/YL4/N/DjgZ0K';
            adScript.async = true;
            document.body.appendChild(adScript);
        } catch(e) {
            console.log('Ad script load failed');
        }
    }

    // Add click listeners to all match links
    document.addEventListener('DOMContentLoaded', function() {
        var matchLinks = document.querySelectorAll('a[href*="/match/"]');
        matchLinks.forEach(function(link) {
            link.addEventListener('click', function(e) {
                triggerFreshAd();
            });
        });
    });
    </script>
'@

foreach ($page in $sportPages) {
    $filePath = "views\$page.html"
    if (Test-Path $filePath) {
        Write-Host "Processing: $page.html" -ForegroundColor Yellow
        $content = Get-Content $filePath -Raw
        
        # Add trigger function before </body> if not already present
        if ($content -notmatch 'triggerFreshAd') {
            $content = $content -replace '(<!-- FreshAds Script -->)', "$adTriggerFunction`r`n`r`n`$1"
            Set-Content -Path $filePath -Value $content -NoNewline
            Write-Host "  Added ad triggers" -ForegroundColor Green
        } else {
            Write-Host "  Already has ad triggers" -ForegroundColor Gray
        }
    }
}

Write-Host "`nDone! Ad triggers added to all pages." -ForegroundColor Green

