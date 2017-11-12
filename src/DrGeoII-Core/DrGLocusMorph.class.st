"
- list : a linked list of DrGLocusSample
- minAbscissaDelta : the minimum abscissa delta between two samples
- maxAbscissaDelta : the maximum abscissa delta between two samples
- maxScreenDelta : the maximum delta between two samples in the screen
"
Class {
	#name : #DrGLocusMorph,
	#superclass : #DrGPolylineMorph,
	#instVars : [
		'free',
		'constrained',
		'drawable',
		'factory',
		'minAbscissaDelta',
		'maxScreenDelta',
		'maxAbscissaDelta',
		'freeIndex',
		'constrainedIndex',
		'samples',
		'worldBound'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGLocusMorph >> costume:  aCostume [
	super costume: aCostume.
	drawable := aCostume drawable.
	factory := aCostume domain factory.
]

{ #category : #drawing }
DrGLocusMorph >> drawBorderOn: aCanvas usingEnds: anArray [ 
	"Display my border on the canvas."
	"NOTE: Much of this code is also copied in 
	drawDashedBorderOn: 
	(should be factored)"
	| bigClipRect style |
	borderDashSpec
		ifNotNil: [^ self drawDashedBorderOn: aCanvas usingEnds: anArray].
	style := self borderStyle.
	bigClipRect := aCanvas clipRect expandBy: self borderWidth + 1 // 2.
	self
		lineSegmentsDo: [:p1 :p2 | 
			| p1i p2i |
			p1i := p1 asIntegerPoint.
			p2i := p2 asIntegerPoint.
			self hasArrows
				ifTrue: ["Shorten line ends so as not to interfere with tip 
					of arrow."
					((arrows == #back
								or: ["Shorten line ends so as not to
									interfere with tip 
									of arrow."
									arrows == #both
									"Shorten line ends so as not to
									interfere with tip 
									of arrow."])
							and: [p1 = vertices first])
						ifTrue: [p1i := anArray first asIntegerPoint].
					((arrows == #forward
								or: [arrows == #both])
							and: [p2 = vertices last])
						ifTrue: [p2i := anArray last asIntegerPoint]].
			(closed
					or: ["bigClipRect intersects: (p1i rect: p2i) 
						optimized:"
						((p1i min: p2i)
							max: bigClipRect origin)
							<= ((p1i max: p2i)
									min: bigClipRect corner)
						"bigClipRect intersects: (p1i rect: p2i) 
						optimized:"])
				ifTrue: [(p1i squaredDistanceTo: p2i) < 900 ifTrue:
					[style
						drawLineFrom: p1i
						to: p2i
						on: aCanvas]]]
]

{ #category : #drawing }
DrGLocusMorph >> drawOnAthensCanvas: aCanvas [ 
	| polyPath points prevPoint |
	
	points := self getVertices.
	polyPath := aCanvas createPath: [ :builder | 
		builder 	absolute.
		prevPoint := points first.
		builder moveTo: prevPoint .
		points allButFirstDo: [ :pt | 
			(prevPoint squaredDistanceTo: pt) < 900
				ifTrue: [builder lineTo: pt]
				ifFalse: [ builder moveTo: pt].
			prevPoint := pt ].			
		closed ifTrue: [ builder lineTo: points first ]	].

	aCanvas setShape: polyPath.
	closed	ifTrue: [ aCanvas setPaint: self fillStyle. aCanvas draw. ].
		
	(aCanvas setStrokePaint: self borderStyle color) 
		width: self borderWidth;
		dashes: self dashedBorder offset: 0.
	
	aCanvas draw.

	self drawArrowsOnAthensCanvas: aCanvas
]

{ #category : #accessing }
DrGLocusMorph >> free: freeItem constrained: constrainedItem [ 
	| link0 link1 x0 validSamples|
	x0 := freeItem abscissa.
	worldBound := drawable worldBound.
	free := freeItem.
	constrained := constrainedItem.
	freeIndex := factory indexOf: free.
	constrainedIndex := factory indexOf: constrained.
	samples := LinkedList new.
	link0 := samples add: (self sample: minAbscissaDelta ).
	link1 := samples add: (self sample: 1 - minAbscissaDelta) afterLink: link0.
	self samplingFrom: link0 to: link1.
	validSamples := self selectValidSamples.
	free abscissa: x0.
	factory updateAllMathItemsButLocusFrom: freeIndex to: constrainedIndex.
	validSamples ifEmpty: [
		costume exist: false.
		^self].
	costume mathItem
		points: (validSamples	collect: [:s | s pointWorld]);
		samples: validSamples size.
	costume exist: true.
	vertices := validSamples	collect: [:s | s pointScreen].
	self computeBounds
]

{ #category : #initialization }
DrGLocusMorph >> initialize [
	super initialize.
	minAbscissaDelta := 0.00001.
	maxScreenDelta := 64.
	maxAbscissaDelta := 0.1
]

{ #category : #sampling }
DrGLocusMorph >> sample: abscissa [ 
	| sample |
	sample := DrGLocusSample new x: abscissa.
	free abscissa: abscissa.
	factory updateAllMathItemsButLocusFrom: freeIndex to: constrainedIndex.
	(sample isValid: constrained exist) ifTrue: 
		[sample pointWorld: constrained point;
		pointScreen: (drawable worldToMorph: constrained point);
		offScreen: (worldBound containsPoint: constrained point) not].
	^ sample
]

{ #category : #sampling }
DrGLocusMorph >> samplingFrom: link1 to: link2 [ 
	| sample1 sample2 sample link |
	sample1 := link1 value.
	sample2 := link2 value.
	(sample2 x - sample1 x > minAbscissaDelta
		and: [(sample1 isNotValid or: [sample2 isNotValid]) 
			or: [sample2 x - sample1 x > maxAbscissaDelta
				or: [(sample1 pointScreen squaredDistanceTo: sample2 pointScreen) > maxScreenDelta]]])
		ifTrue: [sample := self sample: sample1 x + sample2 x / 2.
			link := samples add: sample afterLink: link1.
			self samplingFrom: link1 to: link.
			self samplingFrom: link to: link2.
			]
]

{ #category : #sampling }
DrGLocusMorph >> selectValidSamples [
	| validSamples prevLink|
	validSamples := OrderedCollection new.
	samples
		linksDo: [:link | link value isValidAndOnScreen
			ifTrue: [validSamples add: link value]
			ifFalse: ["unvalid or offscreen, in case it is just offscreen check if next/prev sample is on-screen, so we need this sample for the drawing"
				link value isValid ifTrue:
					[link nextLink
					ifNotNil: [link nextLink value isValidAndOnScreen 
						ifTrue: [validSamples add: link value]
						ifFalse: [prevLink ifNotNil: 
							[prevLink value isValidAndOnScreen ifTrue: [validSamples add: link value]]]]]].
				prevLink := link].
	^ validSamples 
]
