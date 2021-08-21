@IsTest
public class TS_covidVaccinationContactDriveTest {
    @TestSetup static void testData(){
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
            List<People__c> peopleList1 = TS_covidVaccinationContactDrive.getPeopleList();
            try {
                System.debug('test People ...'+peopleList[0].Name);
                System.debug('test people ...'+peopleList1[0].Name);
            } catch(DmlException ex) {
                System.debug('Exception::'+ex);
            }
        }
        Test.stopTest();
    }
}