Class {
	#name : #DrGFinitCurveCostumeStyle,
	#superclass : #DrGCurveCostumeStyle,
	#instVars : [
		'arrow'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGFinitCurveCostumeStyle >> arrow [
	"Answer the value of arrows"

	^ arrow
]

{ #category : #accessing }
DrGFinitCurveCostumeStyle >> arrow: anObject [
	"Set the value of arrows"
	arrow := anObject.
	costume perform: arrow.
	self changed.
]

{ #category : #accessing }
DrGFinitCurveCostumeStyle >> arrowIndex [
	"Answer the index of arrows"

	^ DrGStylePreference arrowIndexOf: arrow
]

{ #category : #accessing }
DrGFinitCurveCostumeStyle >> arrowIndex: index [
	"Set the value of arrows"
	self arrow: (DrGStylePreference arrowFor: index)
]

{ #category : #widget }
DrGFinitCurveCostumeStyle >> arrowMorphCollection [
	^ DrGStylePreference arrowMorphCollection
]

{ #category : #widget }
DrGFinitCurveCostumeStyle >> arrowWidget [
	^ 'Arrow' translated ->
		(self view
			newMorphDropListFor: self
			list: #arrowMorphCollection
			getSelected: #arrowIndex
			setSelected: #arrowIndex:
			help: 'Set arrow(s) to the line.' translated)
]

{ #category : #widget }
DrGFinitCurveCostumeStyle >> myWidgets [
	^ (costume isSegmentCostume or: [costume isArcCostume]) 
		ifTrue: [super myWidgets addAll: {self arrowWidget}; yourself]
		ifFalse: [super myWidgets]
]

{ #category : #'xml writing' }
DrGFinitCurveCostumeStyle >> writeAttributesTo: aNode [
	super writeAttributesTo: aNode.
	costume isCircleCostume ifFalse: [aNode attributeAt: #arrow put: self arrow.]
]
