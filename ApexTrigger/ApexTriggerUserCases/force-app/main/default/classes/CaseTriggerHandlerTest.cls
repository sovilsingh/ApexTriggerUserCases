@isTest
public  class CaseTriggerHandlerTest 
{
     @isTest
     Public Static void UpdateLatestCaseNumberTest()
     {
        List<Case> caseList = new List<Case>();
      //  List<Account> accList = new List<Account>();
      //  for(Integer i=0;i<201;i++)
     //   {
      //      Account acc = new Account();
      //      acc.Name = 'Test'+i;
     //       accList.add(acc);
    //    }
        
      //  Test.StartTest();
      //  Insert accList;
      //  Test.stopTest();

        for(Integer i=0;i<201;i++)
        {
            case cs = new Case();
          //  if(i<100)
         //   {
           // for( Account acc : accList)
         //   {
           // cs.AccountID = acc.id;
            cs.Status = 'New';
            cs.Origin = 'Email';
            caseList.add(cs);
         //   }
         //   }
          //  if(i<101)
          //  {
          //  cs.Status = 'New';
         //   cs.Origin = 'Email';
        //    }
           
        }

        Test.StartTest();
        Insert caseList;
        Test.stopTest();

        List<Case> getCaseListToTest = [Select ID, CaseNumber, AccountID from Case where ID IN : caseList];

        System.assertEquals(getCaseListToTest.size(), 201);

        Set<id> accountids = new Set<ID>();
        for(Case cs : getCaseListToTest)
        {
            accountids.add(cs.AccountID);
        }

        List<Account> getAccountListToTest = [Select ID, Latest_Case_Number__c From Account Where ID IN : accountids];
       
        System.assertEquals(getAccountListToTest.size(), 201);

     }

    @isTest
    Public Static Void UpdateLatestCaseNumberWithAccountTest()
    {
        case cs = new Case();
        cs.AccountID = '0012w000017b8geAAA';
        cs.Status = 'New';
        cs.Origin = 'Email';
       
        Test.StartTest();
        Insert cs;
        Test.stopTest();

        List<Case> getCaseListToTest = [Select ID, CaseNumber, AccountID from Case where ID =: cs.id];
        Set<id> accountids = new Set<ID>();
        for(Case css : getCaseListToTest )
        {
            accountids.add(css.AccountID);
        }

        List<Account> getAccountListTotest = [Select Id, Latest_Case_Number__c From Account Where Id =: accountids];

        System.assertEquals(getCaseListToTest.size(),1);

        System.assertEquals( getAccountListTotest.size(),1);

        System.assertEquals(getCaseListToTest[0].CaseNumber, getAccountListTotest[0].Latest_Case_Number__c);
        
    }

}
