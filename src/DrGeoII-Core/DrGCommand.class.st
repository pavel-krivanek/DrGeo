Class {
	#name : #DrGCommand,
	#superclass : #Object,
	#instVars : [
		'domain'
	],
	#category : #DrGeoII-Core-Command
}

{ #category : #accessing }
DrGCommand >> domain: aDomain [
	domain := aDomain.
]

{ #category : #command }
DrGCommand >> execute [
	self subclassResponsibility 
]

{ #category : #command }
DrGCommand >> unexecute [
	self subclassResponsibility 
]
