# Update script for all Dragon-Breath components, stored locally as separate git repositories

git submodule update
echo "Updating all submodules"
PROJECTS="SmartFactory ApexCommonsCore"
echo $PROJECTS

cp -R ./SmartFactory-for-Force.com/src/classes/* ~/tech/Dragon-Breath/src/classes
