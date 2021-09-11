# Car Crashes Prediction -- Investigation of Traffic in Chicago Area

The project aims to providing assistance to the decision-making processes of different parties using the car crashes data in Chicago from 2017 till mid 2020.

The raw data consists of 3 tables storing the information related to crashes, people and vehicle respectively.

Before building of databases, the data are examined in OpenRefine to ensure there is no severe data quality issue.

After that, the relational database was constructed and loaded to Google Cloud Platform which facilitates data access between group members. The relational database was used to store the raw data which is connected by the ‘crash_record_id’.

The raw data was stored on GCP and loaded into the database directly on GCP.

To facilitate data analysis, a dimensional model should be designed. After the dimensional model has been created using MySQL Workbench, it is loaded to GCP and the data was called from the relational model and inserted in the dimensional model through DML.

After finishing the database construction and data loading, the data analysis was carried out using multiple tools including Python, R and Tableau. And the data was queried from GCP.

The visualization part was conducted to better support the decision-making process of all the parties. And every visualization used is aimed to solve certain business problem or provide recommendations to different parties.

The file included in this project includes: DML file, DDL file, Python and R script as well as Tableau dashboard.