public class AccountTriggerHandler 
{
    /**
     * Method to Update the Rating when the Industry field 
     * having value equals to ‘Media’ or ‘Energy’ 
     */
   public static void updateRating(List<Account> accList)
   {
         
          for(Account acc : accList)
          {
            if(acc.Industry == 'Media' || acc.Industry == 'Energy')
            {
                //Not to do any DMl operation bcz changes are made in before trigger and its own records so
                //it automatically got commited itself
                acc.Rating = 'Hot';
            }
          }
   }

   public static void CopyBillingToShipping(List<Account> accList)
   {
       for(Account acc : accList)
       {
             if(acc.CopyBillingToShipping__c == true)
             {
               acc.ShippingCity = acc.BillingCity;
               acc.ShippingCountry = acc.BillingCountry; 
               acc.ShippingPostalCode = acc.BillingPostalCode; 
               acc.ShippingState = acc.BillingState;
               acc.ShippingStreet = acc.BillingStreet;          
             }
       }
   }

   Public Static void CreateRelatedAccountContact(List<Account> accList)
   {
      
    List<Contact> conList = new List<Contact>();
    for(Account acc : accList)
    {
      Contact con = new Contact();
      con.LastName = acc.Name;
      //There's a method isEmpty(String), 
      //which returns true if string is null or empty. 
      //Unlike isBlank(String), returns false if string is white spaces.
      if(String.isEmpty(acc.Phone))
      {
        con.Phone = acc.Phone;
      }
       con.AccountID = acc.Id;
      conList.add(con);   
    }
    // if(!conList.isEmpty());
    if(conList.size() > 0)
    {
      Insert conList;
    }   
   }

   public static void CreateRelatedAccountOpportunity(List<Account> accList)
   {
       
     List<Opportunity> oppList = new List<Opportunity>();

     for(Account acc : accList)
     {
       Opportunity opp = new Opportunity();
       opp.Name = acc.Name;
       //Note we can give like this when we have to give for next 30 days
       opp.CloseDate = System.Today() + 30;
       opp.StageName = 'Prospecting';
       opp.AccountID = acc.Id;
       oppList.add(opp);
     }

      if(oppList.size()>0)
      {
        Insert oppList;
      }
   }

}