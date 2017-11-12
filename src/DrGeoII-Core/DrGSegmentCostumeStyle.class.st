Class {
	#name : #DrGSegmentCostumeStyle,
	#superclass : #DrGFinitCurveCostumeStyle,
	#instVars : [
		'mark'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #'as yet unclassified' }
DrGSegmentCostumeStyle >> initialize [
	super initialize.
	self color: DrGStylePreference current segmentColor.
	self lineStyle: DrGStylePreference current segmentStyle.
	self thickness: DrGStylePreference current segmentThickness.
	self mark: DrGStylePreference current segmentMark.
	self arrow: DrGStylePreference current segmentArrow
]

{ #category : #accessing }
DrGSegmentCostumeStyle >> mark [
	^ mark ifNil: [mark := #none]
]

{ #category : #accessing }
DrGSegmentCostumeStyle >> mark: aSymbol [
	mark := aSymbol.
	self changed
]

{ #category : #accessing }
DrGSegmentCostumeStyle >> markIndex [
	mark ifNil: [mark := #none].
	^DrGStylePreference markIndexOf: mark
]

{ #category : #accessing }
DrGSegmentCostumeStyle >> markIndex: index [
	self mark: (DrGStylePreference markFor: index)
]

{ #category : #widget }
DrGSegmentCostumeStyle >> markMorphCollection [
	^ DrGStylePreference markMorphCollection
]

{ #category : #widget }
DrGSegmentCostumeStyle >> markWidget [
	^ 'Mark' translated ->
		(self view
			newMorphDropListFor: self
			list: #markMorphCollection
			getSelected: #markIndex
			setSelected: #markIndex:
			help: 'Set a mark to the segment.' translated)
]

{ #category : #widget }
DrGSegmentCostumeStyle >> myWidgets [ 
	^ super myWidgets addAll: {self markWidget}; yourself
]

{ #category : #'xml writing' }
DrGSegmentCostumeStyle >> writeAttributesTo: aNode [
	super writeAttributesTo: aNode.
	aNode attributeAt: #mark put: self mark
]
