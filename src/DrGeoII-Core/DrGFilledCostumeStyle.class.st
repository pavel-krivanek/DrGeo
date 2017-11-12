Class {
	#name : #DrGFilledCostumeStyle,
	#superclass : #DrGFinitCurveCostumeStyle,
	#instVars : [
		'fill',
		'translucent'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGFilledCostumeStyle >> fill [
	^ self isFilled
]

{ #category : #accessing }
DrGFilledCostumeStyle >> fill: boolean [
	fill := boolean.
	self color: color.
	self changed
]

{ #category : #widget }
DrGFilledCostumeStyle >> fillWidget [
	^ 'Fill' translated ->
		(self view
			newCheckboxFor: self 
			getSelected: #fill
			setSelected: #fill: 
			label:  '          ' 
			help:  'Toggle to fill the object.' translated)
]

{ #category : #accessing }
DrGFilledCostumeStyle >> isFilled [
	^ fill ifNil: [fill := false]
]

{ #category : #accessing }
DrGFilledCostumeStyle >> isTranslucent [
	^ translucent ifNil: [translucent := false]
]

{ #category : #widget }
DrGFilledCostumeStyle >> myWidgets [ 
	^ super myWidgets addAll: {self fillWidget. self translucentWidget}; yourself
]

{ #category : #accessing }
DrGFilledCostumeStyle >> toggleFilled [
	self fill: fill not.
	self changed
]

{ #category : #accessing }
DrGFilledCostumeStyle >> toggleTranslucent [
	self translucent: translucent not.
	self changed
]

{ #category : #accessing }
DrGFilledCostumeStyle >> translucent [
	^ self isTranslucent 
]

{ #category : #accessing }
DrGFilledCostumeStyle >> translucent: boolean [
	translucent := boolean.
	self color: color.
]

{ #category : #widget }
DrGFilledCostumeStyle >> translucentWidget [
	^ 'Translucent' translated ->
		(self view
			newCheckboxFor: self 
			getSelected: #translucent
			setSelected: #translucent: 
			label:  '          '  
			help:  'Toggle the translucency of the object.' translated)
]

{ #category : #'xml writing' }
DrGFilledCostumeStyle >> writeAttributesTo: aNode [
	super writeAttributesTo: aNode.
	aNode attributeAt: #filled put: self isFilled asString capitalized.
	aNode attributeAt: #translucent put: self isTranslucent asString capitalized
]
