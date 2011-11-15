# Update script for all Dragon-Breath components, stored locally as separate git repositories

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Removing previous files"
rm $DIR/src/classes/*
echo "Updating all submodules"
# Not sure that this line is necessary
git submodule update

while read p    
do    
	echo "updating from $p"
	cd submodules/$p
	git checkout master
	git pull
	cp -R * $DIR/src/classes
	cd $DIR
done <SUBMODPATHS
ruby gen_meta.rb


