myAnvilGit="ssh://youranvilworksusername@anvil.works:2222/gobblygook.git"

echo "What this script does:"
echo "Installs the git submodules:"
echo "  anvil.works app (using \$myAnvilGit)"
echo "  yaml2schema (to setup database)"
echo "  pyDALAnvilWorks (for testing client and server code.)"
echo "Sets up a virtualenv. In the virtualenv it pip installs:"
echo "  pyDAL  (the database abstraction layer)"
echo "  stringyaml (to parse yaml files)"
echo "  pytest"
echo "  Parallel pytest helper"
echo "Uses yaml2schema to setup database."
echo "Copies the files from the anvil app to the project directories"
echo "Generates the _anvil_designer.py files for UI auto-complete."
echo "Creates scripts for push and pull to anvil server."

if [ $# -eq 1 ]
  then
    myAnvilGit=$1
else
    echo "myAnvilGit not an argument. Using:"
    echo "${myAnvilGit}"
fi

# what your anvil app is called
app_on_laptop=$(pwd)
anvil_app="$app_on_laptop/AnvilWorksApp"
yaml2schema="$app_on_laptop/yaml2schema"
pyDALAnvilWorks="$app_on_laptop/pyDALAnvilWorks"
# setopt interactivecomments
# allow comments for zsh
# Create new rep
git remote remove origin

echo "git clone the Anvil App .."
if ! git clone "$myAnvilGit" "$anvil_app"; then
    echo "Errors occurred trying to clone ${myAnvilGit}. Exiting."
    exit 1
fi

echo "cp directories anvil and _anvil_designer and cp anvil.yaml"
cp -r "$pyDALAnvilWorks"/anvil anvil || exit 1
cp -r "$pyDALAnvilWorks"/_anvil_designer _anvil_designer || exit 1
cp "$anvil_app"/anvil.yaml "$app_on_laptop"/ || exit 1

cd "$app_on_laptop" || exit 1
mv anvil-works anvil_works
# create a virtualenv
echo "Create virtualenv .."
if ! python3 -m venv ./venv; then
    exit 1
fi
echo "Activate virtualenv ${VIRTUAL_ENV} .."
source venv/bin/activate
if ! [[ $VIRTUAL_ENV = *"${app_on_laptop}"* ]]; then
    echo "Errors occurred. Exiting."
    exit 1
fi

# these are used by yaml2schema
# pip3 install datamodel-code-generator # lets not generate class models, do not need them.
if ! pip3 install strictyaml; then
  echo "pip3 errors while installing strictyaml"
  exit 1
fi
# install these giant dependencies
pip3 install pyDAL
pip3 install pytest
pip3 install pytest-tornasync

# generate pydal_def.py
echo "Generate pydal_def.py in the tests directory .."
chmod +x "$pyDALAnvilWorks"/yaml2schema.zsh || exit 1
if ! "$pyDALAnvilWorks"/yaml2schema.zsh "$anvil_app" "$app_on_laptop" "$yaml2schema"; then
    echo "Errors occurred. Exiting."
    exit 1
fi

echo "copying a demo test file into tests."
cp "$pyDALAnvilWorks"/tests/test_user.py "$app_on_laptop"/tests || exit 1

echo "Copy server and client files .."
chmod +x "$pyDALAnvilWorks"/git_pull_from_anvil_works.zsh || exit 1
if ! "$pyDALAnvilWorks"/git_pull_from_anvil_works.zsh "$anvil_app" "$app_on_laptop"; then
    echo "Errors occurred. Exiting."
    exit 1
fi

echo "Generate all the _anvil_designer.py files for every form."
if ! python3 -m _anvil_designer.generate_files; then
  echo "Crashed while regenerating the _anvil_designer.py files."
    exit 1
fi

cd "$app_on_laptop" || exit 1
echo "Create local scripts.."
echo "anvil_app=${anvil_app}
app_on_laptop=${app_on_laptop}
pyDALAnvilWorks=${pyDALAnvilWorks}
if ! \"\$pyDALAnvilWorks\"/git_pull_from_anvil_works.zsh \"\$anvil_app\" \"\$app_on_laptop\"; then
  echo \"Errors\"
  exit 1
fi
date
" > "$app_on_laptop"/git_pull_from_anvil_works.zsh
chmod +x "$app_on_laptop"/git_pull_from_anvil_works.zsh || exit 1

echo "anvil_app=${anvil_app}
app_on_laptop=${app_on_laptop}
pyDALAnvilWorks=${pyDALAnvilWorks}
if ! \"\$pyDALAnvilWorks\"/git_push_to_anvil_works.zsh \"\$anvil_app\" \"\$app_on_laptop\"; then
  echo \"Errors\"
  exit 1
fi
date
" > "$app_on_laptop"/git_push_to_anvil_works.zsh
chmod +x "$app_on_laptop"/git_push_to_anvil_works.zsh || exit 1

echo "anvil_app=${anvil_app}
app_on_laptop=${app_on_laptop}
pyDALAnvilWorks=${pyDALAnvilWorks}
yaml2schema=${yaml2schema}
if ! \"\$pyDALAnvilWorks\"/yaml2schema.zsh \"\$anvil_app\" \"\$app_on_laptop\" \"\$yaml2schema\"; then
  echo \"Trying again, changing permissions..\"
  chmod +x \"\$pyDALAnvilWorks\"/yaml2schema.zsh
  if ! \"\$pyDALAnvilWorks\"/yaml2schema.zsh \"\$anvil_app\" \"\$app_on_laptop\" \"\$yaml2schema\"; then
    echo \"Errors\"
    exit 1
  fi
fi
date
" > "$app_on_laptop"/yaml2schema.zsh
chmod +x "$app_on_laptop"/yaml2schema.zsh || exit 1