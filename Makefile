.PHONY: test

test:
	bundle exec ruby test/converter_test.rb

file-rss-to-atom:
	bundle exec ./bin/convert-feed -o atom -l 2 --sort=title -r ./feed.rss

http-atom-to-rss:
	bundle exec ./bin/convert-feed -o rss -l 2 --sort=title -r https://ru.hexlet.io/lessons.rss


