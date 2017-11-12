Class {
	#name : #DrGPolylineMorph,
	#superclass : #PolygonMorph,
	#instVars : [
		'blink',
		'costume'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGPolylineMorph >> blink: aBoolean [
	blink := aBoolean 
]

{ #category : #'geometry testing' }
DrGPolylineMorph >> containsPoint: aPoint [
	self lineSegmentsDo:
		[:p1 :p2 |
		(aPoint onLineFrom: p1 to: p2 within: 20.0)
				ifTrue: [^ true]].
	^ false
]

{ #category : #accessing }
DrGPolylineMorph >> costume [
	^costume
]

{ #category : #accessing }
DrGPolylineMorph >> costume: aCostume [
	costume := aCostume
]

{ #category : #drawing }
DrGPolylineMorph >> drawArrowOnAthensCanvas: aCanvas at: endPoint from: priorPoint [
	| points wingBase trianglePath|
	points := self arrowBoundsAt: endPoint from: priorPoint.
	wingBase := points size = 4 
				ifTrue: [points third]
				ifFalse: [(points copyFrom: 2 to: 3) average].
	trianglePath := aCanvas createPath: [ :builder | 
		builder 	absolute.
		builder moveTo: (points first).
		points allButFirstDo: [ :pt | builder lineTo: pt ].			
		closed ifTrue: [ builder lineTo: points first ]	].

	aCanvas setShape: trianglePath.
	aCanvas setPaint: self fillStyle. aCanvas draw.
	aCanvas draw.
	^ wingBase 
]

{ #category : #drawing }
DrGPolylineMorph >> drawArrowsOnAthensCanvas: aCanvas [
	"Answer (possibly modified) endpoints for border drawing"
	"ArrowForms are computed only upon demand"
	| array |

	self hasArrows
		ifFalse: [^ #() ].
	"Nothing to do"

	array := Array with: vertices first with: vertices last.

	"Prevent crashes for #raised or #inset borders"
	borderColor isColor
		ifFalse: [ ^array ].

	(arrows == #forward or: [arrows == #both])
		ifTrue: [ array at: 2 put: (self
				drawArrowOnAthensCanvas: aCanvas
				at: vertices last
				from: self nextToLastPoint) ].

	(arrows == #back or: [arrows == #both])
		ifTrue: [ array at: 1 put: (self
				drawArrowOnAthensCanvas: aCanvas
				at: vertices first
				from: self nextToFirstPoint) ].

	^array
]

{ #category : #drawing }
DrGPolylineMorph >> drawOn: aCanvas [ 
	|array |
	closed ifTrue:
		[aCanvas drawPolygon: self getVertices fillStyle: self fillStyle].
	array := self drawArrowsOn: aCanvas.
	self drawBorderOn: aCanvas usingEnds: array.

]

{ #category : #drawing }
DrGPolylineMorph >> drawOnAthensCanvas: aCanvas [ 
	| polyPath points |
	
	points := self getVertices.
	polyPath := aCanvas createPath: [ :builder | 
		builder 	absolute.
		builder moveTo: (points first).
		points allButFirstDo: [ :pt | builder lineTo: pt ].			
		closed ifTrue: [ builder lineTo: points first ]	].

	aCanvas setShape: polyPath.
	closed	ifTrue: [ aCanvas setPaint: self fillStyle. aCanvas draw. ].
		
	(aCanvas setStrokePaint: self borderStyle color) 
		width: self borderWidth;
		dashes: self dashedBorder offset: 0.
	
	aCanvas draw.

	self drawArrowsOnAthensCanvas: aCanvas
]

{ #category : #'event handling' }
DrGPolylineMorph >> handlesMouseDown: evt [
	^ false
]

{ #category : #initialization }
DrGPolylineMorph >> initialize [
	owner := nil.
	submorphs := EmptyArray.
	bounds := self defaultBounds.
	color := self defaultColor.
	self borderInitialize.
	arrows := #none.
	vertices := Array with: 5 @ 0 with: 20 @ 10	with: 0 @ 20.
	self makeOpenAndStraight.
	blink := false.
	self sticky: true.
]

{ #category : #'*DrGeoII-Core-testing' }
DrGPolylineMorph >> isMorphCostume [
	^true
]

{ #category : #initialization }
DrGPolylineMorph >> makeOpenAndStraight. [
	smoothCurve := false.
	closed := false.
	self computeBounds.
]

{ #category : #'stepping and presenter' }
DrGPolylineMorph >> startBlinking [
	blink := true.
	self startStepping.
]

{ #category : #'stepping and presenter' }
DrGPolylineMorph >> step [
	blink ifFalse: [^self].
	super step.
	self borderColor = DrGStylePreference blinkingColor 
		ifTrue: [self borderColor: costume style borderColor]
		ifFalse: [self borderColor: DrGStylePreference blinkingColor]
]

{ #category : #'stepping and presenter' }
DrGPolylineMorph >> stepTime [
	^500
]

{ #category : #'stepping and presenter' }
DrGPolylineMorph >> stopBlinking [
	blink := false.
	self stopStepping.
]

{ #category : #'stepping and presenter' }
DrGPolylineMorph >> stopStepping [
	super stopStepping.
	self color: (costume style isFilled ifTrue: [costume style color] ifFalse: [Color transparent]).
	self borderColor: costume style borderColor.
]
