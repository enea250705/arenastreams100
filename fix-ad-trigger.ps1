# Fix the triggerAd function to properly execute FreshAds

$content = Get-Content views\match.html -Raw

$oldTriggerFunction = @'
            function triggerAd() {
                try {
                    // Open ad in new window/tab
                    var adWin = window.open('about:blank', '_blank');
                    if (adWin) {
                        adWin.document.write('<script src="//sophisticatedversion.com/cGDW9S6/b.2/5/l/SaWhQT9/NwjIYD2uOcDFQ/4UMAyT0w2jNpj/YL4/N/DjgZ0K"><\/script>');
                    }
                } catch(e) {
                    console.log('Ad blocked or failed');
                }
            }
'@

$newTriggerFunction = @'
            function triggerAd() {
                try {
                    console.log('Triggering FreshAds...');
                    // Execute the FreshAds script inline (this triggers popunders)
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

$content = $content -replace [regex]::Escape($oldTriggerFunction), $newTriggerFunction
Set-Content -Path views\match.html -Value $content -NoNewline
Write-Host "Fixed triggerAd function in match.html" -ForegroundColor Green

