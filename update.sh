# Update script for all Dragon-Breath components, stored locally as separate git repositories

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Removing previous files"
rm -r $DIR/src/classes/*
rm -r $DIR/src/staticresources/*

echo "Updating all submodules"
# Not sure that this line is necessary
git submodule update

while read sm    
do    
	echo "updating from $sm"
	cd submodules/$sm
	git checkout master
	git pull
	ruby zip_resources.rb $DIR/submodules/$sm 
	cp -R *.cls $DIR/src/classes
	cp -R *.resource $DIR/src/resources
	rm *.resource
	cd $DIR
done <SUBMODPATHS
rm README
ruby gen_meta.rb


