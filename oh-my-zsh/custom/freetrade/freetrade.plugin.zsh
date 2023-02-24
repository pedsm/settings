# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

export DB_PATH=https://freetrade-ci.firebaseio.com
export FREETRADE_SERVICE=onboarding
export GCP_PROJECT_NAME=freetrade-ci
export GCLOUD_PORJECT=${GCP_PROJECT_NAME}
export FIREBASE_CONFIG="{ \"projectId\": \"freetrade-ci\" }"


alias proxy_pg='./cloud_sql_proxy -instances=freetrade-investment-preprod:europe-west1:postgresql-db-investment-preprod=tcp:2468'
alias proxy_pg_prod='./cloud_sql_proxy -instances=freetrade-investment-prod:europe-west1:postgresql-db-investment-prod-replica=tcp:2468'
alias proxy_fundamentals='./cloud_sql_proxy --instances=ft-discover-preprod:europe-west2:fundamentals-db=tcp:5432 -enable_iam_login'

alias test='node --inspect ./node_modules/.bin/jest --runInBand'
alias tst='node --inspect ../node_modules/.bin/jest --runInBand'
