# Update script for all Dragon-Breath components, stored locally as separate git repositories

echo "Updating all submodules"
git submodule update
PROJECTS="SmartFactory ApexLimitUtil ApexTestUtil ApexCommonsString ApexCommonsHttpUtil"
echo $PROJECTS

cp -R ./submodules/SmartFactory/src/classes/* ~/tech/Dragon-Breath/src/classes
cp -R ./submodules/ApexLimitUtil/* ~/tech/Dragon-Breath/src/classes
cp -R ./submodules/ApexTestUtil/* ~/tech/Dragon-Breath/src/classes
