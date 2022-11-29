/**  Trigger Scenario
 *   
 * Upon Opportunity record creation if Amount is between
 * 100000 to 500000 then populate ‘Hot Opportunity’ in
 * description field.
 * 
 * Trigger Scenario
 * 
 * When an Opportunity is created on any Account, put
 * the latest opportunity Amount on the Account in the
 ‘ Latest Opportunity Amount’ field.
 * 
 * 
 */

trigger OpportunityTrigger on Opportunity (before insert, After Insert) 
{
      
      if(trigger.isInsert && trigger.isBefore)
      {
         OpportunityTriggerHandler.UpdateDescription(trigger.new);
      }

      if(Trigger.isAFter && Trigger.isInsert)
      {    
            OpportunityTriggerHandler.UpdateLatestAmountInAccount(Trigger.new);
      }
}