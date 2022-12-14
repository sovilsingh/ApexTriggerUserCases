public class OpportunityDAO implements IOpportunityDAO
{
     
	public List<Account> getAccountsUpdateLatestAmountInAccount(Set<Id> accids)
	{

		return [ Select Id, Latest_Opportunity_Amount__c FROM Account Where ID IN : accids ];
	}

}