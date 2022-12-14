@isTest
public class AccountDOAMock implements IAccountDOA
{
     public List<Contact> contactsToReturn = new List<Contact>();
     public List<Account> accountToReturn = new List<Account>();
    
     Public List<contact> getContactForUpdateAccountPhoneToContact(Set<Id> accids)
    {
       return contactsToReturn;
    }

    Public List<Account> getContactForUpdateAccountPhoneToContactSOQL(Set<Id> accids)
    {
       return accountToReturn;
        
    }

    Public List<Contact> getContactForUpdateAccountBillingAddressToContact(Set<Id> accids)
    {
        return contactsToReturn;
    }

    Public List<Account> getContactUpdateAccountBillingAddressToContactSOQL(Set<Id> accids)
    {
        return accountToReturn;
    }

}