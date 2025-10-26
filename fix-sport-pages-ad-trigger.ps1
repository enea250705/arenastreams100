# Fix triggerFreshAd function in all sport pages

$sportPages = @("football", "basketball", "tennis", "ufc", "rugby", "baseball", "american-football", "cricket", "hockey", "motor-sports", "homepage")

$oldFunction = @'
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
'@

$newFunction = @'
    function triggerFreshAd() {
        try {
            console.log('Triggering FreshAds on click...');
            // Execute FreshAds script inline (triggers popunder)
            (function(qlhqjl){
                var d = document,
                    s = d.createElement('script'),
                    l = d.scripts[d.scripts.length - 1];
                s.settings = qlhqjl || {};
                s.src = "//sophisticatedversion.com/cGDW9S6/b.2/5/l/SaWhQT9/NwjIYD2uOcDFQ/4UMAyT0w2jNpj/YL4/N/DjgZ0K";
                s.async = true;
                s.referrerPolicy = 'no-referrer-when-downgrade';
                l.parentNode.insertBefore(s, l);
            })({});
        } catch(e) {
            console.log('Ad error:', e);
        }
    }
'@

foreach ($page in $sportPages) {
    $filePath = "views\$page.html"
    if (Test-Path $filePath) {
        Write-Host "Processing: $page.html" -ForegroundColor Yellow
        $content = Get-Content $filePath -Raw
        
        if ($content -match [regex]::Escape($oldFunction)) {
            $content = $content -replace [regex]::Escape($oldFunction), $newFunction
            Set-Content -Path $filePath -Value $content -NoNewline
            Write-Host "  Fixed triggerFreshAd function" -ForegroundColor Green
        } else {
            Write-Host "  Pattern not found (may already be fixed)" -ForegroundColor Gray
        }
    }
}

Write-Host "`nDone! All ad trigger functions fixed." -ForegroundColor Green

