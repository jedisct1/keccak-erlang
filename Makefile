REBAR?=./rebar

all: build

clean:
	$(REBAR) clean
	rm -rf logs
	rm -f test/*.beam

depends:
	@if test ! -d ./deps; then \
		$(REBAR) get-deps; \
	else \
		$(REBAR) update-deps; \
	fi

build: depends
	$(REBAR) compile

eunit:
	$(REBAR) eunit skip_deps=true

check: build eunit

%.beam: %.erl
	erlc -o test/ $<
