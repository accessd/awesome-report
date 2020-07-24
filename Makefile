all: rubocop tests clean

rubocop:
	bundle exec rubocop

tests:
	echo "Dir.glob('./test/**/*_test.rb').each { |file| require file}" | ruby

clean:
	rm -f ./reports/result_test.json
