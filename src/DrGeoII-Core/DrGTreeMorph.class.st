Class {
	#name : #DrGTreeMorph,
	#superclass : #MorphTreeMorph,
	#category : #DrGeoII-Core-UI
}

{ #category : #events-processing }
DrGTreeMorph >> mouseMove: anEvent [
	anEvent redButtonPressed ifTrue: [
		(anEvent endPoint - anEvent startPoint) y < 0 
			ifTrue: [scrollBar scrollDown: 2]
			ifFalse: [scrollBar scrollUp: 2]]	 
		
]

{ #category : #'stepping and presenter' }
DrGTreeMorph >> step [
	self updateList
]

{ #category : #testing }
DrGTreeMorph >> stepTime [ 
	 ^2000
]

{ #category : #updating }
DrGTreeMorph >> updateList [ 
	|value|
	value := scrollBar value.
	super updateList.
	self vScrollValue: value
]

{ #category : #testing }
DrGTreeMorph >> wantsSteps [ 
	^ true
]
