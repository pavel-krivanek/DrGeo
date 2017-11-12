Class {
	#name : #DrGDeleteToolState,
	#superclass : #DrGStyleToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGDeleteToolState >> handleChoice: aCostumeCollection [
	aCostumeCollection 
		ifNotEmpty: 
			[self context presenter 
				deleteMathItem: aCostumeCollection first;
				selectToolAfterBuilding].
	self context reset
]
