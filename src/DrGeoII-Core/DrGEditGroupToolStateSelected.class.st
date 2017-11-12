Class {
	#name : #DrGEditGroupToolStateSelected,
	#superclass : #DrGSelectToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGEditGroupToolStateSelected >> handleChoice: aCostumeCollection [
"if the costume does not bellong to the composite add it, 
otherwise remove it from the composite"
|compositeCostume itemCostume|
	aCostumeCollection ifEmpty:
			[self context reset.
			^false].
	compositeCostume := self context costume.
	itemCostume := aCostumeCollection first.
	(compositeCostume mathItem subItems includes: itemCostume mathItem)
		ifTrue:  [compositeCostume removeCostume: itemCostume]
		ifFalse: [compositeCostume addCostume: itemCostume].
	compositeCostume stopBlinking;startBlinking.
	^true.
]

{ #category : #handling }
DrGEditGroupToolStateSelected >> handlePress: aPoint [
	| costumes |
	self area hideTip.
	costumes := self context costumesAt: aPoint.
	costumes size = 1
		ifTrue:
			[^self handleChoice: costumes].
	costumes size > 1 
		ifTrue:
			[^self context chooseCostume: costumes].
	self context reset.
	^false.
]
