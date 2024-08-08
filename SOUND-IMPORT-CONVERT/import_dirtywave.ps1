# -----------------------------------------------------------------------------------------------------------------------------
# ACiDiC_SPUNk :: DiGiTAL_SEDiTiON :: v2408
# Free of copyright; do what the funk you want with this.  That also means I provide no support, and any use of this is on you.
# -----------------------------------------------------------------------------------------------------------------------------
# Please see https://github.com/digital-sedition/M8-MATE for an up-to-date version and instructions.
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
