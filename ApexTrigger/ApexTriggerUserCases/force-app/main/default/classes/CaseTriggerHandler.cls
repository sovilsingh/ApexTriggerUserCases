public class CaseTriggerHandler 
{
    /**
     *  
     */

    @testVisible static IDml DmlDAOInstance = new DmlBase();

    Public Static void UpdateLatestCaseNumber(List<Case> caseList)
    {
       
        List<Account> accList = New List<Account>();
        List<Account> createNewAcc = new List<Account>();
        Map<String,Case> caseMap = new Map<String,Case>();
        List<Case> caseListToUpdate = new list<Case>();
        for(Case  cs : caseList)
        {
            Account acc = new Account();
            if(cs.AccountId != null)
            {
                acc.id = cs.AccountId;
                acc.Latest_Case_Number__c = cs.CaseNumber;
                accList.add(acc);
            }
            if(cs.AccountId == null)
            {
                acc.Name = cs.CaseNumber;
               // System.debug(acc.Name,cs.CaseNumber);
                caseMap.put(acc.Name,cs);
                acc.Latest_Case_Number__c = cs.CaseNumber;
                createNewAcc.add(acc);
            }
            
        }
          
        if(!accList.isEmpty())
        {
            DmlDAOInstance.updateRecords(accList);
           //update accList;
        }

        if(!createNewAcc.isEmpty())
        {
            DmlDAOInstance.insertRecords(createNewAcc);
           //Insert createNewAcc;
        }

        for(Account acc : createNewAcc)
        {
            Case cs = new Case();
            cs.id = caseMap.get(acc.Name).id;
            cs.AccountId = acc.id;
            caseListToUpdate.add(cs);
           
        }

        if(!caseListToUpdate.isEmpty())
        {
            DmlDAOInstance.updateRecords(caseListToUpdate);
            //Update caseListToUpdate;
        }
    }
}
