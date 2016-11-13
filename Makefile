server:
	hugo server --buildDrafts=false

generate:
	hugo --buildDrafts=false

publish:
	rsync -rav ./public/ guy@clearwater.com.au:/data/www/guy.carpenter.id.au/gaugette/
