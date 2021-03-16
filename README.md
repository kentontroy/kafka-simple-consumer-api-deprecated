## This GetOffsetShell Docker image uses the older Simple Consumer APIs written in Scala <br>
**A previous customer wanted to reuse that older API but with added support for SASL_PLAIN authentication** <br>
**and with more functinality for regex topic name matching. The customer could not adjust their existing Spring** <br>
**Framework to take advantage of the newer Kafka Consumer Group APIs** <br>

**The Github repo only provides a Docker image from pre-built Scala binaries. It does not enable you to** <br>
**rebuild the source code. The source code is zipped and provided as a reference** <br>
- Support added for SASL <br>
- Support added viewing offsets by specifying multiple topic names <br>
- Support added viewing offsets by specifying a regex expressions for the topics desired <br>

**WARNING: uses deprecated features that are not supported as part of the core branch** <br>
**Addresses KIPs ==> Kafka-3355 and Kafka-5235** <br>

Create the Dockerfile on your local host <br>
```
cd docker 
./Dockerfile.sh
```

Build the image<br>
```
docker build -t offsetshell:latest .<br>
```

The image exposes a working directory structure as: <br>
```
/usr/local/src/offsetshell/ 
/usr/local/src/offsetshell/bin 
/usr/local/src/offsetshell/depends
```

Run the image specifying the Kafka bootstrap URL and port in your environment <br>
```
docker run --env BOOTSTRAP_SERVER=192.168.1.230:9093 --network=host -it offsetshell:latest /bin/bash 
```

nano is installed in the image to support vi editing <br>
Change the GetOffsetShell.sh script to reflect however you want to run it, per below <br>
An example JAAS file called sasl.properties is provided. <br>

```
docker-container@12:20:51:$ ./GetOffsetShell.sh 
Example usage: 

java -cp ${LIBS} kafka.tools.GetOffsetShell 
                      --properties <JAAS security configuration> 
                      --broker-list <bootstrap servers with ports> 
                      --time <offset timestamp> 
                      --topic topic1 
java -cp ${LIBS} kafka.tools.GetOffsetShell 
                      --properties <JAAS security configuration> 
                      --broker-list <bootstrap servers> 
                      --time <offset timestamp> 
                      --topic topic1,topic2,topic3,... 
java -cp ${LIBS} kafka.tools.GetOffsetShell 
                      --properties <JAAS security configuration> 
                      --broker-list <bootstrap servers> 
                      --time <offset timestamp> 
                      --topic-regex <regular expression> 
                      --zookeeper <zookeepr url with port> 

An interactive shell for getting consumer offsets. 
Option                                 Description 
------                                 ----------- 
--broker-list <String: hostname:       REQUIRED: The list of hostname and    
  port,...,hostname:port>                port of the server to connect to.   
--help <String: help>                  OPTIONAL: view usage information and  
                                         examples                            
--partitions <String: partition ids>   OPTIONAL: comma separated list of     
                                         partition ids. If not specified, it 
                                         will find offsets for all partitions
                                         (default: )                         
--properties <String: command config   OPTIONAL: Property file containing    
  property file>                         configs to be passed to Admin Client.
--time <Long: timestamp/-1(latest)/-2  REQUIRED: timestamp of the offsets     
  (earliest)>                            before that                          
--topic <String: topic>                REQUIRED if not using --topic-regex    
                                         Specify one-to-many topics in a      
                                         comma-delimited list to get offsets  
                                         from.                                
--topic-regex <String: Regular         REQUIRED if not using --topic Regular  
  Expression>                            expression for topic filtering       
--zookeeper <String: Zookeeper URL>    REQUIRED if using --topic-regex        
                                         Zookeeper URL                        
```
