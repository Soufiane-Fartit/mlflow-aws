# HEROKU DEPOLYMENT
loginHeroku:
	heroku login

loginHerokuReg:
	heroku container:login

deployHeroku :
	heroku container:push web -a sfartit-mlflow && heroku container:release web -a sfartit-mlflow


# STANDARD
pushCode :
	git add . && git commit -m "edit" && git push

build :
	docker build -t sfartit-mlflow .