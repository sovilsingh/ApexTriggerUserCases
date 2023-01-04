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
 * When an Account record is created then Create a
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
 * Trigger Scenario with Test Class
 * ===========================================
 * When an Account is inserted or updated and the
 * CopyBillingToShipping checkbox is checked then copy
 * billing address to shipping address.
 * 
 * Trigger Scenario with Test Class
 * ========================================
 * Upon Account creation or updation if Industry is Media
 * then populate Rating as Hot.
 * 
 * Trigger Scenario with Test Class
 * ======================================
 * When Account Phone is updated then populate
 * Account’s Phone Number on all related Contacts in
 * Phone Field.
 *
 * 
 * Note :-
 * ================= 
 *
 * There's a method isEmpty(String), 
 * which returns true if string is null or empty. 
 * Unlike isBlank(String), returns false if string is white spaces.
 * 
 * Trigger Scenario with Test Class
 * ======================================
 * When Account Phone is updated then populate
 * Account’s Phone Number on all related Contacts in
 * Home Phone Field.
 * Write code using parent-child SOQL.
 * 
 * Trigger Scenario with Test Class
 * ==========================================
 * When Account Billing Address is updated then populate Account Billing Address on all related
 * Contacts Mailing Address.
 * Write code using Map as well as parent-child SOQL.
 * Implement Trigger and TriggerHandler
 * 
 * Note :-
 * ==============
 * 
 * Before triggers are used to perform the logic on the same object and it triggers 
 * fired before the data saved into the database. For DML operation it required to commit with data base. 
 * So, we cannot use the DML operation on these triggers.
 * 
 * Trigger Scenario with Test Class
 * ======================================
 * When Account Active field is updated from ‘Yes’ to ‘No’
 * then update all related opportunities stage to Clost Lost
 * if stage is not equal to Close Won.
 * 
 * Trigger Scenario with Test Class
 * ===============================================
 * Prevent deletion of account record if Active = Yes.
 * 
 * Trigger Scenario with Test Class
 * ================================================
 * Apply Custom Labels in Apex Trigger & Test Class.
 * Prevent deletion of account record if Active = Yes.
 * 
 * Trigger Scenario with Test Class
 * ================================================
 * Prevent account record from being edited if the record
 * is created 7 days back.
 * 
 */
trigger AccountTrigger on Account (Before Insert, After Insert, Before Update, After Update, Before Delete) 
{
    AccountTriggerHandler acchandler = new AccountTriggerHandler();
    if(Trigger.isBefore && Trigger.isInsert)
    {       AccountTriggerHandler.updateRating(Trigger.New);
            AccountTriggerHandler.CopyBillingToShipping(Trigger.New); 
            //acchandler.updateRating(Trigger.New);
            //acchandler.CopyBillingToShipping(Trigger.New);
    }
    if(Trigger.isAfter && Trigger.isInsert)
    {    AccountTriggerHandler.CreateRelatedAccountContact(Trigger.new);
         AccountTriggerHandler.CreateRelatedAccountOpportunity(Trigger.New);
         AccountTriggerHandler.CreateRelatedContactOrOpportunityOrBoth(Trigger.New);
         //acchandler.CreateRelatedAccountContact(Trigger.new);
         //acchandler.CreateRelatedAccountOpportunity(Trigger.New);
         //acchandler.CreateRelatedContactOrOpportunityOrBoth(Trigger.New);
    }

    if(Trigger.isBefore && Trigger.isUpdate)
    {   AccountTriggerHandler.UpdateAccountDescription(Trigger.New,Trigger.OldMap);
        AccountTriggerHandler.UpdateCopyBillingToShipping(Trigger.New,Trigger.OldMap);
        AccountTriggerHandler.BeforeupdateRating(Trigger.New, Trigger.OldMap);
    //    AccountTriggerHandler.AccountUpdatePrevent(Trigger.New);
        //acchandler.UpdateAccountDescription(Trigger.New,Trigger.OldMap);
        //acchandler.UpdateCopyBillingToShipping(Trigger.New,Trigger.OldMap);
        //acchandler.BeforeupdateRating(Trigger.New, Trigger.OldMap); 
    }

    if(Trigger.isAfter && Trigger.isUpdate)
    {    //AccountTriggerHandler.UpdateAccountPhoneToContact(Trigger.New,Trigger.OldMap);
         AccountTriggerHandler.UpdateAccountPhoneToContactSOQL(Trigger.New,Trigger.OldMap);
         AccountTriggerHandler.UpdateAccountBillingAddressToContact(Trigger.New,Trigger.OldMap);
         //AccountTriggerHandler.UpdateAccountBillingAddressToContactSOQL(Trigger.New,Trigger.OldMap);
         AccountTriggerHandler.UpdateAccountToOpportunityByActiveField(Trigger.New,Trigger.OldMap);
         //acchandler.UpdateAccountPhoneToContact(Trigger.New,Trigger.OldMap);
         //acchandler.UpdateAccountPhoneToContactSOQL(Trigger.New,Trigger.OldMap);
         //acchandler.UpdateAccountBillingAddressToContactSOQL(Trigger.New,Trigger.OldMap);
    }
   if(Trigger.isBefore && Trigger.isDelete)     
   {     //AccountTriggerHandler.PreventDeletion(Trigger.old);
         AccountTriggerHandler.PreventDeletionLabel(Trigger.old);
   }
}