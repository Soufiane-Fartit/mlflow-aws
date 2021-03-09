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

* **MLFLOW_TRACKING_PASSWORD**
* **MLFLOW_TRACKING_USERNAME**

            To connect to the web application


## Usage

In the python script :

set env variables for creds (the same used in secrets)

```
import os
os.environ['MLFLOW_TRACKING_USERNAME'] = 'username'
os.environ['MLFLOW_TRACKING_PASSWORD'] = 'secret'
```

Set the endpoint 
```
mlflow.set_tracking_uri("https://<APP_NAME>.herokuapp.com")
```

Set the experiment name
```
mlflow.set_experiment("wine-quality")
```

Retrieve the experiment by its name from the backend store
```
experiment = mlflow.get_experiment_by_name("wine-quality")
```

Run the experiment
```
with mlflow.start_run(experiment_id=experiment.experiment_id):
        lr = ElasticNet(alpha=alpha, l1_ratio=l1_ratio, random_state=42)
        lr.fit(train_x, train_y)

        predicted_qualities = lr.predict(test_x)
        (rmse, mae, r2) = eval_metrics(test_y, predicted_qualities)

        mlflow.log_param("alpha", alpha)
        mlflow.log_param("l1_ratio", l1_ratio)
        mlflow.log_metric("rmse", rmse)
        mlflow.log_metric("r2", r2)
        mlflow.log_metric("mae", mae)
        
        mlflow.sklearn.log_model(lr, "model")
```


---

Credits :

* https://github.com/soundsensing/mlflow-easyauth