@isTest
private class OpportunityTriggerHandlerTest 
{
    @isTest
    private Static void UpdateDescriptionTest()
    {
       
        List<Opportunity> oppList = new List<Opportunity>();

        for(Integer i= 0; i < 201; i++)
        {
           Opportunity opp = new Opportunity();
           opp.Name = 'Test'+i;
           opp.StageName = 'Prospecting';
           opp.CloseDate = System.today();
           opp.Amount = 200000;
           oppList.add(opp);
        }

        Test.startTest();
        insert oppList;
        Test.stopTest();

        List<Opportunity> getTestOpportunity = [Select Id, Name, Amount, Description From Opportunity where Id IN : oppList];

        System.assertEquals(201,getTestOpportunity.size());
        String ConstHot = 'Hot Opportunity';
        for(Opportunity opp : getTestOpportunity)
        {
           System.assertEquals( ConstHot, opp.Description);
        }
    }
    
    @isTest
    private Static void UpdateLatestAmountInAccountTest()
    {
      
        List<Account> accList = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();

        for(Integer i=0;i<201;i++)
        {
            Account acc = new Account();
            acc.Name = 'Test'+i;
            accList.add(acc);
        }

        Insert accList;

        for(Account acc : accList)
        {
           Opportunity opp = new Opportunity();
           opp.Name = 'Test';
           opp.StageName = 'Prospecting';
           opp.CloseDate = System.today();
           opp.Amount = 200000;
           opp.AccountID = acc.id;
           oppList.add(opp);
        }

        Test.startTest();
        Insert oppList;
        Test.stopTest();

        List<Account> accListTotest = [Select ID, Latest_Opportunity_Amount__c From Account Where ID IN : accList];

        List<Opportunity> oppListToTest = [Select Id, AccountId, Amount from Opportunity Where ID IN : oppList];

        System.assertEquals(accList.size(),201);
        System.assertEquals(oppList.size(),201);
        
        Map<Id,Double> accountMap = new Map<Id,Double>();
        for(Account acc : accListTotest)
        {
           accountMap.put(acc.Id, acc.Latest_Opportunity_Amount__c);
        }

        for(Opportunity opp : oppListToTest)
        {
            System.assertEquals(opp.Amount,accountMap.get(opp.AccountId));
        }
    }

    @isTest
    private Static void UpdateDescriptionBasedOnStageTest()
    {
       
        List<Opportunity> oppList = new List<Opportunity>();
        List<opportunity> oppListClosedWon = new List<Opportunity>();
        List<opportunity> oppListClosedLost = new List<Opportunity>();

        for(Integer i= 0; i < 201; i++)
        {
           Opportunity opp = new Opportunity();
           opp.Name = 'Test'+i;
           opp.StageName = 'Prospecting'; 
           opp.CloseDate = System.today();
           opp.Amount = 200000;
           oppList.add(opp);
        }

        Test.startTest();
        insert oppList;

        for(Opportunity opp : oppList)
        {
           opp.StageName = 'Qualification'; 
        }


         Update oppList;

       
        for(Integer i= 0; i < 201; i++)
        {
           Opportunity opp = new Opportunity();
           opp.Name = 'Test'+i;
           opp.StageName = 'Qualification';
           opp.CloseDate = System.today();
           opp.Amount = 200000;
           oppListClosedWon.add(opp);
        }

        Insert oppListClosedWon;

        for(Opportunity opp : oppListClosedWon )
        {
           opp.StageName = 'Closed Won'; 
        }

        update oppListClosedWon;
    
        for(Integer i= 0; i < 201; i++)
        {
           Opportunity opp = new Opportunity();
           opp.Name = 'Test'+i;
           opp.StageName = 'Prospecting'; 
           opp.CloseDate = System.today();
           opp.Amount = 200000;
           oppListClosedLost.add(opp);
        }

        Insert oppListClosedLost;

        for(Opportunity opp : oppListClosedLost)
        {
           opp.StageName = 'Closed Lost'; 
        }

        update oppListClosedLost;
        Test.stopTest();

        List<Opportunity> getTestOpportunityOpen = [Select Id, Name, Amount, Description From Opportunity where Id IN : oppList];
        List<Opportunity> getTestOpportunityClosedWon = [Select Id, Name, Amount, Description From Opportunity where Id IN : oppListClosedWon];
        List<Opportunity> getTestOpportunityClosedLost = [Select Id, Name, Amount, Description From Opportunity where Id IN : oppListClosedLost];

        System.assertEquals(201,getTestOpportunityOpen.size());
        System.assertEquals(201,getTestOpportunityClosedWon.size());
        System.assertEquals(201,getTestOpportunityClosedLost.size());

        for(Opportunity opp : getTestOpportunityOpen)
        {
           System.assertEquals('Opportunity is Open', opp.Description);
        }

        for(Opportunity opp : getTestOpportunityClosedWon)
        {
           System.assertEquals('Opportunity is Closed Won', opp.Description);
        }

        for(Opportunity opp : getTestOpportunityClosedLost)
        {
           System.assertEquals('Opportunity is Closed Lost', opp.Description);
        }
        
    }

    @isTest
    private static void CreateTaskOnOpportunityTest()
    {
     
      List<Opportunity> oppList = new List<Opportunity>();

        for(Integer i= 0; i < 201; i++)
        {
           Opportunity opp = new Opportunity();
           opp.Name = 'Test'+i;
           opp.StageName = 'Prospecting';
           opp.CloseDate = System.today();
           opp.Amount = 200000;
           oppList.add(opp);
        }

        Test.startTest();
        insert oppList;
        Test.stopTest();

        System.Assert.areEqual(201,oppList.size());

        List<Task> taskList = [Select ID, WhatID, OwnerId from Task Where WhatID IN : oppList];

        Map<Id,ID> taskMap = new Map<ID,ID>();

        for(Task tsk : taskList)
        {
          taskMap.put(tsk.WhatID, tsk.OwnerId);
        }

        for(Opportunity opp : oppList)
        {
           System.Assert.areEqual(opp.ID, taskMap.get(opp.id));
        }
     
    }

}