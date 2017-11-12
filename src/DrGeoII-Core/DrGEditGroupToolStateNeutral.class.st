Class {
	#name : #DrGEditGroupToolStateNeutral,
	#superclass : #DrGSelectToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGEditGroupToolStateNeutral >> handleChoice: aCostumeCollection [
	aCostumeCollection 
		ifNotEmpty: 
			[self context costume: aCostumeCollection first.
			self switchState: DrGEditGroupToolStateSelected.
			^true]
		ifEmpty:
			[self context reset.
			^false]
		

]

{ #category : #handling }
DrGEditGroupToolStateNeutral >> handleMouseAt: aPoint [ 
	| costumes aTip |
	costumes := self context compositeCostumesAt: aPoint.
	costumes
		ifEmpty: [self area hideTip.
			^ false].
	costumes size > 1
		ifTrue: [aTip := 'Several objects can be selected. Please, select one clicking the mouse.' translated]
		ifFalse: [aTip := costumes first mathItem descriptiveName].
	self area tip: aTip at: aPoint.
	^ true
]

{ #category : #handling }
DrGEditGroupToolStateNeutral >> handlePress: aPoint [
	|costumes|
	self area hideTip.
	costumes := self context compositeCostumesAt: aPoint.
	costumes isEmptyOrNil ifTrue: [^false].
	costumes size = 1
		ifTrue:
			[^self handleChoice: costumes.]
		ifFalse:
			[^self context chooseCostume: costumes].
]
