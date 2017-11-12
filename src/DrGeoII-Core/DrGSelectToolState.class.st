"
An abstract state for the select tool and derivate.
"
Class {
	#name : #DrGSelectToolState,
	#superclass : #DrGDynamicToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGSelectToolState >> handleChoice: aCostumeCollection [ 
	aCostumeCollection 
		ifNotEmpty: 
			[self context costume: aCostumeCollection first.
			self switchState: DrGSelectToolStateSelected.
			^true]
		ifEmpty: 
			[self context reset.
			^false]
]

{ #category : #accessing }
DrGSelectToolState >> mathItem [ 
"the selected math item"
	^ self context mathItem 
]
