trigger covidVaccinationUserDrive_trg on People__c (before insert) { 
    List<People__c> peoplList=Trigger.new;
    peopleNearestLocationcalc.getlocation(peoplList);
}