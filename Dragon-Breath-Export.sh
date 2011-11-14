# Export script for all Dragon-Breath components to Eclipse workspaces, usually run after updating to current version (and tests!)

MYPATH="~/tech/eclipse/Pipeline/src/classes"
echo "Exporting to"
echo $MYPATH

cp -R ~/tech/Dragon-Breath/src/classes/*  ~/tech/eclipse/Pipeline/src/classes

# Do we need anything besides classes?
#cp -R ~/tech/Dragon-Breath/src/classes/*  ~/tech/eclipse/Pipeline/src/classes

# add namespace

# add missing xml files