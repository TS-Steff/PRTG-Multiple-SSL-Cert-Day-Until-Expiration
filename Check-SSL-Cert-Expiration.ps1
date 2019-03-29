param([String] $urls)
$minimumCertAgeDays = 30
$timeoutMilliseconds = 3000

#disabling the cert validation check. This is what makes this whole thing work with invalid certs...
[Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
[string]$urls

write-host '<?xml version="1.0" encoding="UTF-8" ?>'
Write-Host "<prtg>"
#foreach ($url in $urls){ #param has to be -Urls @("www.google.com","www.heise.de")


$urlList = $urls.split("{,}")

foreach ($url in $urlList){
    Write-Host "<result>"
        Write-Host "<channel>$url</channel>"
        $req = [Net.HttpWebRequest]::Create("https://" + $url)
        $req.Timeout = $timeoutMilliseconds
        $req.AllowAutoRedirect = $false
        try {$req.GetResponse() |Out-Null} catch {Write-Host Exception while checking URL $url`: $_ -f Red}
        #$certExpiresOnString = $req.ServicePoint.Certificate.GetExpirationDateString()
        #Write-Host "Certificate expires on (string): $certExpiresOnString"
        [datetime]$expiration = [System.DateTime]::Parse($req.ServicePoint.Certificate.GetExpirationDateString())
        #Write-Host "Certificate expires on (datetime): $expiration"
        [int]$certExpiresIn = ($expiration - $(get-date)).Days
        #Write-host "Cert Expires IN: $certExpiresIn Days";
        Write-Host "<unit>count</unit>"
        Write-host "<value>$certExpiresIn</value>"
        Write-host "<showChart>1</showChart>"
        Write-host "<showTable>1</showTable>"
        Write-host "<LimitMinWarning>20</LimitMinWarning>"
        Write-host "<LimitMinError>10</LimitMinError>"
        Write-Host "<LimitWarningMsg>Cert is about to expire</LimitWarningMsg>"
        Write-Host "<LimitErrorMsg>Cert expires soon!!!</LimitErrorMsg>"
        Write-Host "<LimitMode>1</LimitMode>"

        #write-host ""

        rv req
        rv expiration
        rv certExpiresIn
    Write-Host "</result>"
}

write-host "</prtg>"