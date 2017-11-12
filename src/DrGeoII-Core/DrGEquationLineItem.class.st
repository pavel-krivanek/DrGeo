"
a line equation: 
- provide a and b for the reduced equation: y = a . x + b
- provide m otherwise for the equation x = m

"
Class {
	#name : #DrGEquationLineItem,
	#superclass : #DrGEquationItem,
	#instVars : [
		'a',
		'b',
		'c'
	],
	#category : #DrGeoII-Core-Item
}

{ #category : #accessing }
DrGEquationLineItem >> a [
	^ a
]

{ #category : #accessing }
DrGEquationLineItem >> a: aNumber [
	a := aNumber
]

{ #category : #accessing }
DrGEquationLineItem >> b [
	^ b
]

{ #category : #accessing }
DrGEquationLineItem >> b: aNumber [
	b := aNumber
]

{ #category : #accessing }
DrGEquationLineItem >> c [
	^ c
]

{ #category : #accessing }
DrGEquationLineItem >> c: aNumber [
	c := aNumber
]

{ #category : #accessing }
DrGEquationLineItem >> cartesianEquation [
	^ String streamContents: [:stream |
		a isZero ifFalse: [
			a = 1 ifFalse: [self printDecimal: a on: stream].
			stream	nextPutAll: 'x'].
		b isZero ifFalse: [
			a isZero ifFalse: [stream nextPutAll: ' + '].
			b = 1 ifFalse: [self printDecimal: b on: stream].
			stream	nextPutAll: 'y'].
		c isZero ifFalse: [
			stream nextPutAll: ' + '.
			self printDecimal: c on: stream].
		stream nextPutAll: ' = 0']
]

{ #category : #accessing }
DrGEquationLineItem >> equation [ 
	^ value := self reducedEquation 
]

{ #category : #testing }
DrGEquationLineItem >> isVerifiedBy: aPoint [
	^ parents first isCollinearWith: (parents first origin - aPoint)
]

{ #category : #'xml writing' }
DrGEquationLineItem >> nodeType [
	^#line
]

{ #category : #accessing }
DrGEquationLineItem >> reducedEquation [
	^ b isZero 
		ifTrue:  [String streamContents: [:stream |
			stream nextPutAll: 'x = '.
			self printDecimal: c negated / a on: stream]]
		ifFalse: [String streamContents: [:stream |
			stream nextPutAll: 'y = '.
			a isZero 
				ifTrue: [self printDecimal: c negated / b on: stream] 
				ifFalse: [| slope |
					slope := a negated / b.
					slope = 1 
						ifTrue: [stream nextPutAll: 'x'.
							c isZero ifFalse: [
								stream nextPutAll: ' + '.
								self printDecimal: c negated / b on: stream]]
						ifFalse: [
							slope = -1 
								ifTrue: [stream nextPutAll: '- x'.
									c isZero ifFalse: [
										stream nextPutAll: ' + '.
										self printDecimal: c negated / b on: stream]] 
								ifFalse: [
									self printDecimal: slope on: stream.
									stream nextPutAll: ' * x'.
									c isZero ifFalse: [
										stream nextPutAll: ' + '.
										self printDecimal: c negated / b on: stream]]]]]]
]

{ #category : #updating }
DrGEquationLineItem >> update [
	self doParentsExist ifTrue: [ |u origin|
		u := parents first direction.
		origin := parents first origin.
		self a: u y.
		self b: u x negated.
		self c: origin y * u x - (origin x * u y)]
]
