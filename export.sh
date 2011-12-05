DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

while read p    
do    
	echo -n "Exporting to "
	echo $p
	cp -apRf $DIR/src/classes/* $p
	cp -apRf $DIR/src/resources/* $p

	
done <PROJECTPATHS
