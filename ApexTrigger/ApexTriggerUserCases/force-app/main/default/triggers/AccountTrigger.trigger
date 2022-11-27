/**   
 * Trigger Scenario 
 * Upon Account record creation if Industry field is having
 * value as ‘Media’ or ‘Energy’ then populate Rating as ‘Hot’.
 *
 *  
 * Trigger Scenario
 * When an Account record is created and
 * CopyBillingToShipping checkbox is checked then copy
 * Account Billing Address to Shipping Address.
 * 
 * 
 * Trigger Scenario
 * When an Account record is created then Create a related Contact as well.
 * 
 * Note :- 
 * 
 * There's a method isEmpty(String), 
 * which returns true if string is null or empty. 
 * Unlike isBlank(String), returns false if string is white spaces.
 */
trigger AccountTrigger on Account (before insert, After Insert) 
{
    if(Trigger.isBefore && Trigger.isInsert)
    {
           AccountTriggerHandler.updateRating(Trigger.New);
           AccountTriggerHandler.CopyBillingToShipping(Trigger.New);      
    }

    if(Trigger.isAfter && Trigger.isInsert)
    {
        
        AccountTriggerHandler.CreateRelatedAccountContact(Trigger.new);
    }
}