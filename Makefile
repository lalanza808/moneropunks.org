release:
	zola build
	rsync -avzP -e ssh public/ moneropunks:/var/www/moneropunks.org
	ssh moneropunks "chown -R www-data:www-data /var/www/moneropunks.org"
