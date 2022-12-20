@isTest
public with sharing class TestDataFactory {
    
    Static integer lastIdnumber = 0;
    
    public static User  getUser(){
        
        Profile profileId = [select id from profile where name = 'Standard User'];
        User user = new User(id = getFakeId(user.SObjectType),
                             FirstName = 'Bruce',
                             LastName = 'Lee',
                             Alias = 'lee',
                             Email = 'BruceLee@gmail.com',
                             UserName = 'BruceLee12@test.org',
                             profileId = profileId.Id,
                             EmailEncodingKey = 'UTF-8',
                             TimeZoneSidKey = 'GMT',
                             LocaleSidKey='en_US',
                             LanguageLocaleKey='en_US');
                            // Favorite_color__c = 'Green'
                            
        return user;
    }
    
    public static String getFakeId(schema.SObjectType s_Object)
    {
        String lastNumber = String.valueOf(lastIdnumber++);
        String generateId = s_Object.getDescribe().getKeyPrefix() + '0'.repeat(12-lastNumber.length()) + lastNumber;
        return generateId;
    }
    
    public static List<Account> getDeletedAccountCheck(List<Account> accList){   
        return [Select ID, Name From Account Where ID IN : accList];
    }
}