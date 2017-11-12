"
I represent the area/place where a Drgeo figure is drawn. It is a subpart of the GeometricView
 - valueItem, dottedLines: we can display dotted line between a selected value and its parents
"
Class {
	#name : #DrGDrawable,
	#superclass : #PasteUpMorph,
	#instVars : [
		'balloonTarget',
		'tipOn',
		'selection',
		'app',
		'ox',
		'oy',
		'scale',
		'underMouse',
		'delta',
		'lastMoveEvent',
		'valueItem',
		'dottedLines'
	],
	#category : #DrGeoII-Core-App
}

{ #category : #'instance creation' }
DrGDrawable class >> newOn: aDrgeo [
	^self basicNew app: aDrgeo ; initialize 
]

{ #category : #dropping/grabbing }
DrGDrawable >> acceptDroppingMorph: dropped event: evt [
"Here we encapsulated the image morph (dropped) in a DrGBitmapItem.
We do not really need a builder to do so but we have to process it in the command stack"
	| item |
	item := (DrGBitmapItem newWith: {self morphToWorld: evt cursorPoint})
		data: (DrGSurfacePaintResource forSurfaceProvider:self  withData: (self resizeImage: dropped form));
		insertAtScale: self scale.
	self domain createFromMathItem: item.
]

{ #category : #submorphs-add/remove }
DrGDrawable >> addMorph: newMorph [
	| aLabel |
	newMorph class == DrGLabelMorph ifTrue: [^ self addMorphFront: newMorph].
	aLabel := self mostBehindLabel.
	aLabel 
		ifNil: [self addMorphFront: newMorph]  
		ifNotNil: [self addMorph: newMorph behind: aLabel]
]

{ #category : #accessing }
DrGDrawable >> app [
	^app
]

{ #category : #accessing }
DrGDrawable >> app: aDrgeo [
	app := aDrgeo
]

{ #category : #axes }
DrGDrawable >> axesVisible [
	^ self hasProperty: #axesVisible
]

{ #category : #axes }
DrGDrawable >> axesVisibleOnOff [
	self setProperty: #axesVisible toValue: self axesVisible not.
	self changed
]

{ #category : #genie-command }
DrGDrawable >> circle: aCRGesture [
| center aPoint circle|
	center := self getCircleCenter: aCRGesture.
	aPoint := self getCirclePoint: aCRGesture.
	circle := DrGCircle2ptsItem newWith: {center . aPoint}.
	app domain createFromMathItem: circle
]

{ #category : #geometry }
DrGDrawable >> defaultScalePosition [
	ox := oy := 0.0.
	scale := 34.0.
	self updateGrid.
	app redrawCostumes 
]

{ #category : #initialize-release }
DrGDrawable >> dismissMorph [
	super dismissMorph.
	app view dismissMorph 
]

{ #category : #accessing }
DrGDrawable >> domain [
	^ app domain
]

{ #category : #drawing }
DrGDrawable >> dottedLinesToParentsOf: anItem [
	| point pointWorld | 
	(anItem isValueItem not or: [anItem parents isEmptyOrNil]) ifTrue: [^self ].
	valueItem := anItem.
	point := (self app costumeOf: valueItem) morph center.
	pointWorld := self morphToWorld: point.
	dottedLines := valueItem parents collect: [:item |
		(DrGLineMorph 
			from: point
			to: (self worldToMorph: (item closestPointTo: pointWorld)) 
			color: Color red 
			width: 1) dashedBorder:  {1. 5}].
	dottedLines do: [:line | self addMorphFront: line].
]

{ #category : #genie-command }
DrGDrawable >> down: aNumber [
	oy := oy + (self pixelToWorld: aNumber).
	app redrawCostumes.

]

{ #category : #'drawing axes & grid' }
DrGDrawable >> drawAxesOn: aCanvas [
	| origin worldBound grad |
	origin := self worldToMorph: 0@0.
	aCanvas 
		line: (self position x + 1) @ origin y  to: (self right - 1) @ origin y width: 2 color: Color lightGray;
		line: origin x @ (self position y + 1) to: origin x @ (self bottom -1) width: 2 color: Color lightGray.
	worldBound := self worldBound.
	"x-axis label in [0 ; +inf["
	grad := 0.
	0 to: (worldBound corner x - delta roundTo: delta) by: delta do: [:x |
		aCanvas 
			drawString: (self labelForAxes: grad)
			at: (self worldAbscissaToMorph: x) @ origin y + (1@1)
			font: DrGDefault canvasFont 
			color: Color lightGray  .
		grad := grad + delta].
	"x-label in ]-inf ; x["
	grad := delta negated.
	grad to: (worldBound origin x roundTo: delta) by: delta negated do: [:x |
		aCanvas 
			drawString: (self labelForAxes: grad)
			at: (self worldAbscissaToMorph: x) @ origin y + (1@1)
			font: DrGDefault canvasFont 
			color: Color lightGray.
		grad := grad - delta].		
	"y-label in [0 ; +inf["
	grad := delta.
	delta to: (worldBound corner y roundTo: delta) by: delta do: [:y |
		aCanvas 
			drawString: (self labelForAxes: grad)
			at: origin x @ (self worldOrdinateToMorph: y) + (1@1)
			font: DrGDefault canvasFont 
			color: Color lightGray  .
		grad := grad + delta].
	"y-label in ]-inf ; 0["
	grad := delta negated.
	grad to: (worldBound origin y roundTo: delta) by: delta negated do: [:y |
		aCanvas 
			drawString: (self labelForAxes: grad)
			at: origin x @ (self worldOrdinateToMorph: y) + (1@1)
			font: DrGDefault canvasFont 
			color: Color lightGray  .
		grad := grad - delta].
	

]

{ #category : #'drawing axes & grid' }
DrGDrawable >> drawAxesOnAthens: aCanvas [
	| origin worldBound grad |
	origin := self worldToMorph: 0@0.
	self line: (self position x + 1) @ origin y 
		to: (self right - 1) @ origin y 
		width: 1
		color: Color lightGray
		onAthens: aCanvas.
	self line: origin x @ (self position y + 1)
		to: origin x @ (self bottom -1)
		width: 1
		color: Color lightGray
		onAthens: aCanvas.
	worldBound := self worldBound.

	aCanvas pathTransform restoreAfter: [
	aCanvas pathTransform scaleBy: 1.00001.
	"x-axis label in [0 ; +inf["
		grad := 0.
		0 to: (worldBound corner x - delta roundTo: delta) by: delta do: [:x |
			aCanvas 	morphicDrawString: (self labelForAxes: grad)
				at: (self worldAbscissaToMorph: x) @ origin y + (1@1)
				font: DrGDefault canvasFont 
				color: Color lightGray.
			self line: (self worldAbscissaToMorph: x) @ origin y - (0@2) 
				to:  (self worldAbscissaToMorph: x) @ origin y + (0@2)
				width: 1
				color: Color lightGray
				onAthens: aCanvas.
			grad := grad + delta].
		"x-label in ]-inf ; x["
		grad := delta negated.
		grad to: (worldBound origin x roundTo: delta) by: delta negated do: [:x |
			aCanvas 	morphicDrawString: (self labelForAxes: grad)
				at: (self worldAbscissaToMorph: x) @ origin y + (1@1)
				font: DrGDefault canvasFont 
				color: Color lightGray.
			self line: (self worldAbscissaToMorph: x) @ origin y - (0@2) 
				to:  (self worldAbscissaToMorph: x) @ origin y + (0@2)
				width: 1
				color: Color lightGray
				onAthens: aCanvas.				
			grad := grad - delta].		
		"y-label in [0 ; +inf["
		grad := delta.
		delta to: (worldBound corner y roundTo: delta) by: delta do: [:y |
			aCanvas morphicDrawString: (self labelForAxes: grad)
				at: origin x @ (self worldOrdinateToMorph: y) + (1@1)
				font: DrGDefault canvasFont 
				color: Color lightGray.
			self line: origin x @ (self worldOrdinateToMorph: y) - (2@0)
				to:  origin x @ (self worldOrdinateToMorph: y) + (2@0)
				width: 1
				color: Color lightGray
				onAthens: aCanvas.				
			grad := grad + delta].
		"y-label in ]-inf ; 0["
		grad := delta negated.
		grad to: (worldBound origin y roundTo: delta) by: delta negated do: [:y |
			aCanvas 
				morphicDrawString: (self labelForAxes: grad)
				at: origin x @ (self worldOrdinateToMorph: y) + (1@1)
				font: DrGDefault canvasFont 
				color: Color lightGray.
			self line: origin x @ (self worldOrdinateToMorph: y) - (2@0)
				to:  origin x @ (self worldOrdinateToMorph: y) + (2@0)
				width: 1
				color: Color lightGray
				onAthens: aCanvas.				
			grad := grad - delta]].
]

{ #category : #'drawing axes & grid' }
DrGDrawable >> drawGridOn: aCanvas [
	| worldBound start end morphCoordinate|
	worldBound := self worldBound.
	"horizontal lines"
	start := self left.
	end := self right.
	(worldBound origin y roundTo: delta) to: (worldBound corner y roundTo: delta) by: delta do: [:y |
		morphCoordinate := self worldOrdinateToMorph: y. 
		aCanvas 
			line: start @ morphCoordinate 
			to: end @ morphCoordinate 
			color: Color lightGray].
	"vertical lines"
	start := self bottom.
	end := self top.
	(worldBound origin x roundTo: delta) to: (worldBound corner x roundTo: delta) by: delta do: [:x |
		morphCoordinate := self worldAbscissaToMorph: x.
		aCanvas 
			line: morphCoordinate @ start
			to: morphCoordinate @ end
			color: Color lightGray]
]

{ #category : #'drawing axes & grid' }
DrGDrawable >> drawGridOnAthens: aCanvas [
	| worldBound start end morphCoordinate|
	worldBound := self worldBound.
	"horizontal lines"
	start := self left.
	end := self right.
	(worldBound origin y roundTo: delta) to: (worldBound corner y roundTo: delta) by: delta do: [:y |
		morphCoordinate := self worldOrdinateToMorph: y. 
		self line: start @ morphCoordinate 
			to: end @ morphCoordinate
			width: 0.5
			color: Color lightGray
			onAthens: aCanvas].
	"vertical lines"
	start := self bottom.
	end := self top.
	(worldBound origin x roundTo: delta) to: (worldBound corner x roundTo: delta) by: delta do: [:x |
		morphCoordinate := self worldAbscissaToMorph: x.
		self line: morphCoordinate @ start
			to: morphCoordinate @ end
			width: 0.5
			color: Color lightGray
			onAthens: aCanvas]
]

{ #category : #drawing }
DrGDrawable >> drawOn: aCanvas [ 
	"Dirty PasteUpMorph>>drawOn: need to be refactored"
	aCanvas fillRectangle: self bounds fillStyle: self fillStyle borderStyle: self borderStyle.
	
	"draw grid"
	self gridVisible
		ifTrue: 
			[self drawGridOn: aCanvas.
			self drawAxesOn: aCanvas].
]

{ #category : #drawing }
DrGDrawable >> drawOnAthensCanvas: aCanvas [ 
	super drawOnAthensCanvas: aCanvas .
	self gridVisible ifTrue: [self drawGridOnAthens: aCanvas].
	self axesVisible ifTrue: [ self drawAxesOnAthens: aCanvas].
]

{ #category : #geometry }
DrGDrawable >> extent: aPoint [ 
	super extent: aPoint.
	app redrawCostumes.
	" XXX we should not need it as I will turn DrGService as a Morph and wheel widgets will be pluggued with laout
	app isService ifTrue: 
	[app horizontalWheel right: self right - app view wheelWidth;
		 bottom: self bottom.
	app verticalWheel right: self right;
		 bottom: self bottom - app view wheelWidth.
	app zoomWheel right: self right;
		 top: self top]"
]

{ #category : #genie-command }
DrGDrawable >> getCircleCenter: CRGesture [
|center|
	center := app pointCostumeClosestTo: CRGesture bounds center atRange: 15.
	center 
		ifNotNil: [center := center mathItem]
		ifNil: 
			[center := DrGPointFreeItem newWith: {(self morphToWorld: CRGesture bounds center)}.
			app domain createFromMathItem: center].
	^center
]

{ #category : #genie-command }
DrGDrawable >> getCirclePoint: aCRGesture [
|closestCostume smallestDistance capturedPoints pointItem|
	smallestDistance := 15.
	capturedPoints := aCRGesture capturedPointsInScreenCoord.
	app pointCostumes do: [:aCostume |
		capturedPoints do: [:aPoint | |dist|
			(dist := aCostume distanceTo: aPoint) < smallestDistance 
				ifTrue:
					[closestCostume :=  aCostume.
					smallestDistance := dist]]].
	closestCostume 
		ifNotNil: [pointItem := closestCostume mathItem]
		ifNil:
			[pointItem := DrGPointFreeItem newWith: 
				{(self morphToWorld: aCRGesture coordinates start)}.
			app domain createFromMathItem: pointItem].
	^pointItem
]

{ #category : #gridding }
DrGDrawable >> gridPoint: ungriddedPoint [
	self presenter isGridded ifFalse: [^ungriddedPoint].
	"do it the easy way"
	^self worldToMorph: ((self morphToWorld: ungriddedPoint) roundTo: delta)
]

{ #category : #gridding }
DrGDrawable >> gridWorldPoint: ungriddedPoint [
	self presenter isGridded ifFalse: [^ self morphToWorld: ungriddedPoint].
	"do it the easy way"
	^(self morphToWorld: ungriddedPoint) roundTo: delta
]

{ #category : #'event handling' }
DrGDrawable >> handleMouseMove: anEvent [
	
	"System level event handling."
	anEvent wasHandled ifTrue:[^self]. "not interested"
	"Our drawable gets #mouseMove iff
		* the hand is not dragging anything,
			+ and the receiver is the current mouse focus."
	(anEvent hand hasSubmorphs) ifTrue:[^self].
	self mouseMove: anEvent.

]

{ #category : #'event handling' }
DrGDrawable >> handlesMouseOver: evt [
	^ true
]

{ #category : #'event handling' }
DrGDrawable >> handlesMouseStillDown: evt [
	^ self app isToolbarless not
]

{ #category : #'event handling' }
DrGDrawable >> handlesMouseWheel: evt [
	^ true
]

{ #category : #'balloon target' }
DrGDrawable >> hideTip [
	balloonTarget deleteBalloon.
	self removeMorph: balloonTarget.
]

{ #category : #initialize-release }
DrGDrawable >> initialize [
	super initialize.
	self windowEventHandler: self.
	self color: Color white.
	self borderWidth: 0.
	tipOn := true.
	self defaultScalePosition.
	self hResizing: #spacefill;
		 vResizing: #spaceFill.
	self clipSubmorphs: true.
	balloonTarget := BorderedMorph new color: Color transparent;
				 extent: 6 @ 6;
				 borderWidth: 0.
	underMouse := UnderMouseMorph new extent: DrGDefault replicateDisplayWidth asPoint.
	self addMorphBack: underMouse.
	underMouse 
		position: self position;
		hide.	
	
]

{ #category : #'drawing axes & grid' }
DrGDrawable >> labelForAxes: number [
	delta isFloat 
		ifTrue: [|integer|
			integer := number asInteger.
			integer = number ifTrue: [^ integer printString]].
		^ (number isInteger not and: [number isFraction]) 
			ifTrue: [number printString allButFirst allButLast]
			ifFalse: [ number printString]
]

{ #category : #accessing }
DrGDrawable >> labels [
	^ submorphs select: [:aMorph| aMorph class == DrGLabelMorph].
		
]

{ #category : #genie-command }
DrGDrawable >> left: aNumber [ 
	ox := ox + (self pixelToWorld: aNumber).
	app redrawCostumes

]

{ #category : #drawing }
DrGDrawable >> line: a to: b width: width color:  lineColor onAthens: aCanvas [
	| path |
	path := aCanvas createPath: [:builder|
		builder absolute;
			moveTo: a;
			lineTo: b].
	aCanvas setShape: path.
	(aCanvas setStrokePaint: lineColor) width: width.
	aCanvas draw.
]

{ #category : #geometry }
DrGDrawable >> morphAbscissaToWorld: abscissa [
	"Transform abscissa from DrGeo-Morph to World  system"
	^ ox + ((abscissa - self position x - (self extent x asFloat / 2)) / scale)

]

{ #category : #geometry }
DrGDrawable >> morphOrdinateToWorld: ordinate [
	"Transform point coordinate from DrGeo-Morph to World  system"
	^ oy - ((ordinate  - self position y - (self extent y asFloat / 2)) / scale)
]

{ #category : #geometry }
DrGDrawable >> morphToVector: aPoint [
"Transform vector coordinates in the morph system to the DrGeo system"
	^ Point 
		x: aPoint x asFloat / scale
		y: aPoint y negated asFloat / scale.

]

{ #category : #geometry }
DrGDrawable >> morphToWorld: aPoint [
	"Transform point coordinate from DrGeo-Morph to World  system"
	^ Point 
		x: (self morphAbscissaToWorld: aPoint x)
		y: (self morphOrdinateToWorld: aPoint y)
]

{ #category : #accessing }
DrGDrawable >> mostBehindLabel [
^ submorphs reverse detect: [:aMorph| aMorph class == DrGLabelMorph] ifNone: [nil].
		
]

{ #category : #'event handling' }
DrGDrawable >> mouseDown: evt [ 
	evt yellowButtonPressed ifTrue: [^self]. "we don't capture it"
	evt shiftPressed 
		ifTrue: [self tool handlePressShiftKey: evt cursorPoint]
		ifFalse: 
			[(self tool handlePress: evt cursorPoint)
				ifFalse: [self view popupMenu]].
	self showUnderMouseMorph
]

{ #category : #'event handling' }
DrGDrawable >> mouseLeave: evt [
	self currentHand showTemporaryCursor: Cursor normal.
	^ super mouseLeave: evt
]

{ #category : #'event handling' }
DrGDrawable >> mouseMove: evt [
	DrGDefault ifNotTablet: [evt yellowButtonPressed ifTrue: [self mouseMoveOxy: evt]].
	evt shiftPressed 
		ifTrue: [self tool handleShiftKeyMouseAt: evt cursorPoint]
		ifFalse: [self tool handleMouseAt: evt cursorPoint].		
	self updateUnderMouseMorphPosition.
	lastMoveEvent := evt.

]

{ #category : #'event handling' }
DrGDrawable >> mouseMoveOxy: evt [
"move the whole sketch in the Oxy plane"
	|delta| 
	delta := evt endPoint - evt startPoint.
	delta r  < 100 ifTrue: "we need to check because in tablet mode, previous mouse position can far away"
		[self moveOxy: (self pixelVectorToWorldVector: delta)]
]

{ #category : #'event handling' }
DrGDrawable >> mouseStillDown: evt [
	(self handlesMouseStillDown: evt) ifTrue: 
		[self tool handleStillPress: evt cursorPoint]
]

{ #category : #'event handling' }
DrGDrawable >> mouseStillDownThreshold [ 
	^ 1500
]

{ #category : #'event handling' }
DrGDrawable >> mouseUp: evt [
	evt shiftPressed 
		ifTrue: [self tool handleReleaseShiftKey: evt cursorPoint]
		ifFalse: [self tool handleRelease: evt cursorPoint].
	underMouse hide.
	(self bounds containsPoint: evt cursorPoint) 
		ifFalse: [self currentHand showTemporaryCursor: Cursor normal]

]

{ #category : #'event handling' }
DrGDrawable >> mouseWheel: evt [
	|increment orginalWorldCursorPoint |
	orginalWorldCursorPoint := self morphToWorld: evt cursorPoint.
	evt shiftPressed 
		ifTrue: [increment := 6]
		ifFalse: [increment := 2].
	evt direction == #up ifTrue: [self scaleNoRedraw:  increment ].
	evt direction == #down ifTrue: [self scaleNoRedraw: increment negated].
	"cursor point is at a constant world position"
	self moveOxy: ((self morphToWorld: evt cursorPoint) - orginalWorldCursorPoint)
]

{ #category : #'callback canvas' }
DrGDrawable >> moveOx: increment [
	ox := ox - increment.
	app redrawCostumes
]

{ #category : #'callback canvas' }
DrGDrawable >> moveOxy: pointIncrement [
	ox := ox - pointIncrement x.
	oy := oy - pointIncrement y.
	app redrawCostumes
]

{ #category : #'callback canvas' }
DrGDrawable >> moveOy: increment [
	oy := oy + increment.
	app redrawCostumes
]

{ #category : #accessing }
DrGDrawable >> ox [
	^ ox
]

{ #category : #accessing }
DrGDrawable >> ox: integer [
	ox := integer asNumber
]

{ #category : #accessing }
DrGDrawable >> oy [
	^ oy
]

{ #category : #accessing }
DrGDrawable >> oy: integer [
	oy := integer asNumber
]

{ #category : #geometry }
DrGDrawable >> pixelToWorld: pixels [
"Transform morph pixel unit to Dr. Geo world unit"
	^ pixels asFloat / scale


]

{ #category : #geometry }
DrGDrawable >> pixelVectorToWorldVector: pixelVector [
"Transform morph pixel unit to Dr. Geo world unit"
	^ (pixelVector asFloatPoint / scale) * (1 @ -1)

]

{ #category : #accessing }
DrGDrawable >> presenter [
	^app presenter
]

{ #category : #genie-command }
DrGDrawable >> redo [
	self presenter redo

]

{ #category : #initialize-release }
DrGDrawable >> release [
	balloonTarget dismissMorph.
	self submorphsDo: [:m | 
		self removeMorph: m.
		m dismissMorph].
	super release.
	app := nil
]

{ #category : #drawing }
DrGDrawable >> removeDottedLinesToParents [
	valueItem ifNil: [^self].
	dottedLines do: [:line | self removeMorph: line].
	dottedLines := nil.
	valueItem := nil
]

{ #category : #dropping/grabbing }
DrGDrawable >> resizeImage: aForm [
"Reszie the image to a maximum pixel number"
	| resizedForm maxPixels size ratio |
	maxPixels := 250000.
	size := aForm extent x * aForm extent y.
	size > maxPixels 
		ifTrue: [ratio := (maxPixels  / size) sqrt.
			resizedForm := aForm magnifyBy: ratio]
		ifFalse: [resizedForm  := aForm].
	^ resizedForm 
]

{ #category : #'event handling' }
DrGDrawable >> restartMouseStillDownHandle [
"We reset the timer"
	lastMoveEvent ifNotNil: [	
		self startStepping: #handleMouseStillDown: 
		at: Time millisecondClockValue + self mouseStillDownThreshold
		arguments: {lastMoveEvent copy resetHandlerFields}
		stepTime: self mouseStillDownStepRate]
]

{ #category : #genie-command }
DrGDrawable >> right: aNumber [ 
	ox := ox - (self pixelToWorld: aNumber).
	app redrawCostumes
]

{ #category : #accessing }
DrGDrawable >> scale [
	^ scale
]

{ #category : #accessing }
DrGDrawable >> scale: increment [
	self scaleNoRedraw: increment.
	app redrawCostumes.
]

{ #category : #accessing }
DrGDrawable >> scaleNoRedraw: increment [
	scale := (scale + increment) .
	scale < 1 ifTrue: [scale := 1.0].
	scale > 1000 ifTrue: [scale := 1000.0].

]

{ #category : #genie-command }
DrGDrawable >> segment: aCRGesture [
	Transcript show: 'segment'; cr.
]

{ #category : #accessing }
DrGDrawable >> setScaleTo: number [
	scale := number asNumber
]

{ #category : #'under mouse' }
DrGDrawable >> showUnderMouseMorph [
	DrGDefault ifTablet: [
		self updateUnderMouseMorphPosition.
		underMouse 
			comeToFront;
			show].
]

{ #category : #stepping }
DrGDrawable >> step [
	self tool animate
]

{ #category : #stepping }
DrGDrawable >> stepTime [ 
	^ 300
]

{ #category : #accessing }
DrGDrawable >> surface [
	^ self owner athensSurface
]

{ #category : #'balloon target' }
DrGDrawable >> tip: aText at: aPoint [
	tipOn ifFalse: [^self].
	self addMorphBack: balloonTarget.
	DrGDefault isTablet
		ifTrue: [balloonTarget center: aPoint + (40 @ -40)]
		ifFalse: [balloonTarget center: aPoint].
	balloonTarget setBalloonText: aText.
	balloonTarget showBalloon: (balloonTarget balloonText)
]

{ #category : #'balloon target' }
DrGDrawable >> toggleTip [
	tipOn := tipOn not
]

{ #category : #accessing }
DrGDrawable >> tool [
	^self presenter tool
]

{ #category : #genie-command }
DrGDrawable >> undo [
	self presenter undo

]

{ #category : #genie-command }
DrGDrawable >> unzoom: extent [
	scale := scale - ((extent x + extent y) / 5).
	scale < 5 ifTrue: [scale := 5].
	app redrawCostumes
]

{ #category : #genie-command }
DrGDrawable >> up: aNumber [
	oy := oy - (self pixelToWorld: aNumber).
	app redrawCostumes
]

{ #category : #drawing }
DrGDrawable >> updateDottedLinesToParents [
	| point pointWorld |
	valueItem ifNil: [^self].
	point := (self app costumeOf: valueItem) morph center.
	pointWorld := self morphToWorld: point.
	dottedLines with: valueItem parents do: [:line :parent|
		line setVertices: (
			Array 
				with: point 
				with: (self worldToMorph: (parent closestPointTo: pointWorld)))]
]

{ #category : #gridding }
DrGDrawable >> updateGrid [
	self axesVisible 
		ifTrue: [ self updateGridScaleForAxes]
		ifFalse: [ self updateGridScaleForGrid]
]

{ #category : #gridding }
DrGDrawable >> updateGridScaleForAxes [
	delta := 50 / scale.
	delta >= 1 
		ifTrue: [
			delta := delta roundTo: 0.5.
			delta asInteger = delta ifTrue: [delta := delta asInteger]] 
		ifFalse: [
			delta := 1 / ((1 / delta) rounded)]
]

{ #category : #gridding }
DrGDrawable >> updateGridScaleForGrid [
	delta := 5
]

{ #category : #'under mouse' }
DrGDrawable >> updateUnderMouseMorph [
	DrGDefault ifTablet: [underMouse changed]
]

{ #category : #'under mouse' }
DrGDrawable >> updateUnderMouseMorphPosition [
	DrGDefault ifTablet: 
		[ActiveHand position x - self position x > (self width // 2 )
			ifTrue: [underMouse position: self position] 
			ifFalse: [underMouse position: (self right - underMouse width) @ self position y]]
]

{ #category : #geometry }
DrGDrawable >> vectorToMorph: aVector [
"Transform vector coordinates in the Dr. Geo system to the morph system"
	^ Point 
		x: aVector x asFloat * scale
		y: aVector y negated asFloat * scale.

]

{ #category : #accessing }
DrGDrawable >> view [
	^app view
]

{ #category : #dropping/grabbing }
DrGDrawable >> wantsDroppedMorph:  aMorph event:  evt [
	^ (super wantsDroppedMorph: aMorph  event: evt) "and: [aMorph class == ImageMorph]"
]

{ #category : #'event handling' }
DrGDrawable >> wantsHalo [
	^false
]

{ #category : #stepping }
DrGDrawable >> wantsSteps [
	^ (self presenter isTool: #animate) and: [self tool isAnimating]
]

{ #category : #'event handling' }
DrGDrawable >> windowEvent: anEvent [
	anEvent type == #windowClose
		ifTrue: [ DrGeo quit]
]

{ #category : #geometry }
DrGDrawable >> worldAbscissaToMorph: x [
	"Transform point abscissa from DrGeo-World to Morph system"
	^self extent x / 2 + (scale * (x - ox)) + self position x 
]

{ #category : #geometry }
DrGDrawable >> worldBound [
	^ Rectangle
		origin: (self morphToWorld: self bottomLeft)
		corner: (self morphToWorld: self topRight)
]

{ #category : #geometry }
DrGDrawable >> worldOrdinateToMorph: y [
	"Transform point ordinate from DrGeo-World to Morph system"
	^self extent y / 2 + (scale * (oy - y)) + self position y 
]

{ #category : #geometry }
DrGDrawable >> worldToMorph: aPoint [
	"Transform point coordinate from DrGeo-World to Morph system"
	^ (self worldAbscissaToMorph: aPoint x) @ (self worldOrdinateToMorph: aPoint y)
]

{ #category : #geometry }
DrGDrawable >> worldToPixel: aFloat [
"Transform Dr. Geo world unit to morph unit"
	^ aFloat * scale


]

{ #category : #'callback canvas' }
DrGDrawable >> zoom: extent [
	scale := (scale + (extent x + extent y / 5)) asInteger.
	scale > 200 ifTrue: [scale := 200].
	app redrawCostumes 
]
