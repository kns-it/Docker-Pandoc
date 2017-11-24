# Docker-Pandoc

[![](https://images.microbadger.com/badges/version/knsit/pandoc.svg)](https://microbadger.com/images/knsit/pandoc "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/knsit/pandoc.svg)](https://microbadger.com/images/knsit/pandoc "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/commit/knsit/pandoc.svg)](https://microbadger.com/images/knsit/pandoc "Get your own commit badge on microbadger.com")

## Usage

The easiest way to use this container is to mount a volume into the container and run pandoc afterwards:

```bash
docker run --rm -v $(pwd):/home/pandoc knsit/pandoc:latest pandoc my-markdown.md -o my-pdf.pdf
```

Or to convert multiple files at once you could run a script like that:

```bash
docker run --rm -v $(pwd):/home/pandoc knsit/pandoc:latest /bin/sh build-pdfs.sh
```

where the `build-pdfs.sh` could look like this

```bash
#!/bin/sh
[ -d pdf_out ] || mkdir pdf_out
find . -name "*.md" -type f | while IFS='' read -r PATHNAME; do
	OUTFILE="${PATHNAME/.md/.pdf}"
	pandoc $PATHNAME --pdf-engine=pdflatex -o pdf_out/$OUTFILE
done
```

to convert all markdown files in the current folder to PDF files.

You may also use it interactive:

```bash
docker run --rm -ti -v $(pwd):/home/pandoc knsit/pandoc:latest
```

## Volumes

The container does not expose any container but the working directory is `/home/pandoc` and it's good practice to mount your local directory to this directory (as shown above).

## A note on Windows

The Powershell equivalent to the bash script above could look like this:

```powershell
Invoke-Expression ("docker run -v {0}:/home/pandoc --rm knsit/pandoc ./buildPDFs.sh" -f @(pwd).Path)
```

_Remark:_ you might get an error like

```bash
standard_init_linux.go:185: exec user process caused "no such file or directory"
```

this might be caused by the line endings differences of Windows (CRLF) and Linux (LF).
You can check if your line endings are fine e.g. with Notepad++.

Of course it's also possible to convert just a single file:

```powershell
Invoke-Expression ("docker run -v {0}:/home/pandoc --rm knsit/pandoc pandoc -o myDocument.pdf my-markdown-file.md" -f @(pwd).Path)
```