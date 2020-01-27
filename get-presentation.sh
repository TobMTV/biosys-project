#!/usr/bin/env sh

command -v gs > /dev/null || { printf "You need Ghostscript (gs)\\n"; exit 1; }
gs -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 \
   -dSimulateOverprint=true -dPDFSETTINGS=/ebook -dEmbedAllFonts=true \
   -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic \
   -dColorImageResolution=150 -dGrayImageDownsampleType=/Bicubic \
   -dGrayImageResolution=150 -dMonoImageDownsampleType=/Bicubic \
   -dMonoImageResolution=150 -sOutputFile="./bs-presentation.pdf" \
   "./presentation/biosys-report.pdf" || { printf "Something went wrong\\n"; exit 1; }
