public class AccountDOA implements IAccountDOA 
{
 
    Public List<contact> getContactForUpdateAccountPhoneToContact(Set<Id> accids)
    {
       return [Select ID, Phone, AccountID From Contact Where AccountID IN : accids];
    }

    Public List<Account> getContactForUpdateAccountPhoneToContactSOQL(Set<Id> accids)
    {
       return [Select Id, Phone,(Select Phone From Contacts )From Account Where ID IN : accIds];
        
    }

    Public List<Contact> getContactForUpdateAccountBillingAddressToContact(Set<Id> accids)
    {
        return [Select ID, AccountID From Contact Where AccountID IN : accids];
    }

    Public List<Account> getContactUpdateAccountBillingAddressToContactSOQL(Set<Id> accids)
    {
        return [Select Id, BillingCountry, BillingCity, BillingPostalCode, BillingState, BillingStreet,
        (Select ID From Contacts) From Account Where ID IN : accIds];
    }

}