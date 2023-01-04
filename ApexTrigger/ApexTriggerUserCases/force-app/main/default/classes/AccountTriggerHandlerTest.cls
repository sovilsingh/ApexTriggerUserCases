/**
 * assertEquals(expected, actual, msg)
 * 
 *  /// No required directly we can use from update dml list line 310 == Importnant 
 * 
 * /// https://github.com/alexed1/LightningFlowComponents/issues/367 - 
 * /// System.DmlException: Insert failed. First exception on row 0; first error: DUPLICATES_DETECTED, Use one of these records?:
 */
  
@isTest
public class AccountTriggerHandlerTest 
{

    @isTest
    Private static void updateRatingTest()
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

        //accmock.accountToReturn.add(accList);

        // AccountDOAMock accmock = new AccountDOAMock();
        // AccountTriggerHandler mock = new AccountTriggerHandler();
        // AccountTriggerHandler.accountDOAMockInstance  = accmock;
        Test.startTest();
         insert accList;
         //AccountTriggerHandler.updateRating(accList);
         //mock.updateRating(accList);
        Test.stopTest();
       
        List<Account> updateAccList = [Select Id, Rating From Account Where ID =: accList];
        //apply assert condition 
        
        //Checking that total 201 records are created or not
        System.assertEquals(201, accList.size());

        System.assertEquals(201, updateAccList.size());

        for(Account acc : updateAccList )
        {   //checking each records are created or not
           System.assertEquals('Hot', acc.Rating);
        }

