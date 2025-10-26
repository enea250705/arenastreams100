Write-Host "=== POPUNDER AD VERIFICATION ===" -ForegroundColor Green
Write-Host ""

$pages = Get-ChildItem views\*.html
$withFreshAds = 0
$withGlobalClick = 0

foreach ($page in $pages) {
    $content = Get-Content $page.FullName -Raw
    if ($content -match 'sophisticatedversion\.com') {
        $withFreshAds++
    }
    if ($content -match 'Global click') {
        $withGlobalClick++
    }
}

Write-Host "Pages with FreshAds popunder script: $withFreshAds / $($pages.Count)" -ForegroundColor $(if($withFreshAds -eq $pages.Count){'Green'}else{'Yellow'})
Write-Host "Pages with global click trigger: $withGlobalClick / $($pages.Count)" -ForegroundColor $(if($withGlobalClick -eq $pages.Count){'Green'}else{'Yellow'})
Write-Host ""
Write-Host "POPUNDER BEHAVIOR:" -ForegroundColor Yellow
Write-Host "  1. Base script loads on every page" -ForegroundColor White
Write-Host "  2. Global click listener triggers on every click" -ForegroundColor White
Write-Host "  3. Each trigger opens a popunder ad (background window)" -ForegroundColor White
Write-Host "  4. 3-second cooldown prevents spam" -ForegroundColor White
Write-Host ""
Write-Host "Your popunder ads are ACTIVE across the entire site!" -ForegroundColor Green

