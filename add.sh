# Update script for all Dragon-Breath components, stored locally as separate git repositories

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git submodule add $1 submodules/$2
echo "adding..."
git submodule update
echo "updating..."
echo $2 >> SUBMODPATHS 
