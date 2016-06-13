wxPython 2.8 for python virtualenv
==================================

File Orgranization
==================
```
.
├── clear.sh
├── makefile
├── README.md
├── requirements.txt
├── wxPython.configure.patch 	# Fix configure error: OpenGL libraries not available (Tested on Ubuntu 16.04)
└── wxPython.sh

```

How to debug
==================

Pre-requirements
-----------------------------------------

	sudo apt-get install python-pip libxml2-dev libxslt1-dev libgtk2.0-dev freeglut3 freeglut3-dev
	sudo pip install virtualenv

Create Virtual Python Environment
-----------------------------------------

	make bootstrap
