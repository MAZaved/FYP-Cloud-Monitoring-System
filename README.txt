 My final year project involved researching and creating a free and open source cloud monitoring system that allowed users to download and connect to their own cloud environment (OpenStack, AWS etc.). This application then allowed the user to create and configure cloud monitoring tools, drill down into the data and produce real time and static graphs to represent data, along with a host of other functionality. The end product provided a highly in intuitive, configurable and lightweight solution to cloud monitoring systems. This project was also awarded the best open source project by IBM.
 

-----Michael Mullarkey 112457292-------
-----Instructions for Setup----------

- Download & install Java 8

- Download the CloudMonitoring Package and import into eclipse

- Import the JRE 1.8 if needed

- To setup databases:
CloudMonitoring -> src -> database -> DbClass.java
inside the DbClass.java set the varaibles below with your own details

private static final String HOST  
private static final String DATABASE  
private static final String USERNAME  
private static final String PASSWORD 

CloudMonitoring -> src
Open and edit the hibernate.cfg file and fill our own database details

- Then find the file INFRESOURCEMETRICS.sql and load it into your database. This 
data is used for the static graph

- The rest of the setup is self contained

------For running locally----------

- Tomcat 8 was used throughout development

- Download and import Tomcat 8 into eclipse (this will create a servers project, which manages your servers config files etc)

- Eclipse will run tomcat once the project is compiled

- Tomcat will then host the web content (.jsp .html etc) files locally
