#
#
# Author: Aniruddha Gokhale
# CS4287-5287: Principles of Cloud Computing, Vanderbilt University
#
# Created: Sept 6, 2020
#
# Purpose:
#
#    Demonstrate the use of Kafka Python streaming APIs.
#    In this example, demonstrate Kafka streaming API to build a consumer.
#

import os   # need this for popen
import time # for sleep
from kafka import KafkaConsumer  # consumer of events
import couchdb

# We can make this more sophisticated/elegant but for now it is just
# hardcoded to the setup I have on my local VMs

couch = couchdb.Server('http://admin:password@129.114.27.202:30003/')
try:
    db = couch.create('assignment3')
except:
    db = couch['assignment3']

# acquire the consumer
# (you will need to change this to your bootstrap server's IP addr)
consumer = KafkaConsumer (bootstrap_servers="129.114.25.102:30000")

# subscribe to topic
consumer.subscribe(topics=["utilizations"])
print("subscribed to utilizations")
# we keep reading and printing
for msg in consumer:
    # what we get is a record. From this record, we are interested in printing
    # the contents of the value field. We are sure that we get only the
    # utilizations topic because that is the only topic we subscribed to.
    # Otherwise we will need to demultiplex the incoming data according to the
    # topic coming in.
    #
    # convert the value field into string (ASCII)
    #
    # Note that I am not showing code to obtain the incoming data as JSON
    # nor am I showing any code to connect to a backend database sink to
    # dump the incoming data. You will have to do that for the assignment.

    output = {'timestamp': time.time(), 'contents of top': msg.value.decode(encoding="ascii")}
    db.save(output)
    print (str(msg.value, 'ascii'))

# we are done. As such, we are not going to get here as the above loop
# is a forever loop.
consumer.close ()
