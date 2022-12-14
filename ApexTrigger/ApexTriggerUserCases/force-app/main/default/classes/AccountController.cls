public class AccountController{
    @testVisible static IAccountControllerDOA accountDoaInstance = new AccountControllerDOA();
    
    Public List<Account> getAccounts(){
        return accountDoaInstance.getAccountDetails();
    }
    
    public List<Account> CreateNewAccounts(List<Account> accList){
        return accountDoaInstance.createAccounts(accList);
    }
    
}