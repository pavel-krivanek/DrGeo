"
A DrGArcCenterAngleItem is defined by its center, startingPoint and endingPoint.
endingPoint is not necessary on the arc but it provides the arc angle
"
Class {
	#name : #DrGArcCenterAngleItem,
	#superclass : #DrGArcItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'xml writing' }
DrGArcCenterAngleItem >> nodeType [
	^ #centerAngle
]

{ #category : #updating }
DrGArcCenterAngleItem >> update [
| a |
	self doParentsExist ifTrue: 
		[center := self parents first point.
		a := self parents second point - center.
		radius := a   r.
		origin := a y asFloat arcTan2: a x.
		a := parents third point - center.
		length := (a y asFloat arcTan2: a x) - origin.
		length < Float pi negated
			ifTrue: [length := length + Float twoPi]
			ifFalse: [
				length > Float pi ifTrue: [length := length - Float twoPi]]]
]
