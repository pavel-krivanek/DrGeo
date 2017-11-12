Class {
	#name : #DrGAngleBuilder,
	#superclass : #DrGMathItemBuilder,
	#instVars : [
		'pointA',
		'pointB',
		'pointC',
		'vectorA',
		'vectorB'
	],
	#category : #DrGeoII-Core-Builder
}

{ #category : #documentation }
DrGAngleBuilder class >> description [ 
	^ 'Angle defined by three points or two vectors.' translated
]

{ #category : #documentation }
DrGAngleBuilder class >> title [
	^ 'Angle' translated
]

{ #category : #private }
DrGAngleBuilder >> addItem: aMathItemCollection at: aPoint [
	super addItem: aMathItemCollection at: aPoint.
	aMathItemCollection first isPointItem
		ifTrue:
			[pointA ifNil: 
				[pointA := aMathItemCollection first.
				^self].
			pointB ifNil:
				[pointB := aMathItemCollection first.
				^self].
			pointC := aMathItemCollection first]
		ifFalse:
			[vectorA ifNil:
				[vectorA := aMathItemCollection first.
				^self].
			vectorB := aMathItemCollection first]
]

{ #category : #accessing }
DrGAngleBuilder >> arguments [
	^pointA 
		ifNotNil: [{pointA . pointB . pointC. point}]
		ifNil: [{vectorA . vectorB. point}]
]

{ #category : #testing }
DrGAngleBuilder >> isWanted: aMathItemCollection [
	^aMathItemCollection notEmpty
		and: [(aMathItemCollection first isPointItem
				and: [aMathItemCollection first ~= pointA
				and: [aMathItemCollection first ~= pointB]]	)
			or: 	[aMathItemCollection first isVectorItem 
				and: [aMathItemCollection first ~= vectorA]]]
]

{ #category : #constant }
DrGAngleBuilder >> mathItemClass [
	^pointA 
		ifNotNil: [DrGAngle3ptsItem]
		ifNil: [DrGAngleVectorsItem]
]

{ #category : #xml }
DrGAngleBuilder >> postProcess: item from: node [
	super postProcess: item from: node.
	(node attributeAt: #type) asSymbol == #vectors ifTrue: [
		self parseValuePosition: node of: item]
]

{ #category : #testing }
DrGAngleBuilder >> readyToBuild [
	^ (pointA notNil and: [pointB notNil and: [pointC notNil]])
		or: [vectorA notNil and: [vectorB notNil]]
			
]

{ #category : #updating }
DrGAngleBuilder >> reset [
	super reset.
	pointA := pointB := pointC := vectorA := vectorB := nil
]
