"
when Circle goes infinit replace it by a lineMorph
"
Class {
	#name : #DrGCircleCostume,
	#superclass : #DrGCurveCostume,
	#instVars : [
		'asLine'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #updating }
DrGCircleCostume >> applyStyle [
	morph borderColor: style borderColor;
		dashedBorder: (DrGStylePreference styleFor: style lineStyle);
		borderWidth: style width.
]

{ #category : #testing }
DrGCircleCostume >> basicType [
	^#circle
]

{ #category : #initialize-release }
DrGCircleCostume >> initialize [
	super initialize.
	asLine := false
]

{ #category : #initialize-release }
DrGCircleCostume >> instantiateMorph [
	morph := DrGCircleMorph new
]

{ #category : #testing }
DrGCircleCostume >> isDrawAsLine [
	^ asLine ifNil: [ asLine := false ]
]

{ #category : #updating }
DrGCircleCostume >> redraw [
	super redraw ifFalse: [^ self].
	mathItem radius > 100
		ifTrue: [self redrawAsLine]
		ifFalse: [self redrawAsCircle]
]

{ #category : #updating }
DrGCircleCostume >> redrawAsCircle [
	self isDrawAsLine ifTrue: [
		self removeMyMorph.
		self instantiateMorph.
		morph costume: self.
		self applyStyle.
		drawable addMorph: morph.
		asLine := false].
	morph
		center: (drawable worldToMorph: mathItem center)
		radius: (drawable worldToPixel: mathItem radius)  
]

{ #category : #updating }
DrGCircleCostume >> redrawAsLine [
	| p1 p2 |
	self isDrawAsLine ifFalse: [ 
		asLine := true.
		self removeMyMorph.
		morph := DrGLineMorph new costume: self.
		self applyStyle.
		drawable addMorph: morph].
	p1 := mathItem closestPointTo: (drawable morphToWorld: ActiveHand position).
	p2 := mathItem pointAt: (mathItem abscissaOf: p1) + 0.001.
	morph
		from: (drawable worldToMorph: p1)
		direction: (drawable vectorToMorph: p2 - p1)
]

{ #category : #style }
DrGCircleCostume >> styleClass [
	^DrGCircleCostumeStyle
]
