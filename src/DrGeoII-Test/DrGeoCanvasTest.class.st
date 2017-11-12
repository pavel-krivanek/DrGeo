Class {
	#name : #DrGeoCanvasTest,
	#superclass : #TestCase,
	#instVars : [
		'canvas'
	],
	#category : #DrGeoII-Test
}

{ #category : #'as yet unclassified' }
DrGeoCanvasTest class >> resources [ 
	^ {DrGeoCanvasTestResource}
]

{ #category : #running }
DrGeoCanvasTest >> setUp [ 
	canvas := DrGeoCanvasTestResource current canvas
]

{ #category : #running }
DrGeoCanvasTest >> tearDown [ 
	canvas := nil
]

{ #category : #testing-arc }
DrGeoCanvasTest >> testArc [
	| arc|
	arc := canvas arc: (canvas point: 8@2) to:  (canvas point: 6@6) to: (canvas point: 3@7).
	self assert: arc mathItem isArcItem.
	self assert: arc mathItem isGeometricItem.
	self assert: arc mathItem isCurveItem.
	""
	self should: (arc mathItem radius closeTo: 5).
	self should: (arc mathItem center = (3@2)).
	self should: (arc mathItem length closeTo: Float pi / 2 ).
	self should: (arc mathItem contains: 8@2).
	self shouldnt: (arc mathItem contains: 3@ -3).
	self shouldnt: (arc mathItem contains: -2@ 2).  
]

{ #category : #testing-arc }
DrGeoCanvasTest >> testArcUnicity [
	| arc1 arc2 a b c |
	a := canvas point: 788@985.
	b := canvas point: 700@980.
	c := canvas point: 650@900.
	arc1 := canvas arc: a to: b to: c. 
	arc2 := canvas arc: a to: b to: c.
	self assert: arc1 mathItem == arc2 mathItem.
	""
	arc2 := canvas arc: c to: b to: a.   
	self assert: arc1 mathItem == arc2 mathItem.
	""
	arc2 := canvas arc: a to: c to: b.   
	self shouldnt: arc1 mathItem == arc2 mathItem.
	""
	arc2 := canvas arc: b to: a to: c.   
	self shouldnt: arc1 mathItem == arc2 mathItem.
]

{ #category : #testing-circle }
DrGeoCanvasTest >> testCircle [
	| c|
	c := canvas circleCenter: (canvas point: 3@2) to:  (canvas point: 6@6).
	self assert: c mathItem isCircleItem.
	self assert: c mathItem isGeometricItem.
	self assert: c mathItem isCurveItem.
	""
	self should: (c mathItem radius closeTo: 5).
	self should: (c mathItem center = (3@2)).
	self should: (c mathItem contains: 8@2)	
]

{ #category : #testing-circle }
DrGeoCanvasTest >> testCircleRadius [
	| c |
	c := canvas circleCenter: (canvas point: 3@2) radius: (canvas freeValue: 5).
	self assert: c mathItem isCircleItem.
	self assert: c mathItem isGeometricItem.
	self assert: c mathItem isCurveItem.
	""
	self should: (c mathItem radius closeTo: 5).
	self should: (c mathItem center = (3@2)).
	self should: (c mathItem contains: 8@2)	
]

{ #category : #testing-circle }
DrGeoCanvasTest >> testCircleRadiusUnicity [
	| a r c1 c2|
	a := canvas point: 788@985.
	r := canvas freeValue: 5.
	c1 := canvas circleCenter: a radius: r.   
	c2 := canvas circleCenter: a radius: r.  
	self assert: c1 mathItem == c2 mathItem.
	""
	r := canvas freeValue: 5.
	c2 := canvas circleCenter: a radius: r.  
	self shouldnt: c1 mathItem == c2 mathItem.
]

{ #category : #testing-circle }
DrGeoCanvasTest >> testCircleUnicity [
	| a b c1 c2|
	a := canvas point: 788@985.
	b := canvas point: 788@1085.
	c1 := canvas circleCenter:  a to: b.
	c2 := canvas circleCenter: a to: b.  
	self assert: c1 mathItem == c2 mathItem.
	""
	c2 := canvas circleCenter: b to: a.  
	self shouldnt: c1 mathItem == c2 mathItem.
	""
	b := canvas point: 780 @ 900.
	c2 := canvas circleCenter: a to:  b.
	self shouldnt: c1 mathItem == c2 mathItem   
	
]

{ #category : #testing-direction }
DrGeoCanvasTest >> testDirectionCollinear [
	| d1 d2|
	d1 := canvas segment: (canvas point: 5@5) to: (canvas point: 8 @7).
	d2 := canvas segment: (canvas point: 5@5) to: (canvas point: 8 @13).
	self shouldnt: (d1 mathItem isCollinearWith: d2 mathItem).
	d2 := canvas segment: (canvas point: 15@5) to: (canvas point: 18@7).
	self should: (d1 mathItem isCollinearWith: d2 mathItem).
	""
	d2 := canvas line: (canvas point: 6@5) to: (canvas point: 9@7) .
	self should: (d1 mathItem isCollinearWith: d2 mathItem)  .
	""
	d2 := canvas ray: (canvas point: 6@4) to: (canvas point: 9@6) .
	self should: (d1 mathItem isCollinearWith: d2 mathItem)  .
	""
	d2 := canvas vector: (canvas point: 3@2) to: (canvas point: 6@4) .
	self should: (d1 mathItem isCollinearWith: d2 mathItem)  

]

{ #category : #testing-direction }
DrGeoCanvasTest >> testDirectionDirection [
	| d n v |
	d := canvas segment: (canvas point: 5@5) to: (canvas point: 8 @7).
	v := d mathItem direction.
	self should: v = (3@2).
	n := d mathItem normal.
	self should: ((n dotProduct:  v) closeTo: 0).
	self should: (n x * n x + (n y * n y) closeTo: 1)  
]

{ #category : #testing-direction }
DrGeoCanvasTest >> testDirectionIntersection [
	| d1 d2|
	d1 := canvas segment: (canvas point: -5@ -5) to: (canvas point: 5 @5).
	d2 := canvas segment: (canvas point: -5@5) to: (canvas point: 5@ -5).
	"only test if not collinenear in fact"
	self should: (((d1 mathItem intersectionWithDirection: d2 mathItem) closeTo: 0@0)).
	""
	d2 := canvas segment: (canvas point: -4@ -5) to: (canvas point: 6@ 5).
	self assert: (d1 mathItem intersectionWithDirection: d2 mathItem) isNil
]

{ #category : #testing-line }
DrGeoCanvasTest >> testLine [
	| a b l|
	a := canvas point: 88@985.
	b := canvas point: 98@1085.
	l := canvas line: a to: b.
	self assert: l mathItem isCurveItem.
	self assert: l mathItem isGeometricItem.
	self assert: l mathItem isDirectionItem.
	self assert: l mathItem isLineItem.
	""
	self should: (l mathItem contains: 89@995).
	self should: (l mathItem contains: 87@975).
	self should: (l mathItem contains: 188@1985).
	self shouldnt: (l mathItem contains: 5 @4)    
]

{ #category : #testing-line }
DrGeoCanvasTest >> testLineReflexion [
	| axe l1 l2  |
	axe := canvas line: (canvas point: 0 @ 0) to: (canvas point: 1 @ 2).
	""
	l1 := canvas line: (canvas point: 3@2) to: (canvas point: 2@4).
	l2 := canvas reflect: l1 axe: axe.
	self assert:(l2 mathItem origin closeTo:  -0.2@3.6).
	self assert: (l2 mathItem direction closeTo: 2.2@0.4)  

]

{ #category : #testing-line }
DrGeoCanvasTest >> testLineRotation [
	| l1 l2 c k |
	c := canvas point: 1 @ 1.
	k := canvas freeValue: Float pi / 3.
	""
	l1 := canvas line: (canvas point: 3@2) to: (canvas point: 2@4).
	l2 := canvas rotate: l1 center: c angle: k.
	self assert:( l2 mathItem origin closeTo:  1.13397@3.23205).
	self assert: (l2 mathItem direction closeTo: -2.23205@0.133974)  

]

{ #category : #testing-line }
DrGeoCanvasTest >> testLineScale [
	| l1 l2 c k |
	c := canvas point: 1 @ 1.
	k := canvas freeValue: 3.
	""
	l1 := canvas line: (canvas point: 3@2) to: (canvas point: 2@4).
	l2 := canvas scale: l1 center: c factor: k.
	self assert: (l2 mathItem origin closeTo: 7@4).
	self assert: (l2 mathItem direction = (l1 mathItem direction * 3)).
	""
	k := canvas freeValue: -3.
	l2 := canvas scale: l1 center: c factor: k.
	self assert: (l2 mathItem origin closeTo: -5@ -2).
	self assert: (l2 mathItem direction = (l1 mathItem direction * -3))  

]

{ #category : #testing-line }
DrGeoCanvasTest >> testLineSymmetry [
	| c l1 l2|
	c := canvas point: 2@2.
	""
	l1 := canvas line: (canvas point: 3@2) to: (canvas point: 2@4).
	l2 := canvas symmetry: l1 center:  c.
	self assert: l2 mathItem origin = (1@2).
	self assert: l2 mathItem direction = l1 mathItem direction negated 

]

{ #category : #testing-line }
DrGeoCanvasTest >> testLineTranslation [
	| l1 l2 t |
	l1 := canvas line: (canvas point: 3@2) to: (canvas point: 2@4).
	t := canvas vector: (canvas point: 1@1) to: (canvas point: 3@2).
	""
	l2 := canvas translate: l1 vector:  t.  
	self assert: l2 mathItem origin = (5@3).
	self assert: l2 mathItem direction = l1 mathItem direction.
	""  
	t := canvas vector: (canvas point: 3@2) to: (canvas point: 1@1).
	l2 := canvas translate: l1 vector:  t.  
	self assert: l2 mathItem origin = (1@1).
	self assert: l2 mathItem direction = l1 mathItem direction.

]

{ #category : #testing-line }
DrGeoCanvasTest >> testLineUnicity [
	| a b s1 s2|
	a := canvas point: 788@985.
	b := canvas point: 788@1085.
	s1 := canvas line: a to: b.
	s2 := canvas line: a to: b.  
	self assert: s1 mathItem == s2 mathItem.
	"Lines are oriented"
	s2 := canvas line: b to: a.  
	self shouldnt: s1 mathItem == s2 mathItem.
	""
	b := canvas point: 780 @ 900.
	s2 := canvas line: a to:  b.
	self shouldnt: s1 mathItem == s2 mathItem   
	
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointByCoordinates [
	|x y p|
	x := canvas freeValue: 12.
	y := canvas freeValue: -18.
	p := canvas pointX: x Y: y.
	self assert: p coordinates = (12 @ -18)   
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointByCoordinatesUnicity [
	|x y p q|
	x := canvas freeValue: 12.
	y := canvas freeValue: -18.
	p := canvas pointX: x Y: y.
	q := canvas pointX: x Y: y.
	self should: p mathItem == q mathItem.
	q := canvas pointX: x Y:  (canvas freeValue: -18.1).
	self shouldnt: p mathItem == q mathItem    
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointFree [
	| a b |
	a := canvas point: 55 @ 5.
	self assert: a coordinates = (55 @ 5).
	b := canvas point: -35 @ -45.
	self assert: b coordinates = (-35 @ -45).

]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointFreeUnicity [
	| a b |
	a := canvas point: 788@985.
	b := canvas point: 788@985.
	self assert: a mathItem == b mathItem.
	""
	b := canvas point: 788 @ 986.
	b moveTo: 788@985.
	canvas update.  
	self shouldnt: a mathItem == b mathItem.
	self should: a coordinates = b coordinates.
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointMiddle [
	| a b m s |
	a := canvas point: 5 @ 5.
	b := canvas point: -5 @ -5.
	m := canvas middleOf: a and: b.
	self assert: m coordinates = (0 @ 0).
	b := canvas point: -13 @ 8.
	m := canvas middleOf: a and: b.
	self assert: m coordinates = (-4 @ (13 / 2)).
	s := canvas
				segment: (canvas point: 8 @ 7)
				to: (canvas point: -15 @ -10).
	m := canvas middleOf: s.
	self assert: m coordinates = (-7 / 2 @ (-3 / 2))
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointMiddleUnicity [
	| a b s p q |
	a := canvas point: 5 @ 5.
	b := canvas point: -5 @ -5.
	p := canvas middleOf: a and: b.
	q := canvas middleOf: a and: b.
	self should: p mathItem == q mathItem.
	q := canvas middleOf: b and: a.
	self should: p mathItem == q mathItem.
	""
	s := canvas	segment: (canvas point: 8 @ 7) to: (canvas point: -15 @ -10).
	p := canvas middleOf: s.
	q := canvas middleOf: s.
	self should: p mathItem == q mathItem  
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointOnArc [
	| a b c curve p |
	a := canvas point: -5 @ 0.
	b := canvas point: 0 @ 5.
	c := canvas point: 5 @ 0.
	curve := canvas arc: a to: b to: c.
	""
	p := canvas pointOnCurve: curve at: 0.
	self assert: (p coordinates closeTo: -5 @ 0).
	""
	p mathItem setCurveAbscissa: 0.5.
	self assert: (p coordinates closeTo: 0 @ 5).
	""
	p mathItem setCurveAbscissa: 1.
	self assert: (p coordinates closeTo: 5 @ 0).
	""
	p mathItem setCurveAbscissa: 1/3  .
	self assert: (p coordinates closeTo: -2.5 @ 4.3301)
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointOnArcUnicity [
	| a b c curve p q|
	a := canvas point: -5 @ 0.
	b := canvas point: 0 @ 5.
	c := canvas point: 5 @ 0.
	curve := canvas arc: a to: b to: c.
	""
	p := canvas pointOnCurve: curve at: 0.9.
	q := canvas pointOnCurve: curve at: 0.9.
	self should: p mathItem == q mathItem.
	""  
	q := canvas pointOnCurve: curve at: 0.89.
	self shouldnt: p mathItem == q mathItem   

]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointOnCircle [
	| a b curve p |
	a := canvas point: -5 @ -5.
	b := canvas point: 0 @ -5.
	curve := canvas circleCenter: a to: b.
	""
	p := canvas pointOnCurve: curve at: 0.
	self assert: (p coordinates closeTo: 0 @ -5).
	""
	p := canvas pointOnCurve: curve at: 1/4.
	self assert: (p coordinates closeTo: -5 @ 0).
	""
	p := canvas pointOnCurve: curve at: 1/2.
	self assert: (p coordinates closeTo: -10 @ -5).
	""
	p := canvas pointOnCurve: curve at: 3/4.
	self assert: (p coordinates closeTo: -5 @ -10).
	""
	p := canvas pointOnCurve: curve at: 3/8.
	self assert: (p coordinates closeTo: -8.5355 @ -1.4645).

]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointOnCircleUnicity [
	| a b curve p q |
	a := canvas point: -5 @ -5.
	b := canvas point: 0 @ -5.
	curve := canvas circleCenter: a to: b.
	""
	p := canvas pointOnCurve: curve at: 0.4.
	q := canvas pointOnCurve: curve at: 0.4.
	self should: p mathItem == q mathItem.
	""
	q := canvas pointOnCurve: curve at: 0.41.
	self shouldnt: p mathItem == q mathItem  


]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointOnLine [
	| a b curve p |
	a := canvas point: -15 @ -45.
	b := canvas point: -13 @ -44.
	curve := canvas line: a to: b.
	p := canvas pointOnCurve: curve at: 0.35.
	self
		assert: (p coordinates closeTo: -15.4557 @ -45.2279)
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointOnLineUnicity [
	| a b curve p q|
	a := canvas point: -15 @ -45.
	b := canvas point: -13 @ -44.
	curve := canvas line: a to: b.
	p := canvas pointOnCurve: curve at: 0.35.
	q := canvas pointOnCurve: curve at: 0.35.
	self should: p mathItem == q mathItem.
	""
	q := canvas pointOnCurve: curve at: 0.34.
	self shouldnt: p mathItem == q mathItem.

]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointOnRay [
	| a b curve p |
	a := canvas point: -15 @ -45.
	b := canvas point: -13 @ -44.
	curve := canvas ray: a to: b.
	p := canvas pointOnCurve: curve at: 0.
	self assert: p coordinates = (-15 @ -45).
	""
	p mathItem setCurveAbscissa: 0.5.
	self
		assert: (p coordinates closeTo: -14.1056 @ -44.5528)
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointOnRayUnicity [
	| a b curve p q|
	a := canvas point: -15 @ -45.
	b := canvas point: -13 @ -44.
	curve := canvas ray: a to: b.
	p := canvas pointOnCurve: curve at: 0.21.
	q := canvas pointOnCurve: curve at: 0.21.
	self should: p mathItem == q mathItem.
	""
	q := canvas pointOnCurve: curve at: 0.22.
	self shouldnt: p mathItem == q mathItem   
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointOnSegment [
	| a b curve p |
	a := canvas point: -5 @ -5.
	b := canvas point: 5 @ 5.
	curve := canvas segment: a to: b.
	p := canvas pointOnCurve: curve at: 0.
	self assert: p coordinates = (-5 @ -5).
	p mathItem setCurveAbscissa: 1.
	self assert: p coordinates = (5 @ 5).
	p mathItem setCurveAbscissa: 0.5.
	self assert: p coordinates = (0 @ 0).
	p mathItem setCurveAbscissa: 1 / 3.
	self assert: p coordinates = (-5 / 3 @ (-5 / 3)).
	""
	a mathItem moveTo: 0 @ 0.
	canvas update.
	self assert: p coordinates = (5 / 3 @ (5 / 3)).
	""  
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointOnSegmentUnicity [
	| a b curve p q |
	a := canvas point: -25 @ -5.
	b := canvas point: 25 @ 5.
	curve := canvas segment: a to: b.
	p := canvas pointOnCurve: curve at: 0.7.
	q := canvas pointOnCurve: curve at: 0.7.
	self should: p mathItem == q mathItem.
	q := canvas pointOnCurve: curve at: 0.71.
	self shouldnt: p mathItem = q mathItem   
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointReflexion [
	| d a b|
	d := canvas line: (canvas point: 0@0) to: (canvas point: 1@2).
	""
	a := canvas point: 1@0.
	b := canvas reflect: a axe: d.  
	self assert: (b coordinates closeTo: -0.6@0.8).
	""
	a := canvas point: 1@2.
	b := canvas reflect: a axe: d.  
	self assert: (b coordinates = (1@2)).
	""
	a := canvas point: 0@3.
	b := canvas reflect: a axe: d.  
	self assert: (b coordinates closeTo:  2.4@1.8).

]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointRotation [
	| c v a b|
	c := canvas point: 1@1.
	v := canvas freeValue: Float pi / 3.  
	""
	a := canvas point: 2@1.
	b := canvas rotate: a center: c angle: v.
	self assert: (b coordinates closeTo: 1.5@1.8660).
	""
	v := canvas freeValue:  (Float pi / 3) negated.  
	b := canvas rotate: a center: c angle: v.
	self assert: (b coordinates closeTo: 1.5@0.13397).

]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointScale [
	| c k a b|
	c := canvas point: 1@1.
	k := canvas freeValue: 3.  
	""
	a := canvas point: 2@1.
	b := canvas scale: a center: c factor: k.
	self assert: b coordinates = (4@1).
	""
	a := canvas point: 3@2.
	b := canvas scale: a center: c factor: k.
	self assert: b coordinates = (7@4).
	""
	a := canvas point: 2@1.
	k := canvas freeValue: -3.  
	b := canvas scale: a center: c factor: k.
	self assert: b coordinates = (-2@1).
	""
	a := canvas point: 3@2.
	b := canvas scale: a center: c factor: k.
	self assert: b coordinates = (-5@ -2).

]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointSymmetry [
	| c a b|
	c := canvas point: 2@2.
	""
	a := canvas point: 4@2.
	b := canvas symmetry: a center:  c.
	self assert: b coordinates = (0@2).
	""
	a := canvas point: 4@3.
	b := canvas symmetry: a center:  c.
	self assert: b coordinates = (0@1).
	""
	a := canvas point: 4@4.
	b := canvas symmetry: a center:  c.
	self assert: b coordinates = (0@0)
]

{ #category : #testing-point }
DrGeoCanvasTest >> testPointTranslation [
	| u a|
	u := canvas vector: (canvas point: 1@1) to: (canvas point: 3@2).
	a := canvas translate: (canvas point: 2@1) vector: u.
	self assert: a coordinates = (4@2).
	""
	u := canvas vector: (canvas point: 3@2) to: (canvas point: 1@1).
	a := canvas translate: (canvas point: 2@1) vector: u.
	self assert: a coordinates = (0@0).

]

{ #category : #testing-polygon }
DrGeoCanvasTest >> testPolygon [
	| polygon summit |
	summit := Array withAll: {
		canvas point: -3@ -3.
		canvas point: -3@3.
		canvas point: 3@3.
		canvas point: 3@ -3}.
	polygon := canvas polygon: summit.
	self assert: polygon mathItem isGeometricItem.
	self assert: polygon mathItem isPolygonItem. 
	self deny: polygon mathItem isCurveItem.
	self should: polygon mathItem length = 24.  
]

{ #category : #testing-polygon }
DrGeoCanvasTest >> testPolygonUnicity [
	| p1 p2 summit |
	summit := Array withAll: {
		canvas point: -3@ -3.
		canvas point: -3@3.
		canvas point: 3@3.
		canvas point: 3@ -3}.
	p1 := canvas polygon: summit.
	summit := Array withAll: {
		canvas point: 3@ -3.
		canvas point: -3@ -3.
		canvas point: -3@3.
		canvas point: 3@3}.
	p2 := canvas polygon: summit.
	self assert: p1 mathItem == p2 mathItem.
	""
	summit := Array withAll: {
		canvas point: -3@3.
		canvas point: -3@ -3.
		canvas point: 3@3.
		canvas point: 3@ -3}.
	p2 := canvas polygon: summit.
	self deny: p1 mathItem == p2 mathItem   
]

{ #category : #testing-ray }
DrGeoCanvasTest >> testRay [
	| a b r|
	a := canvas point: 88@985.
	b := canvas point: 98@1085.
	r := canvas ray: a to: b.
	self assert: r mathItem isCurveItem.
	self assert: r mathItem isGeometricItem.
	self assert: r mathItem isDirectionItem.
	self assert: r mathItem isRayItem.
	""
	self should: (r mathItem contains: 89@995).
	self should: (r mathItem contains: 188@1985).
	self shouldnt: (r mathItem contains: 87@975).
	self shouldnt: (r mathItem contains: 5 @4)
]

{ #category : #testing-ray }
DrGeoCanvasTest >> testRayReflexion [
	| axe r1 r2  |
	axe := canvas line: (canvas point: 0 @ 0) to: (canvas point: 1 @ 2).
	""
	r1 := canvas ray: (canvas point: 3@2) to: (canvas point: 2@4).
	r2 := canvas reflect: r1 axe: axe.
	self assert:(r2 mathItem origin closeTo:  -0.2@3.6).
	self assert: (r2 mathItem direction closeTo: 2.2@0.4)  

]

{ #category : #testing-ray }
DrGeoCanvasTest >> testRayRotation [
	| r1 r2 c k |
	c := canvas point: 1 @ 1.
	k := canvas freeValue: Float pi / 3.
	""
	r1 := canvas ray: (canvas point: 3@2) to: (canvas point: 2@4).
	r2 := canvas rotate: r1 center: c angle: k.
	self assert:(r2 mathItem origin closeTo:  1.13397@3.23205).
	self assert: (r2 mathItem direction closeTo: -2.23205@0.133974)  

]

{ #category : #testing-ray }
DrGeoCanvasTest >> testRayScale [
	| r1 r2 c k |
	c := canvas point: 1 @ 1.
	k := canvas freeValue: 3.
	""
	r1 := canvas ray: (canvas point: 3@2) to: (canvas point: 2@4).
	r2 := canvas scale: r1 center: c factor: k.
	self assert: (r2 mathItem origin closeTo: 7@4).
	self assert: (r2 mathItem direction = (r1 mathItem direction * 3)).
	""
	k := canvas freeValue: -3.
	r2 := canvas scale: r1 center: c factor: k.
	self assert: (r2 mathItem origin closeTo: -5@ -2).
	self assert: (r2 mathItem direction = (r1 mathItem direction * -3))  

]

{ #category : #testing-ray }
DrGeoCanvasTest >> testRaySymmetry [
	| c r1 r2|
	c := canvas point: 2@2.
	""
	r1 := canvas ray: (canvas point: 3@2) to: (canvas point: 2@4).
	r2 := canvas symmetry: r1 center:  c.
	self assert: r2 mathItem origin = (1@2).
	self assert: r2 mathItem direction = r1 mathItem direction negated 

]

{ #category : #testing-ray }
DrGeoCanvasTest >> testRayTranslation [
	| r1 r2 t |
	r1 := canvas ray: (canvas point: 3@2) to: (canvas point: 2@4).
	t := canvas vector: (canvas point: 1@1) to: (canvas point: 3@2).
	""
	r2 := canvas translate: r1 vector:  t.  
	self assert: r2 mathItem origin = (5@3).
	self assert: r2 mathItem direction = r1 mathItem direction.
	""  
	t := canvas vector: (canvas point: 3@2) to: (canvas point: 1@1).
	r2 := canvas translate: r1 vector:  t.  
	self assert: r2 mathItem origin = (1@1).
	self assert: r2 mathItem direction = r1 mathItem direction.

]

{ #category : #testing-ray }
DrGeoCanvasTest >> testRayUnicity [
	| a b s1 s2|
	a := canvas point: 788@985.
	b := canvas point: 788@1085.
	s1 := canvas ray: a to: b.
	s2 := canvas ray: a to: b.  
	self assert: s1 mathItem == s2 mathItem.
	""
	s2 := canvas ray: b to: a.  
	self shouldnt: s1 mathItem == s2 mathItem.
	""
	b := canvas point: 780 @ 900.
	s2 := canvas ray: a to:  b.
	self shouldnt: s1 mathItem == s2 mathItem   
	
]

{ #category : #testing-segment }
DrGeoCanvasTest >> testSegment [
	| a b s|
	a := canvas point: 88@985.
	b := canvas point: 98@1085.
	s := canvas segment: a to: b.
	self assert: s mathItem isCurveItem.
	self assert: s mathItem isGeometricItem.
	self assert: s mathItem isDirectionItem.
	self assert: s mathItem isSegmentItem.
	""
	self should: (s mathItem contains: 89@995).
	self shouldnt: (s mathItem contains: 87@975).
	self shouldnt: (s mathItem contains: 188@1095).
	self shouldnt: (s mathItem contains: 5 @4)    
]

{ #category : #testing-segment }
DrGeoCanvasTest >> testSegmentReflexion [
	| d u v|
	d := canvas
				line: (canvas point: 0 @ 0)
				to: (canvas point: 1 @ 2).
	""
	u := canvas segment: (canvas point: 3@2) to: (canvas point: 2@4).
	v := canvas reflect: u axe:  d.
	self assert:( v mathItem origin closeTo:  -0.2@3.6).
	self assert: (v mathItem direction closeTo: 2.2@0.4)  

]

{ #category : #testing-segment }
DrGeoCanvasTest >> testSegmentRotation [
	| u v c k |
	c := canvas point: 1 @ 1.
	k := canvas freeValue: Float pi / 3.
	""
	u := canvas segment: (canvas point: 3@2) to: (canvas point: 2@4).
	v := canvas rotate: u center: c angle: k.
	self assert:( v mathItem origin closeTo:  1.13397@3.23205).
	self assert: (v mathItem direction closeTo: -2.23205@0.133974)  

]

{ #category : #testing-segment }
DrGeoCanvasTest >> testSegmentScale [
	| u v c k |
	c := canvas point: 1 @ 1.
	k := canvas freeValue: 3.
	""
	u := canvas segment: (canvas point: 3@2) to: (canvas point: 2@4).
	v := canvas scale: u center: c factor: k.
	self assert: (v mathItem origin closeTo: 7@4).
	self assert: (v mathItem direction = (u mathItem direction * 3)). 
	""
	k := canvas freeValue: -3.
	v := canvas scale: u center: c factor: k.
	self assert: (v mathItem origin closeTo: -5@ -2).
	self assert: (v mathItem direction = (u mathItem direction * -3))  

]

{ #category : #testing-segment }
DrGeoCanvasTest >> testSegmentSymmetry [
	| c u v|
	c := canvas point: 2@2.
	""
	u := canvas segment: (canvas point: 3@2) to: (canvas point: 2@4).
	v := canvas symmetry: u center:  c.
	self assert: v mathItem origin = (1@2).
	self assert: v mathItem direction = u mathItem direction negated 

]

{ #category : #testing-segment }
DrGeoCanvasTest >> testSegmentTranslation [
	| u v t |
	u := canvas segment: (canvas point: 3@2) to: (canvas point: 2@4).
	t := canvas vector: (canvas point: 1@1) to: (canvas point: 3@2).
	""
	v := canvas translate: u vector:  t.  
	self assert: v mathItem origin = (5@3).
	self assert: v mathItem direction = u mathItem direction.
	""  
	t := canvas vector: (canvas point: 3@2) to: (canvas point: 1@1).
	v := canvas translate: u vector:  t.  
	self assert: v mathItem origin = (1@1).
	self assert: v mathItem direction = u mathItem direction.

]

{ #category : #testing-segment }
DrGeoCanvasTest >> testSegmentUnicity [
	| a b s1 s2|
	a := canvas point: 788@985.
	b := canvas point: 788@1085.
	s1 := canvas segment: a to: b.
	s2 := canvas segment: a to: b.  
	self assert: s1 mathItem == s2 mathItem.
	""
	s2 := canvas segment: b to: a.  
	self assert: s1 mathItem == s2 mathItem.
	""
	b := canvas point: 780 @ 901.
	s2 := canvas segment: a to:  b.
	self deny: s1 mathItem == s2 mathItem   
	
]

{ #category : #testing-value }
DrGeoCanvasTest >> testValueFree [
	| v |
	v := canvas freeValue: Float pi / 3.  
	self assert: (v mathItem valueItem closeTo: Float pi / 3).
	""
	v := canvas freeValue: 0.00001.  
	self assert: (v mathItem valueItem closeTo: 0.00001).

]

{ #category : #testing-vector }
DrGeoCanvasTest >> testVector [
	| a b v|
	a := canvas point: 88@985.
	b := canvas point: 98@1085.
	v := canvas vector: a to: b.
	self deny: v mathItem isCurveItem.
	self assert: v mathItem isGeometricItem.
	self assert: v mathItem isDirectionItem.
	self assert: v mathItem isVectorItem.
	self deny: v mathItem isSegmentItem.
	""
	self should: (v mathItem direction = (10@100)).
	""
	v mathItem move: 5@4;
		update.
	self should: v mathItem direction = (10@100).
 
]

{ #category : #testing-vector }
DrGeoCanvasTest >> testVectorUnicity [
	| a b v u|
	a := canvas point: 2@5.
	b := canvas point: 4@8.
	u := canvas vector: a to: b.
	v := canvas vector: a to: b.
	self assert: u mathItem == v mathItem.
	""  
	v := canvas vector: b to: a.
	self deny: u mathItem == v mathItem.
	""
	a := canvas point: -4@ -5.
	b := canvas point: -2@ -2.
	v := canvas vector: a to: b.
	self deny: u mathItem == v mathItem.
	self assert: u mathItem direction = v mathItem direction   
]
