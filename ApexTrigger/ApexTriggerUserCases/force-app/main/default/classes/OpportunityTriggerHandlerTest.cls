@isTest
public class OpportunityTriggerHandlerTest 
{
    @isTest
    public Static void UpdateDescriptionTest()
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
    public Static void UpdateLatestAmountInAccountTest()
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

}
