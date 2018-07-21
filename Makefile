.PHONY: test

test:
	bundle exec ruby test/converter_test.rb

file-rss-to-atom:
	bundle exec ./convert-feed -o atom -l 2 -s ./feed.rss

http-atom-to-rss:
	bundle exec ./convert-feed -o rss -l 2 -s https://ru.hexlet.io/lessons.rss


