@isTest
public  class AccountTriggerHandlerTest 
{
    
    @isTest
    public static void updateRatingTest()
    {
        //Create Sample Data for the Test
        //Create the List of Account
        List<Account> accLists = new List<Account>();
        //Taking Loop in order to create Test Data 
        for(Integer i=0;i<201;i++)
        {   
            //Create Account class Object 
            Account acc = new Account();
            //Assigning the objects values
            acc.Name = 'Test'+i;
            acc.Industry = 'Energy';
            //adding all the object inside the list 
            accLists.add(acc);
        }
        Test.startTest();
        insert accLists;
        Test.stopTest();
       
        List<Account> updateAccList = [Select Id, Rating From Account Where ID =: accLists];
        //apply assert condition 
        
        //Checking that total 201 records are created or not
        System.assertEquals(201, updateAccList.size());

        for(Account acc : updateAccList )
        {   //checking each records are created or not
            System.assertEquals('Hot', acc.Rating);
        }
    }
}