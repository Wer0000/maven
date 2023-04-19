Write-Host "Installing Apache Maven..." -ForegroundColor Cyan

$apachePath = "${env:ProgramFiles(x86)}\Apache"
$mavenPath = "$apachePath\Maven"

if(Test-Path $mavenPath) {
    Remove-Item $mavenPath -Recurse -Force
}

if(-not (Test-Path $apachePath)) {
    New-Item $apachePath -ItemType directory -Force
}

Write-Host "Downloading..." -ForegroundColor Cyan
$zipPath = "C:\apache-maven-3.6.3-bin.zip"
[System.Net.ServicePointManager]::SecurityProtocol = @("Tls12","Tls11","Tls","Ssl3")
(New-Object Net.WebClient).DownloadFile('http://apache.mirror.globo.tech/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip', $zipPath)

Write-Host "Unpacking..." -ForegroundColor Cyan
mkdir C:\apache-maven
Expand-Archive -LiteralPath $zipPath -DestinationPath C:\apache-maven
[IO.Directory]::Move('C:\apache-maven\apache-maven-3.6.3', $mavenPath)
Remove-Item 'C:\apache-maven' -Recurse -Force
del $zipPath

[Environment]::SetEnvironmentVariable("M2_HOME", $mavenPath, "Machine")
[Environment]::SetEnvironmentVariable("MAVEN_HOME", $mavenPath, "Machine")

$env:Path += ";$mavenPath\bin"
$env:Path += ";$mavenPath\bin"

mvn --version

Write-Host "Apache Maven installed!" -ForegroundColor Green