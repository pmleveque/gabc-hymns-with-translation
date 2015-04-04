# Attention ! changer le commentaire "H. IV dans fragment.tex"
# 
# $1 représente le fichier en entrée
# 
#

# Le script s'arrête en cas d'erreur
set -e

li=`grep '% largeurinitiale' $1 | sed 's/% largeurinitiale: //' | sed 's/;//'`
lf=`grep '% largeurfinale' $1 | sed 's/% largeurfinale: //' | sed 's/;//'`
aboveinitial=`grep '% annotation' $1 | sed 's/% annotation: //' | sed 's/;//'`
name=`echo $1 | sed 's/.gabc//'`



gregorio $1 -o source.tex
lualatex "\def\largeurinitiale{$li} \def\aboveinitial{$aboveinitial} \input{fragment.tex}"
pdfjam fragment.pdf --papersize "{$lf,4cm}"
pdfcrop fragment-pdfjam.pdf
mkdir $name/ || true
pdftk fragment-pdfjam-crop.pdf burst output $name/fragment-%d.pdf
mv fragment-pdfjam-crop.pdf $name/fragments.pdf

