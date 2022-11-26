/**  Trigger Scenario
 *   
 * Upon Opportunity record creation if Amount is between
 * 100000 to 500000 then populate ‘Hot Opportunity’ in
 * description field.
 * 
 * 1. Create Trigger on Opportunity
 * 2. Create TriggerHandler Class
 * 3. Create Test Class for Code Coverage
 */

trigger OpportunityTrigger on Opportunity (before insert) 
{
      
      if(trigger.isInsert && trigger.isBefore)
      {
         OpportunityTriggerHandler.UpdateDescription(trigger.new);
      }
}