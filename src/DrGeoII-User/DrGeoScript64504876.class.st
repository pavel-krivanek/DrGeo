Class {
	#name : #DrGeoScript64504876,
	#superclass : #DrGeoUserScript,
	#instVars : [
		'counter',
		'direction'
	],
	#category : #DrGeoII-User
}

{ #category : #public }
DrGeoScript64504876 class >> description [
	^'Apply a random mark over a segment.'
]

{ #category : #private }
DrGeoScript64504876 class >> newArgumentsType [
	^{DrGSegmentItem}
]

{ #category : #public }
DrGeoScript64504876 class >> scriptName [
	^'Segment mark'
]

{ #category : #public }
DrGeoScript64504876 >> compute [
"Edit me"
	self costume1 style mark: (#(#mark1 #mark1 #mark2 #mark2 #mark3 #mark3) at: self counter).
	self incCounter.
	^ self class scriptName,  '
	 hello ! mais ce n''est pas un script'
]

{ #category : #'as yet unclassified' }
DrGeoScript64504876 >> counter [
	counter ifNil: [ counter := 1 ].
	counter < 1 ifTrue: [ counter :=1 ].
	counter > 6 ifTrue: [ counter := 6 ].
	^ counter
]

{ #category : #'as yet unclassified' }
DrGeoScript64504876 >> direction [
	^ direction ifNil: [ direction := 1 ]
]

{ #category : #'as yet unclassified' }
DrGeoScript64504876 >> incCounter [
	counter := counter + self direction.
	(counter > 6 or: [counter < 1]) ifTrue: [ 
		self toggleDirection.
		counter := counter + self direction ]
]

{ #category : #'as yet unclassified' }
DrGeoScript64504876 >> toggleDirection [
	self direction = 1 
		ifTrue: [ direction := -1 ]
		ifFalse: [ direction := 1 ]
]
