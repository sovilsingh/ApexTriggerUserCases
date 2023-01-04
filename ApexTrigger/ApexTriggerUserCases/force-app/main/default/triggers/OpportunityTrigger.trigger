/**  Trigger Scenario
 *   ==============================
 * Upon Opportunity record creation if Amount is between
 * 100000 to 500000 then populate ‘Hot Opportunity’ in
 * description field.
 * 
 * Trigger Scenario
 * ================================
 * When an Opportunity is created on any Account, put
 * the latest opportunity Amount on the Account in the
 ‘ Latest Opportunity Amount’ field.
 * 
 * Trigger Scenario with Test Class
 * ===================================
 * Based on Opportunity stage upon Opportunity creation
 * or updation, set the Description field as:
 * -Opportunity is Closed Lost or
 * -Opportunity is Closed Won or
 * -Opportunity is Open
 * 
 * Trigger Scenario with Test Class
 * ==========================================
 * When an Opportunity Stage is changed, then create a
 * Task record on Opportunity and assign it to Logged In
 * User / Opportunity Owner.
 * 
 * 
 * 
 * 
 */

trigger OpportunityTrigger on Opportunity (Before insert, Before Update, After Insert, After Update) 
{
      
      if(trigger.isInsert && trigger.isBefore)
      {
         OpportunityTriggerHandler.UpdateDescription(trigger.new);
      }

      if(trigger.isUpdate && trigger.isBefore)
      {
            OpportunityTriggerHandler.UpdateDescriptionBasedOnStage(Trigger.new,Trigger.OldMap);
      }

      if(Trigger.isAfter && Trigger.isInsert)
      {    
            OpportunityTriggerHandler.UpdateLatestAmountInAccount(Trigger.new);
      }

      if(Trigger.isAfter && Trigger.isUpdate)
      {
           OpportunityTriggerHandler.CreateTaskOnOpportunity(Trigger.New,Trigger.OldMap);
      }
}