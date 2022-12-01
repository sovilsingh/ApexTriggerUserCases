/**
 * assertEquals(expected, actual, msg)
 */

@isTest
public  class AccountTriggerHandlerTest 
{
    
    @isTest
    public static void updateRatingTest()
    {
        //Create Sample Data for the Test
        //Create the List of Account
        List<Account> accList = new List<Account>();
        //Taking Loop in order to create Test Data 
        for(Integer i=0;i<201;i++)
        {   
            //Create Account class Object 
            Account acc = new Account();
            //Assigning the objects values
            acc.Name = 'Test'+i;
            acc.Industry = 'Energy';
            //adding all the object inside the list 
            accList.add(acc);
        }
        Test.startTest();
        insert accList;
        Test.stopTest();
       
        List<Account> updateAccList = [Select Id, Rating From Account Where ID =: accList];
        //apply assert condition 
        
        //Checking that total 201 records are created or not
        System.assertEquals(201, updateAccList.size());

        for(Account acc : updateAccList )
        {   //checking each records are created or not
            System.assertEquals('Hot', acc.Rating);
        }
    }
    
    @isTest
    public Static void CopyBillingToShippingTest()
    {
       
        List<Account> accList = new List<Account>();

        for(Integer i=0; i<201;i++)
        {
               Account acc = new Account();
               acc.Name = 'Test'+i;
               acc.CopyBillingToShipping__c = true;
               acc.BillingCity = 'Test'+i ;
               acc.BillingCountry = 'Test'+i; 
               acc.BillingPostalCode = 'Test'+i; 
               acc.BillingState = 'Test'+i;
               acc.BillingStreet = 'Test'+i;
               accList.add(acc);
        }
        Test.startTest();
        insert accList;
        Test.stopTest();

        List<Account> updateAccList = [Select Id, BillingCity, BillingCountry, 
                                       BillingPostalCode, BillingState, BillingStreet,
                                      ShippingCity, ShippingCountry, ShippingPostalCode,
                                      ShippingState, ShippingStreet From Account Where ID =: accList];

        System.assertEquals(201, updateAccList.size());

        for(Account acc : updateAccList )
        {   //checking each records are created or not
            System.assertEquals(acc.ShippingCity, acc.BillingCity);
            System.assertEquals(acc.ShippingCountry, acc.BillingCountry);
            System.assertEquals(acc.ShippingPostalCode, acc.BillingPostalCode);
            System.assertEquals(acc.ShippingState, acc.BillingState);
            System.assertEquals(acc.ShippingStreet, acc.BillingStreet);
        }

    }
    
    @isTest
    public Static Void CreateRelatedAccountContactTest()
    {
       
        List<Account> accList = new List<Account>();

        for(Integer i=0;i<201;i++)
        {
          Account acc = new Account();
          acc.Name = 'Test'+i;
          accList.add(acc);
        }

        Test.startTest();
        Insert accList;
        Test.stopTest();

        List<Contact> conList = [Select Id, lastName, AccountId From Contact 
                                 Where AccountId IN : accList];
  
        System.assertEquals(201, conList.size());


        Map<id,String> contactTestMap = new Map<Id,String>();
        for(Contact con : conList)
        {
            contactTestMap.put(con.AccountID,con.LastName);
        }
       
        for(Account acc : accList)
        {
            System.assertEquals(acc.Name,contactTestMap.get(acc.id));
        }
    }
    
    @isTest
    public static void CreateRelatedAccountOpportunityTest()
    {

       List<Account> accList = new List<Account>();
       
       for(Integer i = 0;i < 201;i++)
       {
        Account acc = new Account();
        acc.Name = 'Test'+i;
        accList.add(acc);
       }

       Test.startTest();
       Insert accList;
       Test.stopTest();

       List<Opportunity> oppListToTest = [Select Id, Name, AccountId From Opportunity 
                                          where AccountId IN : accList];

       System.assertEquals(oppListToTest.size(),201);

       Map<Id,String> oppMap = new Map<Id,String>();

       for(Opportunity opp : oppListToTest)
       {
        oppMap.put(opp.AccountID, opp.Name);
       }

       for(Account acc : accList)
       {
        System.assertEquals(acc.Name, oppMap.get(acc.id));
       }

    }
    
