Note
====
The best way to start is `pyDALAnvilWorksDev <https://github.com/benlawraus/pyDALAnvilWorksDev>`_.
Basically it is an empty project. Clone it, change the directory name and then cd into the
directory. From there, run its script with the address of the anvil.works app.

(BTW, this project was developed on a macbook... not sure what happens for anything else.)

The script will:

* Install the git submodules:

    * your anvil.works app (using $myAnvilGit script argument)
    * `yaml2Schema <https://github.com/benlawraus/yaml2schema>`_ (to setup database)
    * `pyDALAnvilWorks <https://github.com/benlawraus/pyDALAnvilWorks>`_ (for testing client and server code.)
    * (optional `anvil-extras <https://github.com/anvilistas/anvil-extras>`_)

* Set up a virtualenv. In the virtualenv it pip-installs:

    *   `pyDAL <https://github.com/web2py/pydal>`_  (the database abstraction layer)
    *   `strictyaml <https://github.com/crdoconnor/strictyaml>`_ (to parse yaml files)
    *   `pytest <https://github.com/pytest-dev/pytest>`_
    *   `pytest-tornasync <https://github.com/eukaryote/pytest-tornasync>`_ (Parallel pytest helper for pyDAL)

* Use yaml2schema to setup database.
* Copy the files from the anvil app to the project directories
* Generate the ``_anvil_designer.py`` files for IDE auto-completion.
* Create scripts for push and pull to anvil server.


pyDALAnvilWorks
===============

See `pyDALAnvilWorks <https://github.com/benlawraus/pyDALAnvilWorks>`_
