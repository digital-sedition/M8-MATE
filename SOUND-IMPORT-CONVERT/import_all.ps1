# -----------------------------------------------------------------------------------------------------------------------------
# ACiDiC_SPUNk :: DiGiTAL_SEDiTiON :: v2408
# Free of copyright; do what the funk you want with this.  That also means I provide no support, and any use of this is on you.
# -----------------------------------------------------------------------------------------------------------------------------
# This script is to make it easy to build a library of samples to import to another device in a given quality, and all named in
# a cleaner way.  Any file the process finds that is a lower sample-rate, bit-rate, or channel count than you've asked for it
# will leave at its original value, rather than upscale needlessly.  Folder structure will match the source structure, except
# all folders and output file-names will be made upper-case, have any non-ASCII removed, and generally more device-friendly.
# -----------------------------------------------------------------------------------------------------------------------------
# Change the first two variables to be the location of your ffmpeg and ffprobe applications.  The script ensures it can find
# them by path, so you'll have to be explicit.  These won't be included if you found this in a public repo of mine.
#
# The next line is calling the support file for the processing function itself; I split it so I could have an import script per
# device.  If you've not put this file alongside this script, then please let this script know where the frick it is.
#
# The lines after that?  That's for you to call 'Sound-Import-Conversion'.  You'll need to provide it the follow parameters:
#   - Source path for files to process; can be relative to script.
#   - Destination path for processed files; can also be relative.
#   - $true if output files should be mono / $false if output files are stereo.
#   - Either 8, 16, or 24 - denoting the bit rate of the output files.
#   - Either 22050, 44100, or 44800 - denoting the sample rate.
#   - The last parameter is optional: set to $true if you want the script to automatically create the destination folder.
# -----------------------------------------------------------------------------------------------------------------------------
$gFFE = (Get-Location).Path + "/ffmpeg.exe"
$gFFP = (Get-Location).Path + "/ffprobe.exe"

. ./import__.ps1

# -----------------------------------------------------------------------------------------------------------------------------
# Digitakt II [or, like, any high-def sampler]

# Lower quality stuff
Sound-Import-Conversion "\\nas.local\Private\hobby\music\sounds\samples\packs\Amiga ST-XX"          "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/AMIGA" $true 16 22050
Sound-Import-Conversion "\\nas.local\Private\hobby\music\devices\teenage engineering\ep-133"        "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/TEENAGE_ENGINEERING" $true 16 44100

# As-nice-as-possible stuff
Sound-Import-Conversion "\\nas.local\Private\hobby\music\sounds\samples\packs\Dave Mech"            "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/DAVE_MECH" $false 24 48000
Sound-Import-Conversion "\\nas.local\Private\hobby\music\sounds\samples\packs\Dissonant Witchcraft" "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/DISSONANT_WITCHCRAFT" $false 24 48000
Sound-Import-Conversion "\\nas.local\Private\hobby\music\sounds\samples\packs\Elektron"             "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/ELEKTRON" $false 24 48000
Sound-Import-Conversion "\\nas.local\Private\hobby\music\sounds\samples\packs\Maschine"             "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/MASCHINE" $false 24 48000
Sound-Import-Conversion "\\nas.local\Private\hobby\music\sounds\samples\packs\Minimal"              "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/MINIMAL" $false 24 48000
Sound-Import-Conversion "\\nas.local\Private\hobby\music\sounds\samples\packs\User Friendly"        "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/USER_FRIENDLY" $false 24 48000
Sound-Import-Conversion "\\nas.local\Private\hobby\music\sounds\samples\voidptr"                    "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/VOIDPTR" $false 24 48000

# -----------------------------------------------------------------------------------------------------------------------------
# M8 [or, like, any more restricted samplers]

# Lower quality stuff
Sound-Import-Conversion "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/AMIGA"                "$([Environment]::GetFolderPath('Desktop'))/Import/M8/AMIGA" $true 16 22050
Sound-Import-Conversion "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/TEENAGE_ENGINEERING"  "$([Environment]::GetFolderPath('Desktop'))/Import/M8/TEENAGE_ENGINEERING" $true 16 44100

# As-nice-as-possible stuff
Sound-Import-Conversion "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/DAVE_MECH"            "$([Environment]::GetFolderPath('Desktop'))/Import/M8/DAVE_MECH" $false 16 44100
Sound-Import-Conversion "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/ELEKTRON"             "$([Environment]::GetFolderPath('Desktop'))/Import/M8/ELEKTRON" $false 16 44100
Sound-Import-Conversion "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/MASCHINE"             "$([Environment]::GetFolderPath('Desktop'))/Import/M8/MASCHINE" $false 16 44100
Sound-Import-Conversion "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/MINIMAL"              "$([Environment]::GetFolderPath('Desktop'))/Import/M8/MINIMAL" $false 16 44100
Sound-Import-Conversion "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/USER_FRIENDLY"        "$([Environment]::GetFolderPath('Desktop'))/Import/M8/USER_FRIENDLY" $false 16 44100
Sound-Import-Conversion "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/VOIDPTR"              "$([Environment]::GetFolderPath('Desktop'))/Import/M8/VOIDPTR" $false 16 44100

# Pull the non-chain stuff
Sound-Import-Conversion "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/DISSONANT_WITCHCRAFT/CREMATORY_MACHINERY/ONE_SHOTS" "$([Environment]::GetFolderPath('Desktop'))/Import/M8/DISSONANT_WITCHCRAFT/CREMATORY_MACHINERY" $false 16 44100 $true
Sound-Import-Conversion "$([Environment]::GetFolderPath('Desktop'))/Import/Digitakt2/DISSONANT_WITCHCRAFT/FINLAND_RUST/ONE_SHOTS" "$([Environment]::GetFolderPath('Desktop'))/Import/M8/DISSONANT_WITCHCRAFT/FINLAND_RUST" $false 16 44100 $true
