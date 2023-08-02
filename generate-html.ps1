Set-Location $PSScriptRoot

$destinationDir = if (Test-Path $(Join-Path $(Resolve-Path '.') 'index')) {Join-Path '.' 'index' -resolve} else {(New-Item 'index' -ItemType 'Directory').fullname}
$avxVersions = "AVX","AVX2"
$cudaVersions = "11.7","11.8","12.0","12.1","12.2"
$packageVersions = "0.2.13","0.2.14","0.2.15","0.2.16","0.2.17","0.2.18"
$pythonVersions = "py3"
$supportedSystems = 'any'
$wheelSource = 'https://github.com/jllllll/ctransformers-cuBLAS-wheels/releases/download'
$packageName = 'ctransformers'
$packageNameNormalized = 'ctransformers'

$avxVersions.foreach({Set-Variable "$_`Dir" $(if (Test-Path $(Join-Path $destinationDir $_)) {Join-Path $destinationDir $_} else {(New-Item $(Join-Path $destinationDir $_) -ItemType 'Directory').fullname})})

$indexContent = "<!DOCTYPE html>`n<html>`n  <body>`n    "
Foreach ($avxVersion in $avxVersions)
{
	$wheelURL = $wheelSource.TrimEnd('/') + "/$avxVersion"
	$subIndexContent = "<!DOCTYPE html>`n<html>`n  <body>`n    "
	ForEach ($cudaVersion in $cudaVersions)
	{
		$cu = $cudaVersion.replace('.','')
		$cuContent = "<!DOCTYPE html>`n<html>`n  <body>`n    "
		ForEach ($packageVersion in $packageVersions)
		{
			ForEach ($pythonVersion in $pythonVersions)
			{
				$pyVer = $pythonVersion.replace('.','')
				ForEach ($supportedSystem in $supportedSystems)
				{
					$wheel = "$packageName-$packageVersion+cu$cu-$pyVer-none-$supportedSystem.whl"
					$cuContent += "<a href=`"$wheelURL/$wheel`">$wheel</a><br/>`n    "
				}
			}
			$cuContent += "`n    "
		}
		$cuDir = if (Test-Path $(Join-Path $(Get-Variable "$avxVersion`Dir").Value "cu$cu")) {Join-Path $(Get-Variable "$avxVersion`Dir").Value "cu$cu"} else {(New-Item $(Join-Path $(Get-Variable "$avxVersion`Dir").Value "cu$cu") -ItemType 'Directory').fullname}
		$packageDir = if (Test-Path $(Join-Path $cuDir $packageNameNormalized)) {Join-Path $cuDir $packageNameNormalized} else {(New-Item $(Join-Path $cuDir $packageNameNormalized) -ItemType 'Directory').fullname}
		$subIndexContent += "<a href=`"cu$cu/`">CUDA $cudaVersion</a><br/>`n    "
		New-Item $(Join-Path $packageDir "index.html") -itemType File -value $($cuContent.TrimEnd() + "`n  </body>`n</html>`n") -force > $null
		New-Item $(Join-Path $cuDir "index.html") -itemType File -value $("<!DOCTYPE html>`n<html>`n  <body>`n    <a href=`"$packageNameNormalized/`">$packageName</a>`n  </body>`n</html>`n") -force > $null
	}
	$indexContent += "<a href=`"$avxVersion/`">$avxVersion</a><br/>`n    "
	New-Item $(Join-Path $(Get-Variable "$avxVersion`Dir").Value "index.html") -itemType File -value $($subIndexContent.TrimEnd() + "`n  </body>`n</html>`n") -force > $null
}
New-Item $(Join-Path $destinationDir "index.html") -itemType File -value $($indexContent.TrimEnd() + "`n  </body>`n</html>`n") -force > $null

pause
