public class AccountControllerDOA implements IAccountControllerDOA {
    
        Public List<Account> getAccountDetails(){
            //List<Account> accList = [Select Name From Account Where Name !=null Limit 10];
            //return accList;
            return [Select Name From Account Where Name !=null Limit 10];
        }


        public List<Account> createAccounts(List<Account> accList){
            //List<Account> accListInsert = accList;
            //Insert accListInsert;
            //return accListInsert;
                Insert accList;
                return accList;
        }
    
         public List<Account> updateAccounts(List<Account> accList){
           // List<Account> accListUpdate = accList;
           // Update accListUpdate;
           // return accListUpdate;
                update accList;
                return accList;
          }
    
         public List<Account> deleteAccounts(List<Account> accList){
           // List<Account> accListDelete = accList;
           // Delete accListDelete;
           // return accListDelete;
                delete accList;
                return accList;
          }
}