# Covid19-Vaccination-Drive---challenge

How it Works :

      step 1: Upload the attached file 'People.csv' in to people object using data import wizard.
             setup -- Data import wizard --Custom Object:people -- Add New Records -- match by 'Name' -- upload fiel 'People.csv' -- done
      step 2: Add the lightning web page component to any of the flexi page.
             app launcher -- sales -- find Account tab -- click on any of the account record -- edit page from setup -- drag and drop custom component 'vaccinationDrive'
      step 3: You will be able to see corresponding nearest drive location for each of the people corresponding for the shared metadata .
                        I have attached the output screen Image as well on basis of age priority - 'Output_Screen.jpg'


CV Drive Technical Document

      Contents:
       (1).	Description
       (2).	System Design
             a Objects & Relationships
             b JSON and Field Mapping
            c Flow Diagram
       (3).	Solution and Implementation
       (4).	Tools and technologies used


       1.	Use Case Description :
           This use-case is intended for the individuals to be contacted to their nearest drive location as per 
          Government guidelines awaiting for their COVID-19 vaccination. Details of people are provided in a JSON-encoded text
          file and need to output each customer per line along with the nearest vaccination center.
       2.	System Design
          Objects that Covid – 19 vaccination majorly deals with.
              a.	People : : It is the core object to hold details of individuals awaiting for their vaccinations.
                    Object :
                      Label – People
                      Api name – People__c

                    Cutom fields created :
                      People Name – name
                      Age – Age__c
                      Latitude - Latitude__c
                      Longitude - Longitude__c
                      Distance – Distance__c
                      Drive Location - Drive_Location__c

                    As the provided data is of JSON file ,convert it to CSV and load it with Data Import Wizard to a newly created custom object: People(People__c).
                    Mapping : JSON file     to     People Object
                                  Name - Name
                                  Age – Age__c
                                  Latitude – Latitude__c
                                  Longitude – Longitude__c
              b.	Drive Location : It is a custom meta data to hold details of vaccination centers .
                       Label – Drive Location
                        Api - Drive_Location__mdt

    3.	Solution & Implementation
              Implemented a trigger: covidVaccinationUserDrive_trg on People object which will be triggered whenever a new record has been inserted 
              into the sf system.And on the handler class we are iterating through each of the drive locations present on Drive Location metadata to find
              the nearest location of each individuals.Distance between two geo location is calculated based on Great-circle distance formula.
              
              Here in handler class we are finding the least distance and nearest Drive location for the individuals and are updated to corresponding 
              fields Distance & Drive Location present on people object. 
                      Trigger : covidVaccinationUserDrive_trg
                      Class : peopleNearestLocationcalc
                      Test class : peopleNearestLocationcalc_Test
               On successful insert, we have designed a output screen to show the individuals along with its  age and corresponding nearest location based on
               their age priority .the component has been designed with Lightning Web Component and server-side controllers and can be placed either on
               lightning App page ,Home page or  Record page.
                      Html : vaccinationDrive.html
                      Jscript : vaccinationDrive.js
                      Apex Controller :  TS_covidVaccinationContactDrive
                      Meta data : vaccinationDrive.metadata
                      Test Class : TS_covidVaccinationContactDriveTest
                

      4.	Tools and technologies used
                a.	Intellij IDEA Community – for designing Lightning Web Components.
                b.	Data import Wizard – an in-built tool of salesforce to import data into related objects and metadata
