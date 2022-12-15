public Interface IAccountControllerDOA{
         List<Account> getAccountDetails();
         List<Account> createAccounts(List<Account> accList);
         List<Account> updateAccounts(List<Account> accList);
         List<Account> deleteAccounts(List<Account> accList);
}