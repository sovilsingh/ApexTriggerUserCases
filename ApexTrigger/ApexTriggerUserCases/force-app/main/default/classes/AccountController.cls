public class AccountController{
    @testVisible static IAccountControllerDOA accountDoaInstance = new AccountControllerDOA();
    
    Public List<Account> getAccounts(){
        List<Account> accList;
        try{ 
           accList = accountDoaInstance.getAccountDetails();}
        catch(Exception e)
        {
            System.debug('Exception type caught: ' + e.getTypeName()+
                         ' Message: ' + e.getMessage()+
                         'Cause: ' + e.getCause()+    // returns null
                         'Line number: ' + e.getLineNumber()+   
                         'Stack trace: ' + e.getStackTraceString());  
        }
        return accList;
    }
    
     public List<Account> createNewAccounts(List<Account> accList){
         List<Account> accListToReturn;
        try{ 
           accListToReturn = accountDoaInstance.createAccounts(accList);}
        catch(Exception e)
        {
            System.debug('Exception type caught: ' + e.getTypeName()+
                         ' Message: ' + e.getMessage()+
                         'Cause: ' + e.getCause()+    // returns null
                         'Line number: ' + e.getLineNumber()+   
                         'Stack trace: ' + e.getStackTraceString());  
        }
        return accListToReturn;
    }
    
     public List<Account> updateOldAccounts(List<Account> accList){
         List<Account> accListToReturn;
        try{ 
           accListToReturn = accountDoaInstance.updateAccounts(accList);}
        catch(Exception e)
        {
            System.debug('Exception type caught: ' + e.getTypeName()+
                         ' Message: ' + e.getMessage()+
                         'Cause: ' + e.getCause()+    // returns null
                         'Line number: ' + e.getLineNumber()+   
                         'Stack trace: ' + e.getStackTraceString());  
        }
        return accListToReturn;
    }
    
     public List<Account> deleteOldAccounts(List<Account> accList){
         List<Account> accListToReturn;
        try{ 
           accListToReturn = accountDoaInstance.deleteAccounts(accList);}
        catch(Exception e)
        {
            System.debug('Exception type caught: ' + e.getTypeName()+
                         ' Message: ' + e.getMessage()+
                         'Cause: ' + e.getCause()+    // returns null
                         'Line number: ' + e.getLineNumber()+   
                         'Stack trace: ' + e.getStackTraceString());  
        }
        return accListToReturn; 
    }
     
}