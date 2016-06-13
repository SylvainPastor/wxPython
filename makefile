
.PHONY: bootstrap test clean

test:
	sh -c 'export LD_LIBRARY_PATH=./venv/lib; . venv/bin/activate; python test.py'

bootstrap: venv
ifneq ($(wildcard requirements.txt),) 
	venv/bin/pip install -r requirements.txt
endif
ifneq ($(wildcard wxPython.sh),) 
	./wxPython.sh
endif

venv: 
	virtualenv venv
	venv/bin/pip install --upgrade pip
	venv/bin/pip install --upgrade setuptools

clean:
	@./clear.sh
