Class {
	#name : #DrGEquationItem,
	#superclass : #DrGComputedValueItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #private }
DrGEquationItem >> adaptiveDescriptiveName [
	^ 'This equation %1' translated
]

{ #category : #accessing }
DrGEquationItem >> basicType [
	^#equation
]

{ #category : #accessing }
DrGEquationItem >> equation [
"a string representing the equation"
	^ ''
]

{ #category : #'*DrGeoII-Core-testing' }
DrGEquationItem >> isEquation [ 
	^ true
]

{ #category : #'*DrGeoII-Core-testing' }
DrGEquationItem >> isValueItem [ 
	^ false
]

{ #category : #testing }
DrGEquationItem >> isVerifiedBy: aPoint [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
DrGEquationItem >> printOn: aStream [
	self printType: 'Equation' translated on: aStream.
	self printValueOn: aStream 
]

{ #category : #printing }
DrGEquationItem >> printValueOn: aStream [ 
	aStream nextPutAll: value
]

{ #category : #accessing }
DrGEquationItem >> valueItem [
	^ self equation 
]
