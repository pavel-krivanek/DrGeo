Class {
	#name : #DrGPointCostumeStyle,
	#superclass : #DrGCostumeStyle,
	#instVars : [
		'shape',
		'pointSize'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGPointCostumeStyle >> abscissa [
	^ self mathItem point x asString
]

{ #category : #accessing }
DrGPointCostumeStyle >> abscissa: aText [
	|number|
	[number := aText asString asNumber]
		on: Error
		do: [^ false].
	self mathItem x: number.
	self changed.
	^ true
]

{ #category : #accessing }
DrGPointCostumeStyle >> curvilinearAbscissa [
	^ self mathItem abscissa asString
]

{ #category : #accessing }
DrGPointCostumeStyle >> curvilinearAbscissa: aText [
	|number|
	[number := aText asString asNumber]
		on: Error
		do: [^ false].
	self mathItem abscissa: number.
	self changed.
	^ true
]

{ #category : #widget }
DrGPointCostumeStyle >> freePointOnCurvePropertyWidget [
	^ Array with: ('Curvilinear abscissa' translated ->
		((self view
			newTextEntryFor: self
			getText: #curvilinearAbscissa  
			setText: #curvilinearAbscissa: 
			help: 'Edit this curvilinear abscissa in [0;1].' translated) minWidth: 10;
				acceptAction: [:text| 
					(self curvilinearAbscissa: text) ifTrue:
						[costume domain propertyCommandFor: self mathItem with: self mathItem abscissa]]))
]

{ #category : #widget }
DrGPointCostumeStyle >> freePointPropertyWidget [
	|widgetX widgetY|
	widgetX := 'X' ->
		((self view
			newTextEntryFor: self
			getText: #abscissa  
			setText: #abscissa: 
			help: 'Edit this abscissa.' translated) minWidth: 10;
				acceptAction: [:text| 
					(self abscissa: text) ifTrue:
						[costume domain propertyCommandFor: self mathItem with: self mathItem point]]).
	widgetY := 'Y' ->
		((self view
			newTextEntryFor: self
			getText: #ordinate  
			setText: #ordinate: 
			help: 'Edit this ordinate.' translated) minWidth: 10;
				acceptAction: [:text| 
					(self ordinate: text) ifTrue:
						[costume domain propertyCommandFor: self mathItem with: self mathItem point]]).
	^ Array with: widgetX with: widgetY
]

{ #category : #initialize-release }
DrGPointCostumeStyle >> initialize [
	super initialize.
	self color: DrGStylePreference current pointColor.
	self pointSize: DrGStylePreference current pointSize.
	self shape: DrGStylePreference current pointShape
]

{ #category : #widget }
DrGPointCostumeStyle >> myWidgets [ 
	^ super myWidgets addAll: {self shapeWidget. self sizeWidget}; yourself
]

{ #category : #accessing }
DrGPointCostumeStyle >> ordinate [
	^ self mathItem point y asString
]

{ #category : #accessing }
DrGPointCostumeStyle >> ordinate: aText [
	|number|
	[number := aText asString asNumber]
		on: Error
		do: [^ false].
	self mathItem y: number.
	self changed.
	^ true
]

{ #category : #accessing }
DrGPointCostumeStyle >> pointSize [
	"Answer the value of thickness"

	^ pointSize
]

{ #category : #accessing }
DrGPointCostumeStyle >> pointSize: anObject [
	"Set the value of thickness"
	pointSize := anObject.
	costume pointSize: (DrGStylePreference pointExtentFor: anObject).
	self changed

]

{ #category : #accessing }
DrGPointCostumeStyle >> pointSizeIndex [
	"Answer the index of thickness"
	^DrGStylePreference pointSizeIndexOf: pointSize
]

{ #category : #accessing }
DrGPointCostumeStyle >> pointSizeIndex: index [
	"Set the value of thickness"
	self pointSize: (DrGStylePreference pointSizeFor: index).
]

{ #category : #accessing }
DrGPointCostumeStyle >> shape [
	"Answer the value of shape"

	^ shape
]

{ #category : #accessing }
DrGPointCostumeStyle >> shape: anObject [
	"Set the value of shape"
	shape := anObject.
	self changed.
]

{ #category : #accessing }
DrGPointCostumeStyle >> shapeIndex [
	"Answer the index of the shape"
	^ DrGStylePreference pointShapeIndexOf: shape
]

{ #category : #accessing }
DrGPointCostumeStyle >> shapeIndex: index [
	"Set the value of shape"
	self shape: (DrGStylePreference pointShapeFor: index)
]

{ #category : #widget }
DrGPointCostumeStyle >> shapeMorphCollection [
	^ DrGStylePreference shapeMorphCollection 
]

{ #category : #widget }
DrGPointCostumeStyle >> shapeWidget [
	^  'Shape' translated ->
		(self view
			newMorphDropListFor: self 
			list: #shapeMorphCollection
			getSelected: #shapeIndex
			setSelected: #shapeIndex: 
			help: 'Set the shape of the point.' translated)
]

{ #category : #widget }
DrGPointCostumeStyle >> sizeMorphCollection [
	^ DrGStylePreference sizeMorphCollection 
]

{ #category : #widget }
DrGPointCostumeStyle >> sizeWidget [
	^  'Size' translated ->
		(self view
			newMorphDropListFor: self 
			list: #sizeMorphCollection
			getSelected: #pointSizeIndex
			setSelected: #pointSizeIndex: 
			help: 'Set the size of the point.' translated)
]

{ #category : #'xml writing' }
DrGPointCostumeStyle >> writeAttributesTo: aNode [
	|attr|
	super writeAttributesTo: aNode.
	self pointSize = #small ifTrue: [attr := 'Dashed'].
	self pointSize = #medium ifTrue: [attr := 'Normal'].
	self pointSize = #large ifTrue: [attr := 'Thick'].
	aNode attributeAt: #thickness put: attr.
	attr := self shape asString capitalized.
	self shape = #square ifTrue: [attr := 'Rectangular'].
	self shape = #round ifTrue: [attr := 'Round'].
	aNode attributeAt: #style put: attr
]
