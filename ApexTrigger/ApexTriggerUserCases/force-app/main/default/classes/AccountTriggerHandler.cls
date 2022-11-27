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

}