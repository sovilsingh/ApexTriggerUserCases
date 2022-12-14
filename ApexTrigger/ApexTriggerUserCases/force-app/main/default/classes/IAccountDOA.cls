public interface IAccountDOA 
{
    List<Contact> getContactForUpdateAccountPhoneToContact(Set<Id> accids);
    List<Account> getContactForUpdateAccountPhoneToContactSOQL(Set<Id> accids);
    List<Contact> getContactForUpdateAccountBillingAddressToContact(Set<Id> accids);
    List<Account> getContactUpdateAccountBillingAddressToContactSOQL(Set<Id> accids);
}