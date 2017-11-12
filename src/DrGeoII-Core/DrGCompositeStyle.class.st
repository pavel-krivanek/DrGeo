Class {
	#name : #DrGCompositeStyle,
	#superclass : #DrGFinitCurveCostumeStyle,
	#instVars : [
		'shape'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGCompositeStyle >> shape [
	^shape
]

{ #category : #accessing }
DrGCompositeStyle >> shape: anObject [
	shape := anObject.
	costume shape: anObject
]
