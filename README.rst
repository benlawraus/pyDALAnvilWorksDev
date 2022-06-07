SUMMARY
=======
To allow testing and coding (with auto-complete) of an `anvil.works <https://anvil.works>`_ app.


Uses `pyDALAnvilWorks <https://github.com/benlawraus/pyDALAnvilWorks>`_ and `yaml2schema <https://github.com/benlawraus/yaml2schema>`_
to generate a folder structure on your laptop. After installation, no interent connection is required to run tests, as the database is replicated
in sqlite.


INSTALL
========
The best way to start is `pyDALAnvilWorksDev`_.
Basically it is an empty project. Clone it using::

    git clone https://github.com/benlawraus/pyDALAnvilWorksDev --recursive
    mv pyDALAnvilWorksDev myProject
    cd myProject
    chmod +x setup_project.zsh

Rename the directory before anything else, because the script will generate other scripts containing the
absolute locations of files. If you rename the directory afterwards, the links in the scripts will be invalid.

IMPORTANT
---------
**Before executing the script**, change the first line in the script from::

    myAnvilGit="ssh://youranvilworksusername@anvil.works:2222/gobblygook.git"

To your actual anvil.works app link found from your anvil.works account.

The script will:

* Install your anvil.works app (using $myAnvilGit)
* Set up a virtualenv. In the virtualenv it pip-installs:

    *   `pyDAL <https://github.com/web2py/pydal>`_  (the database abstraction layer)
    *   `strictyaml <https://github.com/crdoconnor/strictyaml>`_ (to parse yaml files)
    *   `pytest <https://github.com/pytest-dev/pytest>`_
    *   `pytest-tornasync <https://github.com/eukaryote/pytest-tornasync>`_ (Parallel pytest helper for pyDAL)

* Use yaml2schema to setup database.
* Copy the files from the anvil app to the project directories
* Generate the ``_anvil_designer.py`` files for IDE auto-completion.
* Create scripts for push and pull to anvil server.

After ``setup_project.zsh`` is finished::

    source venv/bin/activate
    python3 -m pytest tests

This will run a test to make sure your test user can log in and out.

Next, create another directory called 'tests_myproject'. Place all your pytests in there.  Why? Well,
then you can save your pytests directory as a github repo. Then if you want a fresh project, you could
run the script again, but this time add your pytests directory as a git submodule.

pyDALAnvilWorks
===============

See `pyDALAnvilWorks <https://github.com/benlawraus/pyDALAnvilWorks>`_

(BTW, this project was developed on a macbook... not sure what happens for anything else.)
