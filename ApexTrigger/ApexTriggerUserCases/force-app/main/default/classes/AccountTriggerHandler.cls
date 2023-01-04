public class AccountTriggerHandler 
{
    
    /**
     * Method to Update the Rating when the Industry field 
     * having value equals to ‘Media’ or ‘Energy’ 
     */
    @testVisible static IAccountDOA accountDOAInstance = new AccountDOA();
  //  @testVisible static IAccountDOA accountDOAMockInstance = new AccountDOAMock();
   // @testVisible Static IAccountDOA accountDOAMockInstance = new AccountDOAMock();
       
   //public static void updateRating(List<Account> accList)
   public Static void updateRating(List<Account> accList)
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

   public Static void CopyBillingToShipping(List<Account> accList)
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

   Public Static void CreateRelatedAccountContact(List<Account> accList)
   {
      
    List<Contact> conList = new List<Contact>();
    for(Account acc : accList)
    {
      Contact con = new Contact();
      con.LastName = acc.Name;
      //There's a method isEmpty(String), 
      //which returns true if string is null or empty. 
      //Unlike isBlank(String), returns false if string is white spaces.
      if(String.isEmpty(acc.Phone))
      {
        con.Phone = acc.Phone;
      }
       con.AccountID = acc.Id;
      conList.add(con);   
    }
    // if(!conList.isEmpty());
    if(conList.size() > 0)
    {
      insert conList ;
      //Insert conList;
    }   
   }

   public Static void CreateRelatedAccountOpportunity(List<Account> accList)
   {
       
     List<Opportunity> oppList = new List<Opportunity>();

     for(Account acc : accList)
     {
       Opportunity opp = new Opportunity();
       opp.Name = acc.Name;
       //Note we can give like this when we have to give for next 30 days
       opp.CloseDate = System.Today() + 30;
       opp.StageName = 'Prospecting';
       opp.AccountID = acc.Id;
       oppList.add(opp);
     }

      if(oppList.size()>0)
      {
       Insert oppList;    
      }
   }

   public Static void CreateRelatedContactOrOpportunityOrBoth(List<Account> accList)
   {

      List<Contact> conList = new List<Contact>();
      List<Opportunity> oppList = new List<Opportunity>();

      for(Account acc : accList)
      {
        if(acc.New_Contact__c == true)
        {
           Contact con = new Contact();
           con.LastName = acc.Name;
           if(String.isEmpty(acc.Phone))
           {
            con.Phone = acc.Phone;
           }
           con.AccountID = acc.id;
           conList.add(con);
        }

        if(acc.Active__c == 'Yes' && acc.New_Opportunity__c == true)
        {
           Opportunity opp = new Opportunity();
           opp.Name = acc.Name;
           //Note we can give like this when we have to give for next 30 days
           opp.CloseDate = System.Today() + 30;
           opp.StageName = 'Prospecting';
           opp.AccountID = acc.Id;
           oppList.add(opp);
        }
      }

      if(conList.size()>0)
      {
        insert conList;
      }

      if(oppList.size()>0)
      {
        Insert oppList;
      }
   }

   Public Static void UpdateAccountDescription(List<Account> accList, Map<Id,Account> accListOldMap)
   {
        for(Account acc : accList)
        {
          if(acc.Phone != accListOldMap.get(acc.id).Phone)
          {
             acc.description = 'Phone is Updated!'+' and Old Value: '+ accListOldMap.get(acc.id).Phone+' & New Value : '+acc.Phone;
          }
        }
   } 


   public Static void UpdateCopyBillingToShipping(List<Account> accList, Map<Id,Account> accOldMap)
   {
       for(Account acc : accList)
       {
             if(acc.CopyBillingToShipping__c == true && accOldMap ==null || acc.CopyBillingToShipping__c == true &&
                acc.CopyBillingToShipping__c != accOldMap.get(acc.id).CopyBillingToShipping__c)
             {
              
               acc.ShippingCity = acc.BillingCity;
               acc.ShippingCountry = acc.BillingCountry; 
               acc.ShippingPostalCode = acc.BillingPostalCode; 
               acc.ShippingState = acc.BillingState;
               acc.ShippingStreet = acc.BillingStreet;          
             }
       }
   }


   public static void BeforeupdateRating(List<Account> accList, Map<id,Account> OldAccMap)
   {  
          for(Account acc : accList)
          {
            If((OldAccMap == null && acc.Industry != null && 
            acc.Industry == 'Media' 
            || OldAccMap == null && acc.Industry != null && 
            acc.Industry == 'Energy')
            || (acc.Industry != null && acc.Industry == 'Media' &&
            acc.Industry != OldAccMap.get(acc.Id).Industry ) 
            ||  (acc.Industry != null && acc.Industry == 'Energy' &&
            acc.Industry != OldAccMap.get(acc.Id).Industry ))
            {
                //Not to do any DMl operation bcz changes are made in before trigger and its own records so
                //it automatically got commited itself
                acc.Rating = 'Hot';
            }
          }
   }

   Public void UpdateAccountPhoneToContact(List<Account> accList, Map<Id,Account> OldAccMap)
   {
        List<Contact> conList = new List<Contact>();

        Map<Id,Account> accToAccountMap = new Map<Id,Account>();

        for(Account acc : accList)
        {
           if(acc.Phone != null && acc.Phone != OldAccMap.get(acc.id).Phone && OldAccMap != null)
           {
             accToAccountMap.put(acc.id,acc);
           }
        }

        if(accToAccountMap.size() > 0)
        {                                  
          List<Contact> conListToUpdate = getContactForUpdateAccountPhoneToContact(accToAccountMap.keyset());
          for(Contact con : conListToUpdate)
          {
             if(accToAccountMap.containsKey(con.AccountID))
             {
                 con.Phone = accToAccountMap.get(con.AccountID).phone;
                 conList.add(con);
             }
          }
        }
         Update conList;
   }


   Public static void UpdateAccountPhoneToContactSOQL(List<Account> accList, Map<Id,Account> OldAccMap)
   {
        List<Contact> conList = new List<Contact>();

        //Map<Id,Account> accToAccountMap = new Map<Id,Account>();
        Set<id> accIds = new Set<id>();

        for(Account acc : accList)
        {
           if(acc.Phone != null && acc.Phone != OldAccMap.get(acc.id).Phone && OldAccMap != null)
           {
            // accToAccountMap.put(acc.id,acc);
               accIds.add(acc.id);
           }
        }

       /** if(accToAccountMap.size() > 0)
      
        {
          List<Contact> conListToUpdate = [Select ID, Phone, AccountID From Contact Where AccountID IN : accToAccountMap.keyset()];
          for(Contact con : conListToUpdate)
          {
             if(accToAccountMap.containsKey(con.AccountID))
             {
                 con.Phone = accToAccountMap.get(con.AccountID).phone;
                 conList.add(con);
             }
          }
          */

          //Using Parent to child SOQL
          
          for(Account acc : accountDOAInstance.getContactForUpdateAccountPhoneToContactSOQL(accIds))
            {
              if(acc.contacts != null)
              {
                for(Contact con: acc.contacts)
                {
                  con.Phone = acc.Phone;
                  conList.add(con);
                }
              }

            }

            if(conList.size() > 0)
            {
             Update conList;

            }
   
        }

   Public static void UpdateAccountBillingAddressToContact(List<Account> accList, Map<Id,Account> OldMap)
   {

          List<Contact> conList = new List<Contact>();
          Map<ID,Account> accToAccountMap = new Map<ID,Account>();

          for(Account acc : accList)
          {
             if(OldMap != null && (acc.BillingCity != OldMap.get(acc.id).BillingCity
             || acc.BillingCountry != OldMap.get(acc.id).BillingCountry
             || acc.BillingPostalCode  != OldMap.get(acc.id).BillingPostalCode
             || acc.BillingState != OldMap.get(acc.id).BillingState
             || acc.BillingStreet != OldMap.get(acc.id).BillingStreet))
             {
                accToAccountMap.put(acc.id,acc);
             }
          }
         
          for(Contact con : accountDOAInstance.getContactForUpdateAccountBillingAddressToContact(accToAccountMap.keyset()))
          {
                       if(accToAccountMap.containsKey(con.AccountID))
                       {
                          con.MailingCity = accToAccountMap.get(con.AccountID).BillingCity;
                          con.MailingCountry = accToAccountMap.get(con.AccountID).BillingCountry;
                          con.MailingPostalCode = accToAccountMap.get(con.AccountID).BillingPostalCode;
                          con.MailingState = accToAccountMap.get(con.AccountID).BillingState;
                          con.MailingStreet = accToAccountMap.get(con.AccountID).BillingStreet;
                          
                       }

                       conList.add(con);
          }

          if(conList.size() > 0)
          {
            Update conList;

          }

        }

   Public static void UpdateAccountBillingAddressToContactSOQL(List<Account> accList, Map<Id,Account> OldMap)
   {

          List<Contact> conList = new List<Contact>();
         // Map<ID,Account> accToAccountMap = new Map<ID,Account>();
          Set<ID> accids = new Set<ID>();

          for(Account acc : accList)
          {
             if(OldMap != null && (acc.BillingCity != OldMap.get(acc.id).BillingCity
             || acc.BillingCountry != OldMap.get(acc.id).BillingCountry
             || acc.BillingPostalCode  != OldMap.get(acc.id).BillingPostalCode
             || acc.BillingState != OldMap.get(acc.id).BillingState
             || acc.BillingStreet != OldMap.get(acc.id).BillingStreet))
             {
                //accToAccountMap.put(acc.id,acc);
                accids.add(acc.id);
             }
          }

          /** 
          for(Contact con : [Select ID, AccountID From Contact Where AccountID IN : accToAccountMap.keyset()])
          {
                       if(accToAccountMap.containsKey(con.AccountID))
                       {
                          con.MailingCity = accToAccountMap.get(con.AccountID).BillingCity;
                          con.MailingCountry = accToAccountMap.get(con.AccountID).BillingCountry;
                          con.MailingPostalCode = accToAccountMap.get(con.AccountID).BillingPostalCode;
                          con.MailingState = accToAccountMap.get(con.AccountID).BillingState;
                          con.MailingStreet = accToAccountMap.get(con.AccountID).BillingStreet;
                          
                       }
                       conList.add(con);
          }
          */

          for(Account acc : accountDOAInstance.getContactUpdateAccountBillingAddressToContactSOQL(accIds))
                            {
                              if(acc.Contacts != null)
                              {
                                for(Contact con: acc.Contacts)
                                {
                                   con.MailingCity = acc.BillingCity;
                                   con.MailingCountry = acc.BillingCountry;
                                   con.MailingPostalCode = acc.BillingPostalCode;
                                   con.MailingState = acc.BillingState;
                                   con.MailingStreet = acc.BillingStreet;
                                   conList.add(con);
                                }
                              }
                            }

          if(conList.size() > 0)
          {
              Update conList;
          }

        }
    
   public Static void UpdateAccountToOpportunityByActiveField(List<Account> accList, Map<Id,Account> OldMap)
   {
        List<opportunity> oppList = new List<Opportunity>();
        Set<Id> accIds = new Set<Id>();
        for(Account acc : accList)
        {
            if(acc.Active__c == 'NO' && oldMap.get(acc.id).Active__c == 'Yes')
            {
                accIds.add(acc.id);
            }
        }
        if(!accIds.isEmpty())
        {
            List<Opportunity> oppListToUpdate = [Select ID, StageName From Opportunity where AccountID IN : accIds];
            
            for(Opportunity opp : oppListToUpdate)
            {
                if(opp.StageName != 'Closed Won' && opp.StageName != 'Closed Lost')
                {
                    opp.StageName = 'Closed Lost';
                    oppList.add(opp);
                }
            }
        }       
        update oppList;    
    }
    
   public static void PreventDeletion(List<Account> accList)
   {
       for(Account acc : accList)
       {
           if(acc.Active__c == 'Yes')
           {
               acc.addError('Active Account cannot be deleted');
           }
       }
   }
    
   public static void PreventDeletionLabel(List<Account> accList)
   {
       for(Account acc : accList)
       {
           if(acc.Active__c == 'Yes')
           {
               acc.addError(Label.Prevent_Account_Deletion);
           }
       }
   }
    
   public static void AccountUpdatePrevent(List<Account> accList)
   {
        for(Account acc : accList)
       {
           if(acc.CreatedDate > System.today() - 7)
           {
               acc.addError('you cannot update the record which created in last 7 days');
           }
       }
   }

    
   Public List<contact> getContactForUpdateAccountPhoneToContact(Set<Id> accids)
   {
             return accountDOAInstance.getContactForUpdateAccountPhoneToContact(accids);
           }
    
   Public List<contact> getContactForUpdateAccountBillingAddressToContact(Set<Id> accids)
   {
             return accountDOAInstance.getContactForUpdateAccountBillingAddressToContact(accids);
           }
    
   Public List<Account> getContactForUpdateAccountPhoneToContactSOQL(Set<Id> accids)
   {
             return accountDOAInstance.getContactForUpdateAccountPhoneToContactSOQL(accids);
           }
    
   Public List<Account> getContactUpdateAccountBillingAddressToContactSOQL(Set<Id> accids)
   {
             return accountDOAInstance.getContactUpdateAccountBillingAddressToContactSOQL(accids);
           }



   }