style=$1
files="config\nstyle.css"
echo $files | xargs rm -f
echo $files | xargs -I {} ln $style-{} {} 
