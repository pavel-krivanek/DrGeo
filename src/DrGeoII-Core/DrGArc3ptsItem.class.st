Class {
	#name : #DrGArc3ptsItem,
	#superclass : #DrGArcItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'xml writing' }
DrGArc3ptsItem >> nodeType [
	^#'3pts'
]

{ #category : #comparing }
DrGArc3ptsItem >> parentsEqual: aMathItem [ 
	^ self parents = aMathItem parents
		or: [self parents reverse = aMathItem parents]
]

{ #category : #'as yet unclassified' }
DrGArc3ptsItem >> rehash [
 ^ hash := ((self parents hash bitXor: self parents reverse hash) bitXor: self nodeType hash) bitXor: self basicType hash
]

{ #category : #updating }
DrGArc3ptsItem >> update [
	| direction1 direction2 a b c ab |
	self doParentsExist ifTrue: 
		[a := parents first point.
		b := parents second point.
		c := parents third point.
		(a = b or: [c = b]) ifTrue: [^exist := false].
		direction1 := (DrGDirectionItem new)
					origin: (a + b) / 2;
					direction: (a - b) normal.
		direction2 := (DrGDirectionItem new)
					origin: (b + c) / 2;
					direction: (b - c) normal.
		center := direction1 intersectionWithDirection: direction2.
		center ifNil: [^self updateAsSegmentOrRay].
		a := a - center.
		b := b - center.
		c := c - center.
		radius := a r.
		origin := a y asFloat arcTan2: a x.
		ab := (b y asFloat arcTan2: b x) - origin.
		length := (c y asFloat arcTan2: c x) - origin.
		length = 0 ifTrue: [^exist := false].
		(length < 0 and: [ab < length or: [ab > 0]])  ifTrue: 
			[^length := length + DrGDirectionItem twoPi].
		(length > 0 and: [ab > length or: [ab < 0]]) 	ifTrue: 
			[length := length - DrGDirectionItem twoPi]].
]

{ #category : #updating }
DrGArc3ptsItem >> updateAsSegmentOrRay [
"the three point are aligned, the arc is a segment"
	exist := false.
]
