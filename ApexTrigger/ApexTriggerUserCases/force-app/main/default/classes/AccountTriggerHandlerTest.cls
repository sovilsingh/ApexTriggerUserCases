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
    public Static void CopyBillingToShipping()
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
}