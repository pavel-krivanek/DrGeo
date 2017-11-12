"
origin, length, center, vector1 and vector are data to drwa the arc or square for the geometric angle
"
Class {
	#name : #DrGAngle3PointsCostume,
	#superclass : #DrGAngleCostume,
	#instVars : [
		'shapeMorph',
		'origin',
		'length',
		'center',
		'vector1',
		'vector2',
		'screenCenter'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #updating }
DrGAngle3PointsCostume >> forceVisible: aBoolean [
	(super forceVisible: aBoolean) ifFalse: [^false].
	aBoolean 
		ifTrue: 
			[drawable addMorph: shapeMorph]
		ifFalse: 
			[drawable removeMorph: shapeMorph].
	^true
]

{ #category : #initialize-release }
DrGAngle3PointsCostume >> initialize [
	super initialize.
	drawable addMorphBack: shapeMorph
]

{ #category : #initialize-release }
DrGAngle3PointsCostume >> instantiateMorph [
	super instantiateMorph.
	morph font: DrGDefault canvasFont.
	shapeMorph := DrGArcMorph new
		borderColor: Color black; 
		borderWidth: 1.
	shapeMorph costume: self.
]

{ #category : #initialize-release }
DrGAngle3PointsCostume >> reInitialize [
	super reInitialize.
	drawable addMorphBack: shapeMorph
]

{ #category : #updating }
DrGAngle3PointsCostume >> redraw [
	exist  
		ifFalse: [^ self].
	self redrawShape.
	"do it last cause we have some needed computation in redrawShape"
	super redraw.
	morph center: self textPosition.
]

{ #category : #updating }
DrGAngle3PointsCostume >> redrawArc [
	shapeMorph class ~= DrGArcMorph
		ifTrue:
			[drawable removeMorph: shapeMorph.
			shapeMorph := DrGArcMorph new borderColor: Color black; 
				borderWidth: 1. 
			drawable addMorph: shapeMorph].
	shapeMorph 
			center: (drawable worldToMorph: center)
			radius: 15
			origin: origin negated
			length: length negated
]

{ #category : #updating }
DrGAngle3PointsCostume >> redrawRec [
	| vertices sum |
	shapeMorph class = DrGPolylineMorph 
		ifFalse: 
			[drawable removeMorph: shapeMorph.
			shapeMorph := (DrGPolylineMorph new)
						borderColor:  Color black;
						borderWidth: 1.
			drawable addMorph: shapeMorph].
	vertices := OrderedCollection new.
	vector1 := vector1 + screenCenter.
	sum := vector1 + vector2.
	vector2 := vector2 + screenCenter.
	vertices
		add: vector1;
		add: sum;
		add: vector2.
	shapeMorph setVertices: vertices
]

{ #category : #updating }
DrGAngle3PointsCostume >> redrawShape [
	self updateArcData.
	(mathItem radianAngle closeTo: Float halfPi)
		ifTrue:
			[self updateRecData.
			self redrawRec]
		ifFalse:
			[self redrawArc].
]

{ #category : #updating }
DrGAngle3PointsCostume >> redrawValue [
	morph center: self textPosition.
]

{ #category : #initialize-release }
DrGAngle3PointsCostume >> release [
	drawable removeMorph: shapeMorph.
	super release.
]

{ #category : #updating }
DrGAngle3PointsCostume >> textPosition [
|angle|
	angle := length negated / 2 + origin negated.
	^ (drawable worldToMorph: center) 
		+ ((30 * (angle cos)) @ (30 * (angle sin)))
]

{ #category : #updating }
DrGAngle3PointsCostume >> updateArcData [
|end parents |
	parents := mathItem parents.
	center := parents second point.
	vector1 := parents first point - center.
	vector2 := parents third point - center.
	(vector1 = (0@0) or: [vector2 = (0@0)]) 
		ifTrue: [^self].
	origin := vector1 y asFloat arcTan2: vector1 x.
	end := vector2 y asFloat arcTan2: vector2 x.
	origin < 0 ifTrue: [origin := origin + DrGDirectionItem twoPi].
	end < 0 ifTrue: [end := end + DrGDirectionItem twoPi].
	length := (end - origin) cos arcCos.
	(end - origin > Float pi 
		or: [end - origin < 0 and: [end - origin > Float pi negated]])	
			ifTrue: [length := length negated].
]

{ #category : #updating }
DrGAngle3PointsCostume >> updateRecData [
|size|
	(vector1 = (0@0) or: [vector2 = (0@0)]) 
		ifTrue: [^self].
	size := drawable pixelToWorld: 10.
	vector1 := drawable vectorToMorph: (size * vector1 / vector1 r).
	vector2 := drawable vectorToMorph: (size * vector2 / vector2 r).
	screenCenter := drawable worldToMorph: center.
]

{ #category : #updating }
DrGAngle3PointsCostume >> updateToInvisible [
	super updateToInvisible.
	drawable removeMorph: shapeMorph.
]

{ #category : #updating }
DrGAngle3PointsCostume >> updateToVisible [
	super updateToVisible.
	style isNotHidden
		ifTrue: [drawable addMorph: shapeMorph]
]
