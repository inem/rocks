summer:
	bin/spring stop

c:
	bin/rails console -- --noautocomplete

g:
	bin/rails g $(ARGS)

assets:
	bin/rails assets:precompile

model:
	bin/rails generate model $(ARGS)

controller:
	bin/rails generate controller $(ARGS)

migration:
	bin/rails generate migration $(ARGS)

secrets:
	bin/rails credentials:edit

bop:
	echo "bop"