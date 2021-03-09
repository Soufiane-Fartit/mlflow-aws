# MLflow Web App

Hosted on Heroku, and using AWS RDS (MySQL) as a backend store, and AWS S3 as artifact store.

---


## Requierements

#### INFRA
* AWS S3 bucket (other services can be used with minor changes to the code)
* AWS S3 user with access to the bucket
* AWS RDS (or other)
* Heroku account

#### GITHUB SECRETS
> Needs The Following Github secrets
* **HEROKU_API_KEY**

            can be found in heroku profile settings


* **AWS_ACCESS_KEY_ID**
* **AWS_SECRET_ACCESS_KEY**

            AWS credentials can be created in the AWS IAM console.
            -> create a new user with permissions to read and write on AWS S3

* **DB_ENDPOINT**
* **DB_PORT**
* **DB_NAME**
* **DB_USER_ID**
* **DB_USER_KEY**

            Infos concerning the RDS DB

* **S3_BUCKET**

            AWS unique name of the S3 bucket

* **APP_NAME**

            Heroku unique name of the APP


