Powershell script to configure Windows servers to install Maven and setting the path. This script can also be used in your CI build steps to make your Windows agent Maven ready.

###Can I choose Maven version?

Yes, you'll have to change a few lines in the script:

1) `$zipPath = "C:\apache-maven-3.6.3-bin.zip"`

2) `(New-Object Net.WebClient).DownloadFile('http://apache.mirror.globo.tech/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip', $zipPath)`

3) `[IO.Directory]::Move('C:\apache-maven\apache-maven-3.6.3', $mavenPath)`

Just replace the Maven version with the version you want.

###Troubleshooting

####I am getting security protocol error.

Even though most commonly used, Windows security protocols have been added here:

`[System.Net.ServicePointManager]::SecurityProtocol = @("Tls12","Tls11","Tls","Ssl3")`

But if these are not sufficient for your specific agent then add the required security protocol in the list like this:

<pre>[System.Net.ServicePointManager]::SecurityProtocol = @("Tls12","Tls11","Tls","Ssl3", <b>"Ssl2"</b>)</pre>