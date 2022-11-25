public class AccountTriggerHandler 
{
    /**
     * Method to Update the Rating when the Industry field 
     * having value equals to ‘Media’ or ‘Energy’ 
     */
   public static void updateRating(List<Account> accLists)
   {
         
          for(Account acc : accLists)
          {
            if(acc.Industry == 'Media' || acc.Industry == 'Energy')
            {
                //Not to do any DMl operation bcz changes are made in before trigger and its own records so
                //it automatically got commited itself
                acc.Rating = 'Hot';
            }
          }

   }

}