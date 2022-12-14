public  class OpportunityTriggerHandler
{
    @testVisible static IOpportunityDAO oppDAOInstance = new OpportunityDAO();     
   

    public static void UpdateDescription(List<Opportunity> oppList)
    {

        for(Opportunity opp : oppList )
        {
            //checking for the amount and making changes based on condition 
            if(opp.Amount != null && opp.Amount >= 100000 && opp.Amount <= 500000)
            {
                //Not to do any DMl operation bcz changes are made in before trigger and its own records so
                //it automatically got commited itself
                opp.description = 'Hot Opportunity';
            }
        }

    }

    Public Static void UpdateLatestAmountInAccount(List<Opportunity> oppList)
    {
        
       List<Account> accList = new List<Account>();
      
      // Set<id> oppAccountids = new Set<Id>();
       Map<Id,Double> oppMap = new Map<ID,Double>();
       for(Opportunity opp : oppList)
       {
          //oppAccountids.add(opp.AccountId);
          oppMap.put(opp.AccountId,opp.Amount);
       }

       List<Account> accListToUpdate = oppDAOInstance.getAccountsUpdateLatestAmountInAccount(oppMap.keyset());
       
      // List<Account> accListToUpdate = [Select Id, Latest_Opportunity_Amount__c from Account Where ID IN : oppMap.keyset()];


       if(accListToUpdate.size() > 0)
       {
        for(Account acc : accListToUpdate)
        {
          acc.Latest_Opportunity_Amount__c = oppMap.get(acc.id);
          accList.add(acc);
        }
       }

       if(!accList.isEmpty())
       {
        Update accList;
       }
      
    }

    Public Static void UpdateDescriptionBasedOnStage(List<Opportunity> oppList, Map<Id,Opportunity> OldOppMap)
    {
        
        for(Opportunity opp : oppList)
        {
          if(OldOppMap == null || opp.stageName!= OldOppMap.get(opp.id).stageName)
          {
            if(opp.stageName == 'Closed Lost')
            {
                opp.Description = 'Opportunity is '+opp.stageName; 
            }
            else if(opp.stageName == 'Closed Won')
            {
                opp.Description = 'Opportunity is '+opp.stageName; 
            }
           else
            {
                opp.Description = 'Opportunity is Open'; 
            }
          }
        }
    }

     Public Static void CreateTaskOnOpportunity(List<Opportunity> oppList, Map<Id,Opportunity> oldOppMap)
    {
        List<Task> taskList = new List<Task>();
        for(Opportunity opp :oppList)
        {
            if(opp.StageName != oldOppMap.get(opp.id).StageName)
            {
                Task tsk = new Task();
                tsk.WhatID = opp.ID;  // Related TO 
                tsk.Subject = 'Demo';
                tsk.Priority = 'Normal';
                tsk.Status = 'Not Started';
                tsk.OwnerId = opp.OwnerId; //or UserInfo.getUserId();
                taskList.add(tsk);
            }
  
        }

        if(taskList.size()>0)
        {
           Insert taskList;
        }
    }

}