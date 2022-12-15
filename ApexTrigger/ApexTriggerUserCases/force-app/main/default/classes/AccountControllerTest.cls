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
          List<Account> accounts = controller.createNewAccounts(null);
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
          List<Account> accounts = controller.createNewAccounts(accList);
        Test.stopTest();      
        System.AssertEquals(1,accounts.size());
    }
    
    @isTest
    private static void updateOldAccountsTest(){
        AccountControllerMock mock = new AccountControllerMock();
        Account testAccount = new Account();
        testAccount.Name = 'Test Name';
        testAccount.Phone = '78889';
        testAccount.Industry = 'Media';
        testAccount.Name = TestDataFactory.getFakeId(Account.SObjectType);
        mock.accountsToReturn.add(testAccount);
        
        AccountController controller = new AccountController();
        AccountController.accountDoaInstance = mock;
        
        Test.startTest();
          List<Account> accounts = controller.updateOldAccounts(null);
        Test.stopTest();  
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
        System.AssertEquals(1,accounts.size());
    }
    
    @isTest
    private static void deleteOldAccountsTest(){
        AccountControllerMock mock = new AccountControllerMock();
        Account testAccount = new Account();
        testAccount.Name = 'Test Name';
        testAccount.Name = TestDataFactory.getFakeId(Account.SObjectType);
        mock.accountsToReturn.add(testAccount);
        
        AccountController controller = new AccountController();
        AccountController.accountDoaInstance = mock;
        
        Test.startTest();
          List<Account> accounts = controller.deleteOldAccounts(null);
        Test.stopTest();  
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
        System.AssertEquals(1,accounts.size());
    }
}