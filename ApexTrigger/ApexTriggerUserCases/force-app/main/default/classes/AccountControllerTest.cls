@isTest
private class AccountControllerTest {
     
    @isTest
    private static void getAccountsTest(){
        AccountControllerMock mock = new AccountControllerMock();
        Account testAccount = new Account();
        mock.accountsToReturn.add(testAccount);
        
        AccountController controller = new AccountController();
        AccountController.accountDoaInstance = mock;
        
        Test.startTest();
          List<Account> accounts = controller.getAccounts();
        Test.stopTest();  
    }
    
     @isTest(SeeallData=True)
    private static void getAccountsDoaTest(){
        AccountController controller = new AccountController();
        Test.startTest();
          List<Account> accounts = controller.getAccounts();
        Test.stopTest();
        System.assertEquals(10, accounts.size());
    }
    
    
     @isTest
    private static void CreateNewAccountsTest(){
        AccountControllerMock mock = new AccountControllerMock();
        Account testAccount = new Account();
        testAccount.Name = 'Test Name';
        testAccount.Name = TestDataFactory.getFakeId(Account.SObjectType);
        mock.accountsToReturn.add(testAccount);
        
        AccountController controller = new AccountController();
        AccountController.accountDoaInstance = mock;
        
        Test.startTest();
          List<Account> accounts = controller.CreateNewAccounts(null);
        Test.stopTest();  
    }
    
    @isTest
     private static void createAccountsDoaTest(){
        List<Account> accList = new List<Account>(); 
        Account testAccount = new Account();
        testAccount.Name = 'Test Name';
        accList.add(testAccount);
        
        AccountController controller = new AccountController();
        
        Test.startTest();
          List<Account> accounts = controller.CreateNewAccounts(accList);
        Test.stopTest();      
        System.AssertEquals(1,accounts.size());
    }
}