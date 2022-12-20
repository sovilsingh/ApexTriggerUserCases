@isTest
private class AccountControllerDOATest {
    @isTest(SeeAllData=true)
    private static void getAccountsDoaTest(){
        AccountController controller = new AccountController();
        Test.startTest();
          List<Account> accounts = controller.getAccounts();
        Test.stopTest();
        System.assertEquals(10, accounts.size(),'Not Getting Record Limit upto 10');
    }

    @isTest
     private static void createAccountsDoaTest(){
        List<Account> accList = new List<Account>(); 
        Account testAccount = new Account();
        testAccount.Name = 'Test Name';
        accList.add(testAccount);
        
        AccountController controller = new AccountController();
        
        Test.startTest();
        List<Account> accounts = controller.createNewAccounts(accList);
        Test.stopTest();      
        System.AssertEquals(1, accounts.size(), 'Not Create Record Limit upto 1');
    }

    @isTest
     private static void updateOldAccountsDoaTest(){
        List<Account> accList = new List<Account>(); 
        Account testAccount = new Account();
        testAccount.Name = 'Test Name';
        accList.add(testAccount);
        
        AccountController controller = new AccountController();
        
        Test.startTest();
        Insert accList;
        List<Account> accounts = controller.updateOldAccounts(accList);
        Test.stopTest();      
        System.AssertEquals(1,accounts.size(), 'Not Updated Record Limit upto 1');
    }

    @isTest
    private static void deleteOldAccountsDoaTest(){
       List<Account> accList = new List<Account>(); 
       Account testAccount = new Account();
       testAccount.Name = 'Test Name';
       accList.add(testAccount);
       
       AccountController controller = new AccountController();
       
       Test.startTest();
       Insert accList;
       List<Account> accounts = controller.deleteOldAccounts(accList);
       Test.stopTest();
       List<Account> accListTOCheck = TestDataFactory.getDeletedAccountCheck(accList);
       System.AssertEquals(0,accListTOCheck.size(), 'Not Deleted Record Limit upto 1');
   }
   
}