    @isTest
    public static void CreateRelatedContactOrOpportunityOrBothTest()
    {
         List<Account> accList = new List<Account>();

         for(Integer i=0;i<201;i++)
         {
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.New_Contact__c = True;
            acc.Active__c = 'Yes';
            acc.New_Opportunity__c = True;
            accList.add(acc);
         }

         Test.startTest();
         Insert accList;
         System.debug(accList.size());
         Test.stopTest();

         Set<id> accIds = new Set<ID>();
         for(Account acc: accList)
         {
             accIds.add(acc.id);
         }
         
         List<Contact> conListToTest = [Select ID, LastName, AccountID from contact where AccountID IN : accIds];

         System.debug(conListToTest.size());

         List<Opportunity> oppListToTest = [Select ID, Name, AccountID from Opportunity where AccountID IN : accIds];

         System.debug(oppListToTest.size());

         Map<Id,String> oppMapToTest = new Map<ID,String>();
         for(Opportunity opp : oppListToTest)
         {
           oppMapToTest.put(opp.AccountID,opp.Name);
         }

         Map<Id,String> ConMapToTest = new Map<ID,String>();
         for(Contact con : conListToTest)
         {
            ConMapToTest.put(con.AccountID,con.LastName);
         }

         System.assertEquals(accList.size(),201);
         System.assertEquals(conListToTest.size(),201);
         System.assertEquals(oppListToTest.size(),201);
         for(Account acc: accList)
         {
           System.assertEquals(acc.Name,oppMapToTest.get(acc.id));
           System.assertEquals(acc.Name,ConMapToTest.get(acc.id));
         }
    }
    
    @isTest
    Public Static Void UpdateAccountDescriptionTest()
    {
        List<Account> accList = new List<Account>();
        List<Account> accListToUpdate = new List<Account>();

        for(Integer i=0;i<201;i++)
        {
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Phone = '788888'+i;
            accList.add(acc);
        }

        //Test.startTest();
        Insert accList;
       // Test.stopTest();

        List<Account> accListToTest = [Select ID, Phone, Description From Account where ID IN : accList];
         
        for(Account acc : accList)
        {
            Acc.Phone = '99999';
            accListToUpdate.add(acc);
        }

         Test.startTest();
         Update accListToUpdate;
         Test.stopTest();
         
         List<Account> accListToTestAfterUpdate = [Select ID, Phone, Description From Account where ID IN : accListToUpdate];

         System.assertEquals(accListToTest.size(),201);
         System.assertEquals(accListToTestAfterUpdate.size(),201);
         

         Map<id,String> accListUpdateNewMap = new Map<Id,String>();
         Map<id,String> accListUpdateOldMap = new Map<Id,String>();

         for(Account acc : accListToTest)
         {
            accListUpdateOldMap.put(acc.id,acc.Phone);
         }

         for(Account acc : accListToTestAfterUpdate)
         {
            accListUpdateNewMap.put(acc.id,acc.Phone);
         }

         for(Account acc : accListToTestAfterUpdate)
         {
            System.assertEquals(acc.description,'Phone is Updated!'+' and Old Value: '+ accListUpdateOldMap.get(acc.id)+' & New Value : '+accListUpdateNewMap.get(acc.id));
         }
    }


     @isTest
    public Static void UpdateCopyBillingToShippingTest()
    {
       
        List<Account> accList = new List<Account>();

        for(Integer i=0; i<201;i++)
        {
               Account acc = new Account();
               acc.Name = 'Test'+i;
               acc.CopyBillingToShipping__c = true;
               acc.BillingCity = 'Test'+i ;
               acc.BillingCountry = 'Test'+i; 
               acc.BillingPostalCode = 'Test'+i; 
               acc.BillingState = 'Test'+i;
               acc.BillingStreet = 'Test'+i;
               accList.add(acc);
        }
       
        insert accList;
       
        List<Account> updateAccountAfterInsert = new List<Account>();
        for(Account acc : accList)
        {
            acc.CopyBillingToShipping__c = false;
            updateAccountAfterInsert.add(acc);
        }

        Update updateAccountAfterInsert;

        List<Account> updateAccListToTest = new List<Account>();

        for(Account acc : accList)
        {
               acc.Name = 'Test After Update';
               acc.CopyBillingToShipping__c = true;
               acc.BillingCity = 'Test After Update' ;
               acc.BillingCountry = 'Test After Update'; 
               acc.BillingPostalCode = 'Test After Update'; 
               acc.BillingState = 'Test After Update';
               acc.BillingStreet = 'Test After Update';
               updateAccListToTest.add(acc);
        }
        
        Test.startTest();
        Update updateAccListToTest;
        Test.stopTest();
        
        List<Account> updateAccList = [Select Id, BillingCity, BillingCountry, 
                                       BillingPostalCode, BillingState, BillingStreet,
                                      ShippingCity, ShippingCountry, ShippingPostalCode,
                                      ShippingState, ShippingStreet From Account Where ID =: updateAccListToTest];

        System.assertEquals(201, updateAccList.size());

        for(Account acc : updateAccList )
        {   //checking each records are created or not
            System.assertEquals(acc.ShippingCity, acc.BillingCity);
            System.assertEquals(acc.ShippingCountry, acc.BillingCountry);
            System.assertEquals(acc.ShippingPostalCode, acc.BillingPostalCode);
            System.assertEquals(acc.ShippingState, acc.BillingState);
            System.assertEquals(acc.ShippingStreet, acc.BillingStreet);
        }

    }
}