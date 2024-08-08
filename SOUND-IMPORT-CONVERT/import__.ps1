# -----------------------------------------------------------------------------------------------------------------------------
# ACiDiC_SPUNk :: DiGiTAL_SEDiTiON :: v2408
# Free of copyright; do what the funk you want with this.  That also means I provide no support, and any use of this is on you.
# -----------------------------------------------------------------------------------------------------------------------------
# Please see https://github.com/digital-sedition for an up-to-date version and instructions.
# I didn't create a repo just for this tiny script, so it'll be in a repo for some overly-expensive and sexy hardware sampler.
# -----------------------------------------------------------------------------------------------------------------------------
# YOU SHOULDN'T NEED TO GO POKING IN THE BELOW, EH.
# ...but don't run it blindly; check it over.  It's easy to follow.
# -----------------------------------------------------------------------------------------------------------------------------

Write-Host ""
Write-Host "== LAZY BOY SOUND IMPORT/CONVERTION THINGY" -ForegroundColor Green

if (!($MyInvocation.InvocationName -eq '.' -or $MyInvocation.Line -eq '')) {
	Write-Host "@@ Steady your horse there, pal: you're not meant to run this script!  Run t'other one." -ForegroundColor DarkRed
	exit 1
}

$zFFE = Resolve-Path -Path $gFFE
$zFFP = Resolve-Path -Path $gFFP

Write-Host "-- Given the following paths:"
Write-Host "   > ffmpeg:  $zFFE"
Write-Host "   > ffprobe: $zFFP"
Write-Host ""

if (!(Test-Path -Path $zFFE -PathType leaf) -or !(Test-Path -Path $zFFP -PathType leaf)) {
	Write-Host "@@ Check the configuration settings in the launch script 'cuz I'm totes not finding the tools, man.  Soz." -ForegroundColor DarkRed
	exit 2
}

# Main function...
function Sound-Import-Conversion {
	param(
		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$pSrc,

		[Parameter(Mandatory)]
		[ValidateNotNullOrEmpty()]
		[string]$pDst,

		[bool]$pMono = $false,

		[ValidateSet(8, 16, 24)]
		[int]$pBits = 16,

		[ValidateSet(22050, 44100, 48000)]
		[int]$pRate = 44100,
		
		[bool]$pAutoDst = $false)

	$lSrc = [IO.Path]::GetFullPath($pSrc)
	$lDst = [IO.Path]::GetFullPath($pDst)

	# Does the source folder exist?
	if (!(Test-Path -Path $lSrc)) {
		Write-Host "!! Source folder '$pSrc' does not exist; skipping." -ForegroundColor DarkYellow
		Write-Host ""
		return
	}

	# Does the destination folder exist?
	if (!(Test-Path -Path $lDst)) {
		if (!$pAutoDst) {
			$lDstCreate = Read-Host "?? Destination folder does not exist; create? ['y'=yes / anything else=buh~bye] "
			if (!($lDstCreate -eq 'y')) {
				Write-Host "!! Destination folder '$pDst' does not exist and told off for suggesting I create it; skipping." -ForegroundColor DarkYellow
				Write-Host ""
				return
			}
		}
		New-Item -Path $lDst -ItemType "directory" | out-null
	}

	# Build a list of all files for ffmpeg to convert from the source folder...
	$lSrcFiles = @(Get-ChildItem -Path $lSrc -Recurse -Include ('*.pcm', '*.wav', '*.mp3', '*.flac'))
	Write-Host "-- Rockin' and rollin' in '$lSrc':" -ForegroundColor DarkGreen
	Write-Host "-- Found $($lSrcFiles.count) (seemingly) valid items; processing..."

	# Start worming our way through this...
	$lSrcFilesItemCount = 0
	$lSrcFilesItemProgress = 0
	foreach ($lSrcFilesItem in $lSrcFiles) {
		# Give the user some idea of where we're up to...
		$lSrcFilesItemProgress = [math]::Round(((++$lSrcFilesItemCount/$lSrcFiles.count)*100),2)
		Write-Progress -Activity "Doing the needful" -CurrentOperation $lSrcFilesItem -Status "$lSrcFilesItemProgress% done" -PercentComplete $lSrcFilesItemProgress

		# Format item's name: removing base path, naming bits I don't like, and any non-ASCII - then replacing any white-space characters and UPPERCASE'ing it all...
		$lDstFile = [System.IO.Path]::ChangeExtension($lSrcFilesItem, $null) -replace [regex]::Escape($lSrc),'' `
					-replace [regex]::Escape(' - '),'-' `
					-replace [regex]::Escape('.'),'' `
					-replace '\s','_' `
					-replace '[^\p{IsBasicLatin}]',''
		if (!$lDstFile) { continue }
		$lDstFile = $lDstFile.ToUpper() + ".WAV"

		# Ensure target folder exists; if not, create the matching tree...
		$lDstFilePath = [string]::Empty
		foreach($lDstFilePathItem in (Split-Path -Parent $lDstFile).Split([IO.Path]::DirectorySeparatorChar)) {
			if (!$lDstFilePathItem) { continue }
			if ($lDstFilePath) { $lDstFilePath = $lDstFilePath + [IO.Path]::DirectorySeparatorChar + $lDstFilePathItem } else { $lDstFilePath = $lDstFilePathItem }
			if (!(Test-Path -Path (Join-Path -Path $lDst -ChildPath $lDstFilePath))) {
				New-Item -Path $lDst -Name $lDstFilePath -ItemType "directory" | out-null
			}
		}

		# Okay, now to do the actual work we're here to do...
		$lDstPath = Join-Path -Path (Join-Path -Path $lDst -ChildPath $lDstFilePath) -ChildPath ([System.IO.Path]::GetFileName($lDstFile))
		# todo: the below doesn't seem to match files with square brackets in them?!  too late to be arsed right now.
		if (Test-Path -Path $lDstPath -PathType leaf) { continue } # If, after all this, the file already exists, leave it.  Allows us to add new files without affecting the others.
		$lSrcSRte = & "$($zFFP)" -v error -select_streams a:0 -show_entries stream=sample_rate -of default=noprint_wrappers=1:nokey=1 "$($lSrcFilesItem)"
		$lSrcBRte = & "$($zFFP)" -v error -select_streams a:0 -show_entries stream=bits_per_sample -of default=noprint_wrappers=1:nokey=1 "$($lSrcFilesItem)"
		$lSrcChan = & "$($zFFP)" -v error -select_streams a:0 -show_entries stream=channels -of default=noprint_wrappers=1:nokey=1 "$($lSrcFilesItem)"
		& "$($zFFE)" -loglevel quiet -i "$($lSrcFilesItem)" -c:a pcm_s$(if ($lSrcBRte -ge $pBits) {$pBits} else {$lSrcBRte})le -ac $(if ($pMono) {"1"} else { if ($lSrcChan -le 1) {"1"} else {"2"} }) -ar $(if ($lSrcSRte -ge $pRate) {$pRate} else {$lSrcSRte}) "$($lDstPath)"
	}

	Write-Host ""
}
