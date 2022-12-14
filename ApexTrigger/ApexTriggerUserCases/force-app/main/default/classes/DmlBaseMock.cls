public abstract class DmlBaseMock implements IDml {
	protected Map<Id, SObject> DB_RECORDS;
	protected Schema.SObjectType OBJECT_TYPE;
	protected MockIdGenerator builder;
	private static final String ID_FIELD = 'Id';

	public DmlBaseMock(Map<Id, SObject> records, String sobjectName) {
		this.DB_RECORDS = records;
		this.OBJECT_TYPE = Schema.getGlobalDescribe().get(sobjectName);
		this.builder = new MockIdGenerator(OBJECT_TYPE);
	}

    @TestVisible
     public DmlBaseMock() {
     // @IsTest classes cannot be virtual, so enforce visibility
      }

	public void insertRecords(List<SObject> newRecords) {
		for (SObject record : newRecords) {
			if (record.get(ID_FIELD) != null) {
				throw new DmlException('Cannot insert a record with an ID.');
			}
			Id recordId = builder.getMockId();
			record.put(ID_FIELD, recordId);
			DB_RECORDS.put((Id)recordId, record);
		}
	}

	public void updateRecords(List<SObject> records) {
		for (SObject record : records) {
			if (record.get(ID_FIELD) == null) {
				throw new DmlException('Records to update must have a record Id.');
			}
			DB_RECORDS.put((Id)record.get(ID_FIELD), record);
		}
	}

	public void upsertRecords(List<SObject> records) {
		for (SObject record : records) {
			if (record.get(ID_FIELD) == null) {
				Id recordId = builder.getMockId();
				record.put(ID_FIELD, recordId);
			}
			DB_RECORDS.put((Id)record.get(ID_FIELD), record);
		}
	}

	public void deleteRecords(List<SObject> records) {
		for (SObject record : records) {
			if (record.get(ID_FIELD) == null) {
				throw new DmlException('Records to delete must have a record Id.');
			}
			DB_RECORDS.remove((Id)record.get(ID_FIELD));
		}
	}
}