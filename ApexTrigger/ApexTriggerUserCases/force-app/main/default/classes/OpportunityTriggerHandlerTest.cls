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

}
