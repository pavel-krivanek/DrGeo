"
A canvas to construct programmatically interactive figure
"
Class {
	#name : #DrGeoCanvas,
	#superclass : #Object,
	#instVars : [
		'drgeo'
	],
	#category : #DrGeoII-Core-Script
}

{ #category : #'as yet unclassified' }
DrGeoCanvas class >> viewLess [
	^ self basicNew initializeViewLess
]

{ #category : #value }
DrGeoCanvas >> aPosition [
	^ 10 atRandom - 5 @ (10 atRandom - 5)
]

{ #category : #value }
DrGeoCanvas >> abscissaOf: wrpPointOrWrpVectorOrPoint [
	| class wrapped|
	self preProcessing.
	wrapped := self wrappedPoint: wrpPointOrWrpVectorOrPoint.
	wrapped mathItem isPointItem
		ifTrue: [class := DrGValuePtabscissaItem].
	wrapped mathItem isVectorItem
		ifTrue: [class := DrGValueVectorabscissaItem].
	^ self
		finalizeValue: (class newWith: {wrapped mathItem. self aPosition})
]

{ #category : #point }
DrGeoCanvas >> altIntersectionOf: wrpCurve1 and: wrpCurve2 [ 
"use this one when you want the intersection point when non straight line are involved"
	| item |
	self preProcessing.
	item := DrGPointIntersectionItem newWith: {wrpCurve1 mathItem. wrpCurve2 mathItem. 0 @ 0}.
	item k: 1.
	^ self finalizePoint: item
]

{ #category : #value }
DrGeoCanvas >> angle: wrpVect1 to: wrpVect2 [
	self preProcessing.
	^ self
		finalizeValue: (DrGAngleVectorsItem newWith: {
			(self wrappedVector: wrpVect1) mathItem. 
			(self wrappedVector: wrpVect2) mathItem.
			self aPosition})
		hide: false
]

{ #category : #value }
DrGeoCanvas >> angle: wrpPt1 to: wrpPt2 to: wrpPt3 [ 
	self preProcessing.
	^ self
		finalizeValue: (DrGAngle3ptsItem newWith: {
			(self wrappedPoint: wrpPt1) mathItem. 
			(self wrappedPoint: wrpPt2) mathItem. 
			(self wrappedPoint: wrpPt3) mathItem.
			self aPosition})
		hide: false
]

{ #category : #curve }
DrGeoCanvas >> angleBisector: wrpAngle [
	self preProcessing.
	^ self finalizeCurve: 
		(DrGLineAngleBisectorItem newWith: {wrpAngle mathItem})
]

{ #category : #curve }
DrGeoCanvas >> angleBisectorSummit: wrpSummit side1: wrpPt1 side2: wrpPt2 [
	self preProcessing.
	^ self finalizeCurve: 
		(DrGAngleBisector3ptsItem newWith: 
			{(self wrappedPoint: wrpPt1) mathItem.
			(self wrappedPoint: wrpSummit) mathItem.
			(self wrappedPoint: wrpPt2) mathItem})
]

{ #category : #'curve finit' }
DrGeoCanvas >> arc: wrpPt1 to: wrpPt2 to: wrpPt3 [
	self preProcessing.
	^ self
		finalizeFinitCurve: (DrGArc3ptsItem newWith: 
			{(self wrappedPoint: wrpPt1) mathItem. 
			(self wrappedPoint: wrpPt2) mathItem. 
			(self wrappedPoint: wrpPt3) mathItem})
]

{ #category : #'curve finit' }
DrGeoCanvas >> arcCenter: wrpPt1 from: wrpPt2 to: wrpPt3 [
	self preProcessing.
	^ self
		finalizeFinitCurve: (DrGArcCenterAngleItem newWith: 
			{(self wrappedPoint: wrpPt1) mathItem. 
			(self wrappedPoint: wrpPt2) mathItem. 
			(self wrappedPoint: wrpPt3) mathItem})
]

{ #category : #'user interface' }
DrGeoCanvas >> axesOn [
	 drgeo presenter axesOnOff 
]

{ #category : #transformations }
DrGeoCanvas >> canTransform: wrptItem [
	wrptItem mathItem isGeometricItem
		ifFalse: [self error: 'Only geometric object can be transformed.' translated].
]

{ #category : #'user interface' }
DrGeoCanvas >> centerTo: aPoint [
	"set the center of the visible canvas to this coordinate"
	drgeo area 
		ox: aPoint x;
		oy: aPoint y.
	drgeo redrawCostumes 
]

{ #category : #'curve filled' }
DrGeoCanvas >> circleCenter: wrpCenter radius: wrpValue [
	self preProcessing.
	^ self
		finalizeFilledCurve: (DrGCircleRadiusItem  newWith: {
			(self wrappedPoint: wrpCenter) mathItem. 
			(self wrappedValue: wrpValue) mathItem})
]

{ #category : #'curve filled' }
DrGeoCanvas >> circleCenter: wrpCenter segment: wrpSegment [
	self preProcessing.
	^ self
		finalizeFilledCurve: (DrGCircleSegmentItem  newWith: {
			(self wrappedPoint: wrpCenter) mathItem. 
			wrpSegment mathItem})
]

{ #category : #'curve filled' }
DrGeoCanvas >> circleCenter: wrpCenter to: wrpPt [
	self preProcessing.
	^ self
		finalizeFilledCurve: (DrGCircle2ptsItem newWith: {
			(self wrappedPoint: wrpCenter) mathItem. 
			(self wrappedPoint: wrpPt) mathItem})
]

{ #category : #accessing }
DrGeoCanvas >> costumeOf: anItem [ 
	^ drgeo costumeOf: anItem

]

{ #category : #value }
DrGeoCanvas >> distance: item1 to: item2 [ 
	"Distance from a point to a line or another point"
	| arg class wrpItem1 wrpItem2 |
	"Try to wrap to point in case the user provided point coordinates"
	wrpItem1 := self wrappedPoint: item1.
	wrpItem2 := self wrappedPoint: item2.
	arg := OrderedCollection newFrom: {wrpItem1 mathItem. wrpItem2 mathItem}.
	(arg first isLineItem or: [arg second isLineItem])
		ifTrue: [class := DrGValueDistanceptlineItem.
			arg first isLineItem ifTrue: [arg := arg reverse]]
		ifFalse: [class := DrGValueDistance2ptsItem].
	arg addLast: self aPosition.
	self preProcessing.
	^ self
		finalizeValue: (class newWith: arg)
]

{ #category : #helpers }
DrGeoCanvas >> do: aBlock [
	"Execute the given construction in a forked process so the user can see the on going construction or animation"
	[aBlock value] forkAt: Processor userBackgroundPriority  
]

{ #category : #accessing }
DrGeoCanvas >> domain [
	^ drgeo domain
]

{ #category : #equation }
DrGeoCanvas >> equationOf: wrpLineOrCircle [
	| class |
	self preProcessing.
	wrpLineOrCircle mathItem isLineItem 
		ifTrue: [class := DrGEquationLineItem ].
	wrpLineOrCircle mathItem isCircleItem
		ifTrue: [class := DrGEquationCircleItem].
	^ self
		finalizeValue: (class newWith: {wrpLineOrCircle mathItem. self aPosition})
]

{ #category : #curve }
DrGeoCanvas >> finalizeCurve: item [
	^ self postProcessing: (DrGWrappedCurve wrap: (self costumeOf: (self domain createFromMathItemNoStack: item)))
]

{ #category : #'curve filled' }
DrGeoCanvas >> finalizeFilledCurve: item [
	^ self postProcessing: (DrGWrappedFilledCurve wrap: (self costumeOf: (self domain createFromMathItemNoStack: item)))
]

{ #category : #'curve finit' }
DrGeoCanvas >> finalizeFinitCurve: item [
	^ self postProcessing: (DrGWrappedFinitCurve wrap: (self costumeOf: (self domain createFromMathItemNoStack: item)))
]

{ #category : #point }
DrGeoCanvas >> finalizePoint: item [
	^ self postProcessing: (DrGWrappedPoint wrap: (self costumeOf: (self domain createFromMathItemNoStack: item)))
]

{ #category : #'curve finit' }
DrGeoCanvas >> finalizeSegment: item [
	^ self postProcessing: (DrGWrappedSegment wrap: (self costumeOf: (self domain createFromMathItemNoStack: item)))
]

{ #category : #text }
DrGeoCanvas >> finalizeText: item [
	^ self postProcessing: (DrGWrappedText wrap: (self costumeOf: (self domain createFromMathItemNoStack: item)))
]

{ #category : #transformations }
DrGeoCanvas >> finalizeTransformation: string with: arguments [ 
	| class item |
	class := self class environment classNamed: 'DrG', arguments first basicType capitalized, string, 'Item'.
	item := class newWith: arguments.
	item isPointItem
		ifTrue: [^ self finalizePoint: item].
	^ self finalizeCurve: item
]

{ #category : #value }
DrGeoCanvas >> finalizeValue: item [
"By default we hide the value"
	^ self finalizeValue: item hide: true
]

{ #category : #'as yet unclassified' }
DrGeoCanvas >> finalizeValue: item hide: hide [
"By default we hide the value"
	| wrappedItem |
	wrappedItem := DrGWrappedValue wrap: (self costumeOf: (self domain createFromMathItemNoStack: item)).
	self postProcessing: wrappedItem.
	 hide ifTrue: [ wrappedItem hide ].
	^ wrappedItem
]

{ #category : #helpers }
DrGeoCanvas >> float: value at: aPoint from: startValue to: endValue [ 
	^ self float: value at: aPoint from: startValue to: endValue name: ''
]

{ #category : #helpers }
DrGeoCanvas >> float: aValue at: aPoint from: startValue to: endValue name: name [
"A valueslider ranging between startValue and endValue"
	^ self float: aValue at: aPoint from: startValue to: endValue name: name showValue: false
]

{ #category : #helpers }
DrGeoCanvas >> float: aValue at: aPoint from: startValue to: endValue name: name showValue: isValueDisplay [
"A valueslider ranging between startValue and endValue"
	| segment mobile|
	segment := self segment: aPoint to: aPoint + (170 / drgeo area scale @0).
	mobile := self pointOnCurve:  segment at: (aValue - startValue) / (endValue - startValue).
	segment color: Color black; large.
	mobile name: name;
		color: Color black;
		round;
		large.	
	^ isValueDisplay 
		ifTrue:  [[|value |
			value := mobile mathItem abscissa * ( endValue - startValue) + startValue.
			mobile rename: name,  ' = ', (value printShowingDecimalPlaces: 2).
			value]]
		ifFalse: [[mobile mathItem abscissa * ( endValue - startValue) + startValue]]  	
	
]

{ #category : #value }
DrGeoCanvas >> freeValue: aNumber [ 
	^ self freeValue: aNumber at: self aPosition
]

{ #category : #value }
DrGeoCanvas >> freeValue: aNumber at: aPosition [
	| answer |
	self preProcessing.
	drgeo notInteractive: true.
	answer := self finalizeValue: ((DrGValueValueItem newWith: {aPosition}) valueItem: aNumber).
	drgeo notInteractive: false.
	^ answer
]

{ #category : #'user interface' }
DrGeoCanvas >> fullscreen [
	drgeo view fullscreen
]

{ #category : #'user interface' }
DrGeoCanvas >> gridOn [
	 drgeo presenter gridOnOff 
]

{ #category : #initialize-release }
DrGeoCanvas >> initialize [
	super initialize.
	drgeo := DrGeo applicationToolbarless.
	drgeo view openInWorld.
	drgeo view extent: 400@300.
]

{ #category : #initialize-release }
DrGeoCanvas >> initializeViewLess [
	super initialize.
	drgeo := DrGeo service.

]

{ #category : #helpers }
DrGeoCanvas >> integer: value at: aPoint from: startValue to: endValue [ 
	^ self integer: value at: aPoint from: startValue to: endValue name: ''
]

{ #category : #helpers }
DrGeoCanvas >> integer: aValue at: aPoint from: startValue to: endValue name: name [
"A valueslider ranging between startValue and endValue"
	^ self integer: aValue at: aPoint from: startValue to: endValue name: name showValue: false
]

{ #category : #helpers }
DrGeoCanvas >> integer: aValue at: aPoint from: startValue to: endValue name: name showValue: isValueDisplay [
"A valueslider ranging between startValue and endValue"
	| segment mobile|
	segment := self segment: aPoint to: aPoint + (170 / drgeo area scale @0).
	mobile := self pointOnCurve:  segment at: (aValue - startValue) / (endValue - startValue).
	segment color: Color black; large.
	mobile name: name;
		color: Color black;
		round;
		large.	
	^ isValueDisplay 
		ifTrue:  [[|value |
			value := (mobile mathItem abscissa * ( endValue - startValue) + startValue) floor.
			mobile rename: name,  ' = ', value printString.
			value]]
		ifFalse: [[(mobile mathItem abscissa * ( endValue - startValue) + startValue) floor]]  	
	
]

{ #category : #point }
DrGeoCanvas >> intersectionOf: wrpCurve1 and: wrpCurve2 [ 
|item|
	self preProcessing.
	item := DrGPointIntersectionItem newWith: {wrpCurve1 mathItem. wrpCurve2 mathItem. 0 @ 0}.
	item k: -1.
	^ self
		finalizePoint: (item)
]

{ #category : #value }
DrGeoCanvas >> lengthOf: wrpSegmentOrCircleOrArcOrVectorOrPolygon [
	| class |
	self preProcessing.
	wrpSegmentOrCircleOrArcOrVectorOrPolygon mathItem isSegmentItem
		ifTrue: [class := DrGValueSegmentlengthItem].
	wrpSegmentOrCircleOrArcOrVectorOrPolygon mathItem isCircleItem
		ifTrue: [class := DrGValueCircleperimeterItem].
	wrpSegmentOrCircleOrArcOrVectorOrPolygon mathItem isArcItem
		ifTrue: [class := DrGValueArclengthItem].
	wrpSegmentOrCircleOrArcOrVectorOrPolygon mathItem isVectorItem
		ifTrue: [class := DrGValueVectornormItem].
	wrpSegmentOrCircleOrArcOrVectorOrPolygon mathItem isVectorItem
		ifTrue: [class := DrGValuePolygonperimeterItem].

	^ self
		finalizeValue: (class newWith: {wrpSegmentOrCircleOrArcOrVectorOrPolygon mathItem. self aPosition})
]

{ #category : #curve }
DrGeoCanvas >> line: wrpPt1 to: wrpPt2 [
	self preProcessing.
	^ self
		finalizeCurve: (DrGLine2ptsItem newWith: {
			(self wrappedPoint: wrpPt1) mathItem. 
			(self wrappedPoint: wrpPt2) mathItem })
]

{ #category : #curve }
DrGeoCanvas >> locusOf: wrpPt1 when: wrpPt2 [ 
	self preProcessing.
	wrpPt2 mathItem isPointItemOnCurve 
		ifFalse: [self error: 'The second point provided in the call must be on a curve.'].
	^ self
		finalizeCurve: (DrGLocus2ptsItem newWith: {wrpPt2 mathItem. wrpPt1 mathItem})
]

{ #category : #point }
DrGeoCanvas >> middleOf: wrpSegment [
	self preProcessing.
	^ self
		finalizePoint: (DrGPointMiddlesegmentItem newWith: {wrpSegment mathItem})
]

{ #category : #point }
DrGeoCanvas >> middleOf: wrappedPoint1 and: wrappedPoint2 [ 
	self preProcessing .
	^ self finalizePoint: (DrGPointMiddle2ptsItem newWith: 
		{(self wrappedPoint: wrappedPoint1) mathItem . (self wrappedPoint: wrappedPoint2) mathItem})
]

{ #category : #value }
DrGeoCanvas >> ordinateOf: wrpPointOrWrpVectorOrPoint [ 
	| class wrapped |
	self preProcessing.
	wrapped := self wrappedPoint: wrpPointOrWrpVectorOrPoint.
	wrapped mathItem isPointItem
		ifTrue: [class := DrGValuePtordinateItem].
	wrapped mathItem isVectorItem
		ifTrue: [class := DrGValueVectorordinateItem].
	^ self
		finalizeValue: (class newWith: {wrapped mathItem. self aPosition})
]

{ #category : #curve }
DrGeoCanvas >> parallel: wrpDirection at: wrpPtOrPoint [
	self preProcessing.
	^ self
		finalizeCurve: (DrGLineParallelItem newWith: {
			wrpDirection mathItem. 
			(self wrappedPoint: wrpPtOrPoint) mathItem})
]

{ #category : #curve }
DrGeoCanvas >> perpendicular: wrpDirection at: wrpPtOrPoint [ 
	self preProcessing.
	^ self
		finalizeCurve: (DrGLinePerpendicularItem newWith: {
			wrpDirection mathItem. 
			(self wrappedPoint: wrpPtOrPoint) mathItem})
]

{ #category : #curve }
DrGeoCanvas >> perpendicularBisector: wrpSegment [
	self preProcessing.
	^ self finalizeCurve: 
		(DrGPerpendicularBisectorItem newWith: {wrpSegment mathItem})
]

{ #category : #curve }
DrGeoCanvas >> perpendicularBisector: wrpPt1 to: wrpPt2 [
	self preProcessing.
	^ self
		finalizeCurve: (DrGLinePerpendicularBisector2ptsItem newWith: {
			(self wrappedPoint: wrpPt1) mathItem. 
			(self wrappedPoint: wrpPt2) mathItem})
]

{ #category : #helpers }
DrGeoCanvas >> plot: f from: x0 to: x1 [
| mobile s pen|
	s := self segment: x0@0 to: x1@0.
	mobile := self pointOnCurve: s at: 0.
	pen := self
		point: [:item | item point x @ (f value: item point x)] 
		parent: mobile.
	^ (self locusOf: pen when: mobile) color: Color blue

]

{ #category : #point }
DrGeoCanvas >> point: aPointOrBlock [
	self preProcessing.
	^ aPointOrBlock isPoint 
		ifTrue:  [self finalizePoint: (DrGPointFreeItem newWith: {aPointOrBlock})]
		ifFalse: [self finalizePoint: (DrGPointBlockItem newWith: (OrderedCollection with: aPointOrBlock)	)]
]

{ #category : #point }
DrGeoCanvas >> point: block parent: wrpValue [
	|collection|
	self preProcessing.
	collection := OrderedCollection with: block.
	collection add: wrpValue mathItem.
	^ self finalizePoint: (DrGPointBlockItem newWith: collection)
]

{ #category : #point }
DrGeoCanvas >> point: block parents: wrpValueArray [
	|collection|
	self preProcessing.
	collection := OrderedCollection with: block.
	collection addAll: (wrpValueArray collect: [:wrp | wrp mathItem]).
	^ self finalizePoint: (DrGPointBlockItem newWith: collection)
]

{ #category : #point }
DrGeoCanvas >> pointOnCurve: wrpCurve at: abscissa [ 
	| item a |
	self preProcessing.
	item := DrGPointOncurveItem newWith: {wrpCurve mathItem. 0 @ 0}.
	a := abscissa.
	abscissa < 0
		ifTrue: [a := 0].
	abscissa > 1
		ifTrue: [a := 1].
	item setCurveAbscissa: a.
	item := self domain createFromMathItemNoStack: item.
	^ self finalizePoint: item
]

{ #category : #point }
DrGeoCanvas >> pointX: wrpValue1 Y: wrpValue2 [
	self preProcessing.
	^ self
		finalizePoint: (DrGPointCoordinateItem  newWith: {wrpValue1 mathItem . wrpValue2 mathItem })
]

{ #category : #'curve filled' }
DrGeoCanvas >> polygon: arguments [
	self preProcessing.
	^ self
		finalizeFilledCurve: (DrGPolygonNptsItem  newWith: (arguments collect: [:wrp | 
				(self wrappedPoint: wrp) mathItem]))
]

{ #category : #processing }
DrGeoCanvas >> postProcessing: aWrappedItem [ 
	"Called after each item creation command, return a wrapped costume "
	^ aWrappedItem 
]

{ #category : #processing }
DrGeoCanvas >> preProcessing [

]

{ #category : #curve }
DrGeoCanvas >> ray: wrpPt1 to: wrpPt2 [
	self preProcessing.
	^ self
		finalizeCurve: (DrGRay2ptsItem newWith: {
			(self wrappedPoint: wrpPt1) mathItem. 
			(self wrappedPoint: wrpPt2) mathItem })
]

{ #category : #transformations }
DrGeoCanvas >> reflect: wrpItem axis: wrpLine [ 
	self canTransform: wrpItem.
	self preProcessing.
	^ self finalizeTransformation: 'Reflexion' with: {wrpItem mathItem. wrpLine mathItem}
]

{ #category : #'curve filled' }
DrGeoCanvas >> regularPolygonCenter: wrpCenter vertex: wrpVertex sides: wrpValue [
	self preProcessing.
	^ self
		finalizeFilledCurve: (DrGPolygonRegularItem newWith: {
			(self wrappedPoint: wrpCenter) mathItem. 
			(self wrappedPoint: wrpVertex) mathItem.
			(self wrappedValue: wrpValue) mathItem})
]

{ #category : #initialize-release }
DrGeoCanvas >> release [
	drgeo release.
]

{ #category : #transformations }
DrGeoCanvas >> rotate: wrpItem center: wrpCenter angle: wrpValue [ 
	self canTransform: wrpItem.
	self preProcessing.
	^ self finalizeTransformation: 'Rotation' with:  {
		wrpItem mathItem. 
		(self wrappedPoint: wrpCenter) mathItem. 
		(self wrappedValue: wrpValue) mathItem}.
	
]

{ #category : #'user interface' }
DrGeoCanvas >> scale: anInteger [
	"set scale of the canvas"
	drgeo area setScaleTo: anInteger.
	drgeo redrawCostumes.
]

{ #category : #transformations }
DrGeoCanvas >> scale: wrpItem center: wrpCenter factor: wrpValue [ 
	self canTransform: wrpItem.
	self preProcessing.
	^ self finalizeTransformation: 'Homothety' with: {
		wrpItem mathItem. 
		(self wrappedPoint: wrpCenter) mathItem.
		(self wrappedValue: wrpValue) mathItem} 

]

{ #category : #'curve finit' }
DrGeoCanvas >> segment: wrpPt1 to: wrpPt2 [
	self preProcessing.
	^ self
		finalizeSegment: (DrGSegment2ptsItem newWith: {
			(self wrappedPoint: wrpPt1) mathItem. 
			(self wrappedPoint: wrpPt2) mathItem})
]

{ #category : #value }
DrGeoCanvas >> slopeOf: wrpLine [
	self preProcessing.
	^ self
		finalizeValue: (DrGValueSlopeItem newWith: {wrpLine mathItem. self aPosition})
]

{ #category : #transformations }
DrGeoCanvas >> symmetry: wrpItem center: wrpCenter [ 
	self canTransform: wrpItem.
	self preProcessing.
	^ self finalizeTransformation: 'Symmetry' with: {
		wrpItem mathItem. 
		(self wrappedPoint: wrpCenter) mathItem}
]

{ #category : #text }
DrGeoCanvas >> text: aText [
	^ self text:aText at: self aPosition
]

{ #category : #text }
DrGeoCanvas >> text: aText at: aPosition [
	| answer |
	self preProcessing.
	drgeo notInteractive: true.
	answer := self finalizeText: ((DrGTextItem newWith: {aPosition}) text: aText asText).
	drgeo notInteractive: false.
	^ answer
]

{ #category : #transformations }
DrGeoCanvas >> translate: wrpItem vector: wrpVector [ 
	self canTransform: wrpItem.
	self preProcessing.
	^ self finalizeTransformation: 'Translation' with: 
		{wrpItem mathItem. 
		(self wrappedVector: wrpVector) mathItem}
]

{ #category : #processing }
DrGeoCanvas >> update [
	self domain updateAllMathItems
]

{ #category : #'curve finit' }
DrGeoCanvas >> vector: wrpPt [
	self preProcessing.
	^ self
		finalizeCurve: (DrGVector2ptsItem newWith: {
			(self wrappedPoint: 0@0) mathItem. 
			(self wrappedPoint: wrpPt) mathItem})
]

{ #category : #'curve finit' }
DrGeoCanvas >> vector: wrpPt1 to: wrpPt2 [ 
	self preProcessing.
	^ self
		finalizeCurve: (DrGVector2ptsItem newWith: {
			(self wrappedPoint: wrpPt1) mathItem. 
			(self wrappedPoint: wrpPt2) mathItem})
]

{ #category : #point }
DrGeoCanvas >> wrappedPoint: aPointOrWrappedPointItem [
"ensure a wrapped point"
	^ aPointOrWrappedPointItem isPoint 
		ifTrue: [(self point: aPointOrWrappedPointItem) hide] 
		ifFalse:   [aPointOrWrappedPointItem]
]

{ #category : #value }
DrGeoCanvas >> wrappedValue: aNumberOrWrappedValueItem [
"ensure a wrapped value"
	^ aNumberOrWrappedValueItem  isNumber 
		ifTrue: [(self freeValue: aNumberOrWrappedValueItem ) hide] 
		ifFalse:   [aNumberOrWrappedValueItem]
]

{ #category : #'curve finit' }
DrGeoCanvas >> wrappedVector: aVectorOrWrappedVectorItem [
"ensure a wrapped vector"
	^ aVectorOrWrappedVectorItem isPoint 
		ifTrue: [(self vector: aVectorOrWrappedVectorItem) hide] 
		ifFalse:   [aVectorOrWrappedVectorItem]
]
