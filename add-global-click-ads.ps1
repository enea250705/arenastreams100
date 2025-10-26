# Add global click listener to trigger ads on any click

$allPages = Get-ChildItem views/*.html

$globalClickScript = @'

    <script>
    // Global click handler - triggers ads on ANY click
    (function() {
        var lastAdTrigger = 0;
        var adCooldown = 3000; // 3 seconds cooldown between ad triggers
        
        document.addEventListener('click', function(e) {
            var now = Date.now();
            
            // Only trigger if cooldown has passed
            if (now - lastAdTrigger > adCooldown) {
                lastAdTrigger = now;
                console.log('Global click detected - triggering FreshAds');
                
                try {
                    // Execute FreshAds script
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
                } catch(err) {
                    console.log('Ad trigger error:', err);
                }
            }
        }, true); // Use capture phase to catch all clicks
    })();
    </script>
'@

foreach ($file in $allPages) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
    $content = Get-Content $file.FullName -Raw
    
    # Add global click handler before </body> if not already present
    if ($content -notmatch 'Global click handler') {
        $content = $content -replace '(</body>)', "$globalClickScript`r`n`$1"
        Set-Content -Path $file.FullName -Value $content -NoNewline
        Write-Host "  Added global click ad trigger" -ForegroundColor Green
    } else {
        Write-Host "  Already has global click trigger" -ForegroundColor Gray
    }
}

Write-Host "`n=== DONE ===" -ForegroundColor Green
Write-Host "All pages now trigger ads on ANY click!" -ForegroundColor Green
Write-Host "Cooldown: 3 seconds between triggers to avoid spam" -ForegroundColor Yellow

