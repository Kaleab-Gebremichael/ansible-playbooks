from pyspark.sql import SparkSession
from pyspark.sql import Row
from pyspark.sql import SQLContext
from pyspark.sql.types import *
from pyspark import SparkContext
import couchdb
import json

couch = couchdb.Server('http://admin:password@129.114.27.202:30003/')

sc = SparkContext()
sqlContext = SQLContext(sc)
db = couch['assignment4']
i = 1000

schemaString = "id timestamp value prop plug_id household_id house_id"
fields = [StructField(field_name, StringType(), True) for field_name in schemaString.split()]

all_rows = []

for row in db.view('_all_docs', include_docs=True):
#	cur_row = row['id']
	x = json.dumps(row['doc'][str(i)])
	x = x[3:-3]
	cur_list = json.loads(x)
	all_rows.append(cur_list)

	i += 1000

flat_list = [item for sublist in all_rows for item in sublist]
rdd = sc.parallelize(flat_list)
data = rdd.map(lambda x: Row(id=x[0], timestamp=x[1], value=float(x[2]), prop=x[3], plug_id=x[4], household_id=x[5], house_id=x[6]))

#schemaString = "id timestamp value prop plug_id household_id house_id"
#fields = [StructField(field_name, StringType(), True) for field_name in schemaString.split()]
schema = StructType([
	StructField("id", IntegerType(), True),
	StructField("timestamp", IntegerType(), True),
	StructField("value", DoubleType(), True),
	StructField("property", IntegerType(), True),
	StructField("plug_id", IntegerType(), True),
	StructField("household_id", IntegerType(), True),
	StructField("house_id", IntegerType(), True)])

energy_df = sqlContext.createDataFrame(data, schema)
#energy_df.show(truncate=False)
#required_data = energy_df.groupBy("house_id", "household_id", "plug_id").where(col("property") == 0).mean("value").where(col("property") == 1).mean("value").collect()

required_data = energy_df.groupBy("house_id", "household_id", "plug_id", "property").mean("value").collect()
#print(required_data)

try:
    db = couch.create('result')
except:
    db = couch['result']

output = {'result' : str(required_data)}
db.save(output)
