# s:
# 	-@ rm tmp/pids/server.pid
# 	bin/rails s -b 0.0.0.0

# server:
# 	-@ rm tmp/pids/server.pid
# 	bin/rails s -b 0.0.0.0

# yarn:
# 	yarn install

# db:
# 	bin/rails db:migrate

# db-rollback:
# 	bin/rails db:rollback STEP=1

# style:
# 	vendor/bundle/bin/rubocop
# 	#--fail-fast

# style!:
# 	vendor/bundle/bin/rubocop -a

# test:
# 	bin/rails test $(ARGS)

# test1:
# 	PARALLEL_WORKERS=1 bin/rails test $(ARGS)

# routes:
# 	bin/rails routes | grep "$(ARGS)"

# logs:
# 	tail -f log/development.log

# # UNUSED:

# # fix-env:
# # 	bin/rails db:environment:set RAILS_ENV=development

# # test!:
# # 	bin/rails test
# # 	bin/rails spec

# procfile:
# 	bundle exec foreman start -f Procfile

# init: install

# install:
# 	bundle install
# 	bundle exec bin/rails db:create
# 	bundle exec bin/rails db:migrate
# 	bundle exec bin/rails db:fixtures:load

# # upd-translations:
# # 	ruby import_translations.rb

# squash:
# 	-@ make summer
# 	# group :tools do
#   	# gem 'squasher', '>= 0.6.0'
# 	# end
# 	vendor/bundle/bin/squasher 2019

# # gem install ruby-debug-ide
# # gem install debase
# # Configure 'Listen and debug' to 'Listen for rdebug-ide' -> configuration should create launch.json, check the host and port numbers

# rdebug:
# 	rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- bin/rails server

# tunnel:
# 	npx localtunnel --port 80 --subdomain setyl-dev

# sidekiq:
# 	bundle exec sidekiq