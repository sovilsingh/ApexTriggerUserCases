public  class OpportunityTriggerHandler 
{
    
    public static void UpdateDescription(List<Opportunity> oppList)
    {

        for(Opportunity opp : oppList )
        {
            //checking for the amount and making changes based on condition 
            if(opp.Amount != null && opp.Amount >= 100000 && opp.Amount <= 500000)
            {
                //Not to do any DMl operation bcz changes are made in before trigger and its own records so
                //it automatically got commited itself
                opp.description = 'Hot Opportunity';
            }
        }

    }

}
