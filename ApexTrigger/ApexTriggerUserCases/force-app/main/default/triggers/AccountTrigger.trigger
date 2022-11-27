/**   
 * Trigger Scenario 1
 * Upon Account record creation if Industry field is having
 * value as ‘Media’ or ‘Energy’ then populate Rating as ‘Hot’.
 * 
 * 1 - Create Trigger on Account
 * 2 - Create TriggerHandler Class
 * 3 - Create Test Class for Code Coverage
 *  
 * Trigger Scenario
 * When an Account record is created and
 * CopyBillingToShipping checkbox is checked then copy
 * Account Billing Address to Shipping Address.
 * 
 * 1. Create Trigger on Account
 * 2. Create TriggerHandler Class
 * 3. Create Test Class for Code Coverage
 * 
 */
trigger AccountTrigger on Account (before insert) 
{
    if(Trigger.isBefore && Trigger.isInsert)
    {
           AccountTriggerHandler.updateRating(Trigger.New);
           AccountTriggerHandler.CopyBillingToShipping(Trigger.New);
    }
}