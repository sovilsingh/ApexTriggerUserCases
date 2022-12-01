/**   
 * Trigger Scenario 
 * =========================
 * Upon Account record creation if Industry field is having
 * value as ‘Media’ or ‘Energy’ then populate Rating as ‘Hot’.
 *
 *  
 * Trigger Scenario
 * ======================
 * When an Account record is created and
 * CopyBillingToShipping checkbox is checked then copy
 * Account Billing Address to Shipping Address.
 * 
 * 
 * Trigger Scenario
 * =======================
 * When an Account record is created then Create a related Contact as well.
 * 
 * Trigger Scenario
 * =========================
 * When an Account recgrd is created then Create a
 * related Opportunity as well.
 * 
 * Trigger Scenario with Test Class
 * ========================================
 * 1 - On Account two checkbox fields are available:
 *     - New Contact and New Opportunity
 * 2 - On Account Creation
 *     - if New Contact checkbox is checked then a related
 *       Contact should be created.
 *	   - If New Opportunity checkbox is checked and
 *       Active = Yes, then a related Opportunity should be
 *        created.
 * 
 * Trigger Scenario with Test Class
 * ===========================================
 * When Account’s, phone field is updated then populate
 * below message in description field:
 * Phone is Updated! and Old Value: XXX & New Value : XXX
 * 
 * Note :-
 * ================= 
 *
 * There's a method isEmpty(String), 
 * which returns true if string is null or empty. 
 * Unlike isBlank(String), returns false if string is white spaces.
 * 
 * Note :-
 * ==============
 * 
 * Before triggers are used to perform the logic on the same object and it triggers 
 * fired before the data saved into the database. For DML operation it required to commit with data base. 
 * So, we cannot use the DML operation on these triggers.
 * 
 */
trigger AccountTrigger on Account (Before Insert, After Insert, Before Update) 
{
    if(Trigger.isBefore && Trigger.isInsert)
    {
           AccountTriggerHandler.updateRating(Trigger.New);
           AccountTriggerHandler.CopyBillingToShipping(Trigger.New);      
    }

    if(Trigger.isAfter && Trigger.isInsert)
    {
        
        AccountTriggerHandler.CreateRelatedAccountContact(Trigger.new);
        AccountTriggerHandler.CreateRelatedAccountOpportunity(Trigger.New);
        AccountTriggerHandler.CreateRelatedContactOrOpportunityOrBoth(Trigger.New);
    }

    if(Trigger.isBefore && Trigger.isUpdate)
    {
      AccountTriggerHandler.UpdateAccountDescription(Trigger.New,Trigger.OldMap);
      AccountTriggerHandler.UpdateCopyBillingToShipping(Trigger.New,Trigger.OldMap); 
    }
}