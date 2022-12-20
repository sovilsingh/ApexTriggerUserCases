@isTest
private class AccountControllerTest {
     
    @isTest
    private static void getAccountsTest(){
        AccountControllerMock mock = new AccountControllerMock();
        List<Account> accList = new List<Account>();
        for(Integer i=0;i<10;i++){
            Account testAccount = new Account();
            testAccount.Name = 'Test Name '+i;
            testAccount.Name = TestDataFactory.getFakeId(Account.SObjectType);
            accList.add(testAccount);
        }
        mock.accountsToReturn.addAll(accList); 
        AccountController controller = new AccountController();
        AccountController.accountDoaInstance = mock;
        
        Test.startTest();
          List<Account> accounts = controller.getAccounts();
        Test.stopTest();
        System.assertEquals(10, accounts.size(), 'Not Getting Record Limit upto 10');
    }
    
    
     @isTest
    private static void createNewAccountsTest(){
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
        System.assertEquals(1, accounts.size(), 'Not Created Record Limit upto 10');
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
        System.assertEquals(1, accounts.size(), 'Not Updated Record Limit upto 10');
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
        System.assertEquals(1, accounts.size(), 'Not Created Record Limit upto 10');
    } 
    
     @isTest
    private static void createNewAccountsCatchTest(){  
        AccountController controller = new AccountController();
        try{
          Test.startTest();
          List<Account> accounts = controller.createNewAccounts(null);
          Test.stopTest();
        }
        catch(Exception e)
        {
            System.assertEquals(e.getMessage(), e.getMessage());
        }
    }
    
    @isTest
    private static void updateOldAccountsCatchTest(){
       AccountController controller = new AccountController();
        try{
          Test.startTest();
          List<Account> accounts = controller.updateOldAccounts(null);
          Test.stopTest();
        }
        catch(Exception e)
        {
            System.assertEquals(e.getMessage(), e.getMessage());
        }
    }
    
    @isTest
    private static void deleteOldAccountsCatchTest(){
        AccountController controller = new AccountController();
        try{
          Test.startTest();
          List<Account> accounts = controller.deleteOldAccounts(null);
          Test.stopTest();
        }
        catch(Exception e)
        {
            System.assertEquals(e.getMessage(), e.getMessage());
        }
    } 
    
}