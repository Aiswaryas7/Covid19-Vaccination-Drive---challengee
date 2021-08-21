/**
 * Created by Aiswarya.S on 8/19/2021.
 */

public with sharing class TS_covidVaccinationContactDrive {

   @AuraEnabled(Cacheable=true)
    public static List<People__c> getPeopleList() {

        return [SELECT  Name,Age__c,Drive_Location__c,Distance__c
                FROM People__c ORDER BY Age__c DESC ];
    }
}