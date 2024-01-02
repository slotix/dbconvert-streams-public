### Install Git
```
sudo yum install git -y
```
Add private certificate to get access to github to `~/.ssh` directory.

```
 chmod 0600 id_rsa
```
Clone the repo with examples:
```
git clone git@github.com:slotix/dbconvert-streams-public.git
```
### Create MySQL instance.
Follow the steps described here. 
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.CreatingConnecting.MySQL.html

Change settings for replication 
....

### Install MySQL Client.

Most Linux distributions include the MariaDB client instead of the Oracle MySQL client. To install the MySQL command-line client on most RPM-based Linux distributions, including Amazon Linux 2, run the following command:


```bash
sudo yum install mariadb
```

More info at [Here](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ConnectToInstance.html)


```bash
mysql -h mysql-database.cssv1n52dnnd.eu-central-1.rds.amazonaws.com -u admin -p12345678
```

### Create PostgreSQL Instance.
https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ConnectToPostgreSQLInstance.html#USER_ConnectToPostgreSQLInstance.psql



### Install PostgreSQL Client.

```
sudo amazon-linux-extras install postgresql14
```
```
psql \
   --host=postgres-database.cssv1n52dnnd.eu-central-1.rds.amazonaws.com \
   --port=5432 \
   --username=postgres \
   --password \
   --dbname=postgres 
```

```
curl --request POST --url http://127.0.0.1:8020/api/v1/streams\?file=./mysql2pg.json
```


1. Add mysqldump to the source-reader docker image.  
1. Stay on version of MySQL 8.0.31
To get rid of error: "mysqldump: Couldn't execute 'FLUSH TABLES WITH READ LOCK': Access denied for user 'admin'@'%' (using password: YES) (1045)"
https://bugs.mysql.com/bug.php?id=109685
1. Skip master data if we have no privilege to dump the data with it in some cloud MySQL (AWS).

[The official AWS explanation](https://aws.amazon.com/premiumsupport/knowledge-center/mysqldump-error-rds-mysql-mariadb) seems to be that because they do not allow super privileges to the master user or GLOBAL READ LOCK the mysqldump fails if the --master-data option is set.

So to make it work `--master-data` should be omitted when calling mysqldump.

``` mysqldump --host=database-3.cssv1n52dnnd.eu-central-1.rds.amazonaws.com --port=3306 --user=admin --password=12345678  --single-transaction --skip-lock-tables --compact --skip-opt --quick --no-create-info --skip-extended-insert --skip-tz-utc --hex-blob --default-character-set=utf8 --column-statistics=0 source products
```

  canalCfg.Dump.SkipMasterData = true
