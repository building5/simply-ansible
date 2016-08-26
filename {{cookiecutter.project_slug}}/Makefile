all:
.PHONY: all

virtualenv: build/virtualenv/.built
.PHONY: virtualenv

galaxy: build/galaxy/.built
.PHONY: galaxy

check-env:
	@if ! test "$(shell which pip)" -ef "$(shell which build/virtualenv/bin/pip)"; then \
		echo "ERROR: virtualenv not activated" >&2; \
		echo "Run 'source ./activate.sh' and try again" >&2; \
		exit 1; \
	fi
.PHONY: check-env

build/virtualenv/.built: requirements.txt
	rm -rf build/virtualenv
	virtualenv build/virtualenv
	. build/virtualenv/bin/activate && pip install -r requirements.txt
	touch $@

build/galaxy/.built: requirements.yml
	@$(MAKE) check-env
	rm -rf build/galaxy
	ansible-galaxy install -r requirements.yml
	touch $@

test:
	@$(MAKE) check-env
	ansible-playbook site.yml --syntax-check
	ansible-lint --exclude build/ site.yml
.PHONY: test
