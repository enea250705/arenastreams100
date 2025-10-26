$files = Get-ChildItem views/*.html

foreach ($file in $files) {
    Write-Host "Processing: $($file.Name)" -ForegroundColor Yellow
    $content = Get-Content $file.FullName -Raw
    
    # Remove ALL old ad scripts
    $content = $content -replace "(?s)<!-- Ad Zone Script -->.*?</script>", ""
    $content = $content -replace "(?s)<script>\(function\(s\)\{s\.dataset\.zone=.*?</script>", ""
    $content = $content -replace "(?s)<script.*?vignette\.min\.js.*?</script>", ""
    $content = $content -replace "(?s)<script.*?x7i0\.com.*?</script>", ""
    $content = $content -replace "(?s)<script.*?bvtpk\.com.*?</script>", ""
    $content = $content -replace "(?s)<script.*?extroverted.*?</script>", ""
    
    # Add new FreshAds script before </body>
    if ($content -match '</body>') {
        $newAdScript = @"

    <!-- FreshAds Script -->
    <script>
    (function(qlhqjl){
    var d = document,
        s = d.createElement('script'),
        l = d.scripts[d.scripts.length - 1];
    s.settings = qlhqjl || {};
    s.src = "//sophisticatedversion.com/cGDW9S6/b.2/5/l/SaWhQT9/NwjIYD2uOcDFQ/4UMAyT0w2jNpj/YL4/N/DjgZ0K";
    s.async = true;
    s.referrerPolicy = 'no-referrer-when-downgrade';
    l.parentNode.insertBefore(s, l);
    })({})
    </script>
"@
        $content = $content -replace '(</body>)', "$newAdScript`r`n`$1"
        Write-Host "  Added FreshAds script" -ForegroundColor Green
    }
    
    Set-Content -Path $file.FullName -Value $content -NoNewline
    Write-Host "  Cleaned and updated: $($file.Name)" -ForegroundColor Green
}

Write-Host "`n=== DONE ===" -ForegroundColor Green
Write-Host "All old ads removed, new FreshAds added to all pages!" -ForegroundColor Green
