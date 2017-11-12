Class {
	#name : #DrGeoScript124513830,
	#superclass : #DrGeoUserScript,
	#category : #DrGeoII-User
}

{ #category : #public }
DrGeoScript124513830 class >> description [
	^'A script to test access to its costume (see compute method)'
]

{ #category : #private }
DrGeoScript124513830 class >> newArgumentsType [
	^{}
]

{ #category : #public }
DrGeoScript124513830 class >> scriptName [
	^'Test my costume'
]

{ #category : #public }
DrGeoScript124513830 >> compute [
"Edit me"
	self costume ifNotNil: [self costume style color: Color red ].
	^1+1
]
