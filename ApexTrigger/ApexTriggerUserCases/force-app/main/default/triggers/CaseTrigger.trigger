/**
 * Trigger Scenario
 *When a Case is created on any Account, put the latest
 *case number on the Account in the ‘Latest Case
 * Number’ field.
 * 
 */

trigger CaseTrigger on Case (After insert) 
{
   if(Trigger.isAfter && Trigger.isInsert)
   {
     CaseTriggerHandler.UpdateLatestCaseNumber(Trigger.New);
   }
}