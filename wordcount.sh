files=$(ls *.lyx)
lyx -e text ${files} && wc -w *.txt && rm ${files//\.lyx/\.txt}
#echo $files
#echo ${files/\.lyx/\.txt}
