public class AccountControllerMock implements IAccountControllerDOA{
    @testVisible
    List<Account> accountsToReturn = new List<Account>();
    public List<Account> getAccountDetails(){
        return accountsToReturn;
    }
    
    public List<Account> createAccounts(List<Account> accList){
        return accountsToReturn;
    }
    
    public List<Account> updateAccounts(List<Account> accList){
        return accountsToReturn;
    }
    public List<Account> deleteAccounts(List<Account> accList){
        return accountsToReturn;
    }
}