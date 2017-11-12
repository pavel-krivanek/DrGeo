Class {
	#name : #DrGBitmapMorph,
	#superclass : #Morph,
	#instVars : [
		'costume',
		'blink',
		'paintResource'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #geometry }
DrGBitmapMorph >> adoptPaneColor: paneColor [
	"We do not want this"

]

{ #category : #accessing }
DrGBitmapMorph >> costume [
	^ costume 
]

{ #category : #accessing }
DrGBitmapMorph >> costume: aCostume [
	costume := aCostume.
]

{ #category : #drawing }
DrGBitmapMorph >> drawOnAthensCanvas: aCanvas [
	| borderPath width |
	aCanvas setPaint: paintResource getCheckedResource.
	aCanvas paintTransform restoreAfter: [
		aCanvas paintTransform translateBy: self innerBounds origin "negated".
		aCanvas paintTransform scaleBy: costume myScale.
		aCanvas drawShape: self innerBounds].
	width := self borderWidth.
	borderPath := aCanvas createPath: [ :builder |
		builder absolute.
		builder 
			moveTo: self position + width asPoint;
			lineTo: self topRight + (width negated @ width);
			lineTo: self bottomRight - width asPoint;
			lineTo: self bottomLeft + (width @ width negated);
			lineTo: self position + width asPoint].
	aCanvas setShape: borderPath.
	(aCanvas  setStrokePaint: self borderColor) width: width.
	aCanvas draw.
	

]

{ #category : #accessing }
DrGBitmapMorph >> extent [
"defined by my paint, cannot change"
	self extent: paintResource getCheckedResource extent.
	^ bounds extent
]

{ #category : #accessing }
DrGBitmapMorph >> extent: aPoint [
	| newExtent |
	newExtent := (self borderWidth * 2) asPoint + (aPoint * costume myScale) asIntegerPoint.
	(bounds extent closeTo: newExtent ) ifTrue: [ ^self ].
	self changed.
	bounds := (bounds topLeft extent: newExtent).
	self layoutChanged.
	self changed.
]

{ #category : #'event handling' }
DrGBitmapMorph >> handlesMouseDown: evt [
	^ false
]

{ #category : #initialization }
DrGBitmapMorph >> initialize [ 
	super initialize.
	self borderWidth: 2.
	self borderColor: Color black.
	blink := false.
]

{ #category : #'*DrGeoII-Core' }
DrGBitmapMorph >> isMorphCostume [
	^ true
]

{ #category : #accessing }
DrGBitmapMorph >> paintResource: anAthensPaint [
	paintResource := anAthensPaint .
	self changed
]

{ #category : #'stepping and presenter' }
DrGBitmapMorph >> startBlinking [ 
	blink := true.
	self startStepping
]

{ #category : #'stepping and presenter' }
DrGBitmapMorph >> step [
	blink ifFalse: [^self].
	super step.
	self borderColor = DrGStylePreference blinkingColor 
		ifTrue: [self borderColor: costume style color]
		ifFalse: [self borderColor: DrGStylePreference blinkingColor].

]

{ #category : #'stepping and presenter' }
DrGBitmapMorph >> stepTime [
	^ 500
]

{ #category : #'stepping and presenter' }
DrGBitmapMorph >> stopBlinking [
	blink := false.
	self stopStepping.
]

{ #category : #'stepping and presenter' }
DrGBitmapMorph >> stopStepping [
	super stopStepping.
	self borderColor: costume style color.
]
