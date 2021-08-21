@IsTest
public class peopleNearestLocationcalc_Test {
    @TestSetup static void testData(){
        List<Drive_Location__mdt> dlList = new List<Drive_Location__mdt>();
        Drive_Location__mdt dl = new Drive_Location__mdt();
        dl.Location__c = 'City Hall Cork';
        dl.Latitude__c = 51.89742637092438;
        dl.Longitude__c = -8.465763459121026;
        dlList.add(dl);
        List<People__c> peoList = new List<People__c>();
        People__c pp = new People__c();
        pp.Name = 'test';
        pp.Age__c = 50;
        pp.Latitude__c = '53.09402405506328';
        pp.Longitude__c = '-8.020019531250002';
        pp.Distance__c = 0;
        pp.Drive_Location__c = 'test';
        peoList.add(pp);
        insert peoList;  
    }
    public static testMethod void SendcovidVaccinationContactDrive() {
        Test.startTest();
        List<People__c> peopleList = [SELECT Name ,Age__c ,Latitude__c ,Longitude__c
                                      FROM People__c LIMIT 1];
        if(!peopleList.isEmpty()){
            peopleNearestLocationcalc.getlocation(peopleList);
            try {     
                System.debug('test org');
            } catch(DmlException ex) {
                System.debug('Exception::'+ex);
            }
        }
        Test.stopTest();
    }
}