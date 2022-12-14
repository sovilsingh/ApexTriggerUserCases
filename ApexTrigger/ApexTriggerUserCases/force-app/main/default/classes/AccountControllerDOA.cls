public class AccountControllerDOA implements IAccountControllerDOA {
    
        Public List<Account> getAccountDetails(){
            List<Account> accList = [Select Name From Account Where Name !=null Limit 10];
            return accList;
        }
    
        public List<Account> createAccounts(List<Account> accList){
            List<Account> accListInsert = accList;
            Insert accListInsert;
            return accListInsert;
        }
}