public class AccountController{
    @testVisible static IAccountControllerDOA accountDoaInstance = new AccountControllerDOA();
    
    Public List<Account> getAccounts(){
        return accountDoaInstance.getAccountDetails();
    }
    
     public List<Account> createNewAccounts(List<Account> accList){
        return accountDoaInstance.createAccounts(accList);
    }
    
     public List<Account> updateOldAccounts(List<Account> accList){
        return accountDoaInstance.updateAccounts(accList);
    }
    
     public List<Account> deleteOldAccounts(List<Account> accList){
        return accountDoaInstance.deleteAccounts(accList);
    }
     
}