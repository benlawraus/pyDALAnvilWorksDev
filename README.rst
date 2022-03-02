Note
====
The best way to start is `pyDALAnvilWorksDev <https://github.com/benlawraus/pyDALAnvilWorksDev>`_.
Basically it is an empty project. Clone it using::

    git clone https://github.com/benlawraus/pyDALAnvilWorksDev --recursive


cd into the repo and run its script with the address of the anvil.works app.
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


(BTW, this project was developed on a macbook... not sure what happens for anything else.)


pyDALAnvilWorks
===============

See `pyDALAnvilWorks <https://github.com/benlawraus/pyDALAnvilWorks>`_
