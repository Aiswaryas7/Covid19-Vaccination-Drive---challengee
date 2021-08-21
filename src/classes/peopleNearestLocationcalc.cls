public class peopleNearestLocationcalc {
    public static void getlocation(List<People__c> people) {
        List<People__c> peoplList = new List<People__c>();
        Map<People__c,Drive_Location__mdt> people_mindis = new Map<People__c,Drive_Location__mdt>();
        for(People__c lc:people){
            peoplList.add(lc);
        }
        List<Drive_Location__mdt> listq = new List<Drive_Location__mdt>([SELECT Location__c,Longitude__c,Latitude__c FROM Drive_Location__mdt]);
        for(People__c lc:peoplList){
            Map<Drive_Location__mdt,Decimal> samplevalues = new Map<Drive_Location__mdt,Decimal>();
            Map<Decimal,Drive_Location__mdt> disCoordinates = new Map<Decimal,Drive_Location__mdt>(); // min distance , coordinates
            for(Drive_Location__mdt ss:listq){
                Decimal longitude1 = Decimal.valueOf(lc.Longitude__c);
                Decimal latitude1 = Decimal.valueOf(lc.Latitude__c);
                if(lc.Name <> null)
                { Decimal distance = 0;
                 distance = calculateDistance(latitude1,longitude1,ss.Latitude__c,ss.Longitude__c);
                 samplevalues.put(ss,distance);//Maintain distance , location and coordinates
                 disCoordinates.put(distance,ss);
                 Decimal leastdistance = calculateleastdistance(samplevalues);
                 System.debug('least distance coordinates...'+disCoordinates.get(leastdistance));//get the coordinates of least distance
                 people_mindis.put(lc,disCoordinates.get(leastdistance));//person and location
                 lc.Distance__c = leastdistance.setScale(2);
                 lc.Drive_Location__c = disCoordinates.get(leastdistance).Location__c;
                }
            }
        }
    }
    public static Decimal calculateDistance(Decimal lat1, Decimal lon1, Decimal lat2, Decimal lon2){
        Double Radius = 6371.00;
        Double dLat = toRadians(lat2 - lat1);
        Double dLon = toRadians(lon2 - lon1);
        Double a = Math.sin(dLat/2) * Math.sin(dLat/2) + Math.cos(toRadians(lat1)) * Math.cos(toRadians(lat2)) *
            Math.sin(dLon/2) * Math.sin(dLon/2);
        Double c = 2 * Math.asin(Math.sqrt(a));
        System.debug('Distance to drive'+Radius * c * .62);
        return Radius * c * .62;
    }
    private static Double toRadians(Decimal degree){
        Double res = degree * 3.1415926 / 180;
        return res;
    }
    public static Decimal calculateleastdistance(Map<Drive_Location__mdt,Decimal> samplevaluesMap){
        List<Decimal> samplevalues = samplevaluesMap.values();
        Decimal minvalue = samplevalues[0];
        for (Integer i =0;i<samplevalues.size();i++)
        {
            if( samplevalues[i] < minvalue)
            {
                minvalue = samplevalues[i];
            }
            System.debug('the min value is'+minvalue);
        }
        return minvalue;
    }
    
}