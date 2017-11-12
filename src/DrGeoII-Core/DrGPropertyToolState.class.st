Class {
	#name : #DrGPropertyToolState,
	#superclass : #DrGStyleToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGPropertyToolState >> handleChoice: aCostumeCollection [
	aCostumeCollection 
		ifNotEmpty: 
			[self context costume: aCostumeCollection first.
			aCostumeCollection first editMyProperty].

]
