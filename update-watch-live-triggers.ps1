# Update ad triggers to specifically target Watch Live buttons
$sportPages = @("football", "basketball", "tennis", "ufc", "rugby", "baseball", "american-football", "cricket", "hockey", "motor-sports", "homepage")

foreach ($page in $sportPages) {
    $filePath = "views\$page.html"
    if (Test-Path $filePath) {
        Write-Host "Processing: $page.html" -ForegroundColor Yellow
        $content = Get-Content $filePath -Raw
        
        # Update the ad trigger function to be more specific
        $oldTrigger = @'
    // Add click listeners to all match links
    document.addEventListener('DOMContentLoaded', function() {
        var matchLinks = document.querySelectorAll('a[href*="/match/"]');
        matchLinks.forEach(function(link) {
            link.addEventListener('click', function(e) {
                triggerFreshAd();
            });
        });
    });
'@

        $newTrigger = @'
    // Add click listeners to all match links and Watch Live buttons
    document.addEventListener('DOMContentLoaded', function() {
        // Target all match links
        var matchLinks = document.querySelectorAll('a[href*="/match/"]');
        matchLinks.forEach(function(link) {
            link.addEventListener('click', function(e) {
                console.log('Match link clicked - triggering ad');
                triggerFreshAd();
            });
        });

        // Also target buttons/links with "Watch Live" text
        setTimeout(function() {
            var watchButtons = document.querySelectorAll('a[href*="/match/"], button[onclick*="match"]');
            watchButtons.forEach(function(btn) {
                if (!btn.hasAttribute('data-ad-attached')) {
                    btn.setAttribute('data-ad-attached', 'true');
                    btn.addEventListener('click', function(e) {
                        console.log('Watch Live button clicked - triggering ad');
                        triggerFreshAd();
                    });
                }
            });
        }, 1000);
    });
'@

        if ($content -match [regex]::Escape($oldTrigger)) {
            $content = $content -replace [regex]::Escape($oldTrigger), $newTrigger
            Set-Content -Path $filePath -Value $content -NoNewline
            Write-Host "  Updated ad triggers for Watch Live buttons" -ForegroundColor Green
        } else {
            Write-Host "  Skipped (pattern not found)" -ForegroundColor Gray
        }
    }
}

Write-Host "`nDone! Watch Live button triggers updated." -ForegroundColor Green

