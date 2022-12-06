/**
 * assertEquals(expected, actual, msg)
 * 
 *  /// No required directly we can use from update dml list line 310 == Importnant 
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

        Test.startTest();
        Insert accList;
       // Test.stopTest();

        List<Account> accListToTest = [Select ID, Phone, Description From Account where ID IN : accList];
         
        for(Account acc : accList)
        {
            Acc.Phone = '99999';
            accListToUpdate.add(acc);
        }

        // Test.startTest();
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
       
        Test.startTest();
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
        
       // Test.startTest();
        Update updateAccListToTest;
        Test.stopTest();
        
        /// No required directly we can use from update dml list line 310 == Importnant 
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


    @isTest
    public static void BeforeupdateRatingTest()
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
          //  acc.Industry = 'Energy';
            //adding all the object inside the list 
            accList.add(acc);
        }
        
        Test.startTest();
        Insert accList;
       
        for(Account acc : accList)
        {
            acc.Industry = 'Energy';
        }
       
        Update accList;
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
    Public Static Void UpdateAccountPhoneToContactTest()
    {
       List<Account> accList = new List<Account>();

       for(Integer i=0;i<201;i++)
       {
          Account acc = new Account();
          acc.Name = 'Test'+i;
          acc.Phone = '7897897'+i;
          accList.add(acc);
       }

        Test.startTest();
        Insert accList;

         for(Account acc : accList)
        {
            acc.Phone = '987987';
        }

        update accList;
        Test.stopTest();

        List<Contact> conList = [Select ID, Phone, AccountId From Contact Where AccountID IN : accList];

        Map<Id,String> conMap = new Map<Id,String>();

        for(Contact con : conList)
        {
            conMap.put(con.AccountID, con.Phone);
        }

        System.assertEquals(201,accList.size());
        System.assertEquals(201,conList.size());

        for(Account acc : accList)
        {
            System.assertEquals(acc.Phone, conMap.get(acc.ID));
        }
    }

    @isTest
    Public Static Void UpdateAccountPhoneToContactSOQLTest()
    {
       List<Account> accList = new List<Account>();

       for(Integer i=0;i<201;i++)
       {
          Account acc = new Account();
          acc.Name = 'Test'+i;
          acc.Phone = '7897897'+i;
          accList.add(acc);
       }

        Test.startTest();
        Insert accList;

         for(Account acc : accList)
        {
            acc.Phone = '987987';
        }

        update accList;
        Test.stopTest();

        List<Contact> conList = [Select ID, Phone, AccountId From Contact Where AccountID IN : accList];

        Map<Id,String> conMap = new Map<Id,String>();

        for(Contact con : conList)
        {
            conMap.put(con.AccountID, con.Phone);
        }

        System.assertEquals(201,accList.size());
        System.assertEquals(201,conList.size());

        for(Account acc : accList)
        {
            System.assertEquals(acc.Phone, conMap.get(acc.ID));
        }

    }


    @isTest
    Public Static Void UpdateAccountBillingAddressToContactSOQLTest()
    {
       List<Account> accList = new List<Account>();

       for(Integer i=0;i<201;i++)
       {
          Account acc = new Account();
          acc.Name = 'Test';
          acc.Phone = '7897897';
          acc.BillingCity = 'Test';
          acc.BillingCountry = 'Test'; 
          acc.BillingPostalCode = 'Test'; 
          acc.BillingState = 'Test';
          acc.BillingStreet = 'Test';
          accList.add(acc);
       }

        Test.startTest();
        Insert accList;

         for(Account acc : accList)
        {
            for(Integer i=0;i<201;i++)
            {
                acc.Name = 'Test'+i;
                acc.Phone = '7897897'+i;
                acc.BillingCity = 'Test'+i ;
                acc.BillingCountry = 'Test'+i; 
                acc.BillingPostalCode = 'Test'+i; 
                acc.BillingState = 'Test'+i;
                acc.BillingStreet = 'Test'+i;
            }
            
        }

        update accList;
        Test.stopTest();

        

        List<Contact> conList = [Select ID, Phone, AccountId,  MailingCity, MailingCountry, MailingPostalCode,
        MailingState, MailingStreet From Contact Where AccountID IN : accList];

        Map<Id,String> conMapMailingCity = new Map<Id,String>();
        Map<Id,String> conMapMailingCountry = new Map<Id,String>();
        Map<Id,String> conMapMailingPostalCode = new Map<Id,String>();
        Map<Id,String> conMapMailingState = new Map<Id,String>();
        Map<Id,String> conMapMailingStreet = new Map<Id,String>();

        for(Contact con : conList)
        {
            conMapMailingCity.put(con.AccountID, con.MailingCity);
            conMapMailingCountry.put(con.AccountID, con.MailingCountry);
            conMapMailingPostalCode.put(con.AccountID, con.MailingPostalCode);
            conMapMailingState.put(con.AccountID, con.MailingState);
            conMapMailingStreet.put(con.AccountID, con.MailingStreet);
        }

        System.assertEquals(201,accList.size());
        System.assertEquals(201,conList.size());

        for(Account acc : accList)
        {
            System.assertEquals(acc.BillingCity, conMapMailingCity.get(acc.ID));
            System.assertEquals(acc.BillingCountry, conMapMailingCountry.get(acc.ID));
            System.assertEquals(acc.BillingPostalCode, conMapMailingPostalCode.get(acc.ID));
            System.assertEquals(acc.BillingState, conMapMailingState.get(acc.ID));
            System.assertEquals(acc.BillingStreet, conMapMailingStreet.get(acc.ID));
        }

    }
}