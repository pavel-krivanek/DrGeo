Class {
	#name : #DrGViewerToolState,
	#superclass : #DrGStyleToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGViewerToolState >> handleChoice: aCostumeCollection [
	aCostumeCollection 
		ifNotEmpty: 
			[self context presenter 
				openViewerForCostume: aCostumeCollection first].
	self context reset
]