         //  for(Account acc : accList )
       //    {   //checking each records are created or not
        //       System.assertEquals('Hot', acc.Rating);
        //   }


    }
    
    @isTest
    Private Static void CopyBillingToShippingTest()
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

        //AccountDOAMock accmock = new AccountDOAMock();
       // AccountTriggerHandler mock = new AccountTriggerHandler();
       // AccountTriggerHandler.accountDOAMockInstance  = accmock;

        Test.startTest();
        Insert accList;
        //mock.CopyBillingToShipping(accList);
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
    Private Static Void CreateRelatedAccountContactTest()
    {
       
        List<Account> accList = new List<Account>();

        for(Integer i=0;i<201;i++)
        {
          Account acc = new Account();
          acc.Name = 'Test'+i;
          accList.add(acc);
        }

       // AccountDOAMock accmock = new AccountDOAMock();
       // AccountTriggerHandler mock = new AccountTriggerHandler();
       // AccountTriggerHandler.accountDOAMockInstance  = accmock;

        Test.startTest();
        Insert accList;
        //mock.CreateRelatedAccountContact(accList);
       // List<Contact> conList =  accmock.getContactForCreateRelatedAccountContact(accList);
        Test.stopTest();
        
       
        List<Contact> conList = [Select Id, lastName, AccountId From Contact 
                                 Where AccountId IN : accList]; 
        
  
          System.assertEquals(201, conList.size());
        
          System.assertEquals(201, accList.size());

         
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
    Private static void CreateRelatedAccountOpportunityTest()
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
    Private static void CreateRelatedContactOrOpportunityOrBothTest()
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
         //System.assertEquals(conListToTest.size(),201);
        // System.assertEquals(oppListToTest.size(),201);
         for(Account acc: accList)
         {
           System.assertEquals(acc.Name,oppMapToTest.get(acc.id));
           System.assertEquals(acc.Name,ConMapToTest.get(acc.id));
         }
    }
    
    @isTest
    Private Static Void UpdateAccountDescriptionTest()
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
    Private Static void UpdateCopyBillingToShippingTest()
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
   Private static void BeforeupdateRatingTest()
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
   Private Static Void UpdateAccountPhoneToContactTest()
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
   Private Static Void UpdateAccountPhoneToContactSOQLTest()
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
   Private Static Void UpdateAccountBillingAddressToContactSOQLTest()
   {
       List<Account> accList = new List<Account>();

       for(Integer i=0;i<201;i++)
       {
          Account acc = new Account();
          acc.Name = 'Test Update'+i+1;
          acc.Phone = '7897897'+i+1;
          acc.BillingCity = 'Test'+i+1;
          acc.BillingCountry = 'Test'+i+1; 
          acc.BillingPostalCode = 'Test'+i+1; 
          acc.BillingState = 'Test'+i+1;
          acc.BillingStreet = 'Test'+i+1;
          accList.add(acc);
       }

        Test.startTest();
        // Insert accList;
        Database.DMLOptions dml = new Database.DMLOptions(); 
        dml.DuplicateRuleHeader.AllowSave = true; 
        List<Database.SaveResult> sr = Database.insert(accList, dml);

        List<Account> accListToUpdate = new List<Account>();
        
         for(Account acc : accList)
        {
                acc.BillingCity = 'Test';
                acc.BillingCountry = 'Test'; 
                acc.BillingPostalCode = 'Test'; 
                acc.BillingState = 'Test';
                acc.BillingStreet = 'Test';
                accListToUpdate.add(acc);
 
        } 

       

        update accListToUpdate;
        
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
      
   @isTest
   private static void getContactForUpdateAccountPhoneToContactTest()
   { 
    AccountDOAMock  contactDAOMock = new AccountDOAMock ();
    Contact testContact = new Contact();
    testContact.LastName = 'Doe';
    contactDAOMock.contactsToReturn.add(testContact);
    AccountTriggerHandler controller = new AccountTriggerHandler();
    AccountTriggerHandler.accountDOAInstance = contactDAOMock;
    Test.startTest();
        List<Contact> contacts = controller.getContactForUpdateAccountPhoneToContact(null);
    Test.stopTest();
 
    System.assertEquals(1, contacts.size(), 'The method should return a contact');
     }
    
   @isTest
   private static void getContactForUpdateAccountBillingAddressToContactTest()
   {
    AccountDOAMock  contactDAOMock = new AccountDOAMock ();
    Contact testContact = new Contact();
    testContact.LastName = 'Doe';
    contactDAOMock.contactsToReturn.add(testContact);
    AccountTriggerHandler controller = new AccountTriggerHandler();
    AccountTriggerHandler.accountDOAInstance = contactDAOMock;
    Test.startTest();
        List<Contact> contacts = controller.getContactForUpdateAccountBillingAddressToContact(null);
    Test.stopTest();
    System.assertEquals(1, contacts.size(), 'The method should return a contact');
  }
    
   @isTest
   private static void getContactForUpdateAccountPhoneToContactSOQLTest()
   {
    AccountDOAMock  contactDAOMock = new AccountDOAMock ();
    Account testContact = new Account();
    testContact.Name = 'Doe';
    contactDAOMock.accountToReturn.add(testContact);
    AccountTriggerHandler controller = new AccountTriggerHandler();
    AccountTriggerHandler.accountDOAInstance = contactDAOMock;
    Test.startTest();
    List<Account> accounts = controller.getContactForUpdateAccountPhoneToContactSOQL(null);
    Test.stopTest();
    System.assertEquals(1, accounts.size(), 'The method should return a Account');
  }
    
   @isTest
   private static void getContactUpdateAccountBillingAddressToContactSOQLTest()
   {
    AccountDOAMock  contactDAOMock = new AccountDOAMock ();
    Account testContact = new Account();
    testContact.Name = 'Doe';
    contactDAOMock.accountToReturn.add(testContact);
    AccountTriggerHandler controller = new AccountTriggerHandler();
    AccountTriggerHandler.accountDOAInstance = contactDAOMock;
    Test.startTest();
    List<Account> accounts = controller.getContactUpdateAccountBillingAddressToContactSOQL(null);
    Test.stopTest();
    System.assertEquals(1, accounts.size(), 'The method should return a Account');
  }
    
   @isTest
   private static void UpdateAccountToOpportunityByActiveFieldTest()
   {
       List<Account> accList = new List<Account>();
       for(Integer i = 0;i < 201;i++)
       {
        Account acc = new Account();
        acc.Name = 'Test'+i;
        acc.Active__c = 'Yes';
        accList.add(acc);
       }
       Test.startTest();
       Insert accList;
       for(Account acc : accList)
       {
           acc.Active__c = 'No';
       }
       update accList;
       Test.stopTest();
       List<Opportunity> oppListToTest = [Select Id, Name, StageName, AccountId From Opportunity 
                                          where AccountId IN : accList];
       System.assertEquals(201, oppListToTest.size());
       
       for(Opportunity opp : oppListToTest)
       {
           System.assertEquals('Closed Lost', opp.StageName);
       }    

    }
   
   @isTest
   Private static void PreventDeletionTest()
   {
       List<Account> accList = new List<Account>();
       for(Integer i = 0;i < 201;i++)
       {
        Account acc = new Account();
        acc.Name = 'Test'+i;
        acc.Active__c = 'Yes';
        accList.add(acc);
       }
       Test.startTest();
       Insert accList;
       Boolean exceptionThrown = false;
        try{
            delete accList;
        }
        catch(Exception ex)
        {
            exceptionThrown = true;
            Boolean expectedExceptionThrown = (ex.getMessage().contains('Active Account cannot be deleted'))? true : false;
            System.assertEquals(true, expectedExceptionThrown, ex.getMessage());
        }
            System.assertEquals(true, exceptionThrown,'No exception was thrown');
            Test.stopTest();
       
    }
    
    /**
   @isTest
   Private static void AccountUpdatePreventTest()
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
       List<Account> accListToUpdate = new List<Account>();
       for(Account acc : accList)
       {
          acc.Phone = '789654';
          accListToUpdate.add(acc);
       }
       Boolean exceptionThrown = false;
        try{
            update accListToUpdate;
        }
        catch(Exception ex)
        {
            exceptionThrown = true;
            Boolean expectedExceptionThrown = (ex.getMessage().contains('you cannot update the record which created in last 7 days'))? true : false;
            System.assertEquals(true, expectedExceptionThrown, ex.getMessage());
        }
            System.assertEquals(true, exceptionThrown,'No exception was thrown');
            Test.stopTest();
       
    }
   **/
    
   @isTest
   Private static void PreventDeletionLabelTest()
   {
       List<Account> accList = new List<Account>();
       for(Integer i = 0;i < 201;i++)
       {
        Account acc = new Account();
        acc.Name = 'Test'+i;
        acc.Active__c = 'Yes';
        accList.add(acc);
       }
       Test.startTest();
       Insert accList;
       Boolean exceptionThrown = false;
        try{
            delete accList;
        }
        catch(Exception ex)
        {
            exceptionThrown = true;
            Boolean expectedExceptionThrown = (ex.getMessage().contains('Active Account cannot be deleted'))? true : false;
            System.assertEquals(true, expectedExceptionThrown, ex.getMessage());
        }
            System.assertEquals(true, exceptionThrown,'No exception was thrown');
            Test.stopTest();
     }
}