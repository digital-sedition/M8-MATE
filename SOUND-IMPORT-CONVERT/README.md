This utility script (`import__.ps1`) is a PowerShell script that uses `ffmpeg` and `ffprobe` to convert select parts of my sample library so they're ready for hardware usage - all in a specific quality, and all named in a clean way.

Any file the script finds that is a lower sample-rate, bit-rate, or channel count than you've asked for (determined by `ffprobe`) will be left at its original value, rather than upscale needlessly.  Folder structure will match the source structure, except all folders and output file-names will be made upper-case, have any non-ASCII removed, and generally be more device-friendly.

---

Usage is simple; refer to the included example (`import_dirtywave.ps1`) for, well, an example.

Basically:

$gFFE = (Get-Location).Path + "/ffmpeg.exe"
$gFFP = (Get-Location).Path + "/ffprobe.exe"

* Assign `$gFFE` and `$gFFP` the locations of your `ffmpeg` and `ffprobe` applications, respectively.  The script checks it can find them both by path, so you'll have to be explicit.

* 'Dot' include the utility script `import__.ps1` so it, like, can do its job.

* Call `Sound-Import-Conversion` with the following parameters:

	* Source path for files to process; can be relative to script.
	* Destination path for processed files; can also be relative.
	* `$true` if output files should be mono / `$false` if output files are stereo.
	* Either `8`, `16`, or `24` - denoting the bit rate of the output files.
	* Either `22050`, `44100`, or `48000` - denoting the sample rate.
	* The last parameter is optional: set to `$true` if you want the script to automatically create the *destination* folder.  Note that sub-folders under this will automatically be assumed to be wanted, and therefore created without requesting it.