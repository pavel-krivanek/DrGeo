"
A thumb wheel widget control
"
Class {
	#name : #WheelMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'target',
		'actionSelector',
		'factor',
		'circular',
		'old',
		'angle',
		'maxAngle',
		'lastRedraw'
	],
	#category : #DrGeoII-Core-UI
}

{ #category : #accessing }
WheelMorph >> actionSelector [
	^ actionSelector

]

{ #category : #accessing }
WheelMorph >> actionSelector: aSymbolOrString [

	(nil = aSymbolOrString or:
	 ['nil' = aSymbolOrString or:
	 [aSymbolOrString isEmpty]])
		ifTrue: [^ actionSelector := nil].

	actionSelector := aSymbolOrString asSymbol.


]

{ #category : #private }
WheelMorph >> addAngle: aNumber [
	| new |
	new := self angle + aNumber.
	self isCircular ifTrue: [new := new \\ self maxAngle].
	self angle: new.
	lastRedraw := lastRedraw + aNumber.
	(lastRedraw abs > 2) ifTrue: [
		lastRedraw := 0.
		self changed]
]

{ #category : #accessing }
WheelMorph >> angle [
	^angle
]

{ #category : #accessing }
WheelMorph >> angle: aNumber [
	angle := aNumber
]

{ #category : #properties }
WheelMorph >> beCircular [
	circular := true
]

{ #category : #properties }
WheelMorph >> beHorizontal [
	self isHorizontal
		ifFalse: [self extent: self extent transposed] 
]

{ #category : #properties }
WheelMorph >> beLinear [
	circular := false
]

{ #category : #properties }
WheelMorph >> beVertical [
	self isHorizontal
		ifTrue: [self extent: self extent transposed] 
]

{ #category : #'event handling' }
WheelMorph >> doTargetAction: cursorPoint [
	| new delta |
	self isHorizontal
		ifTrue: [new := cursorPoint x]
		ifFalse: [new := cursorPoint y].
	delta := new - old.
	delta isZero ifTrue: [^self].
	self addAngle: delta.
	(target ~~ nil and: [actionSelector ~~ nil]) ifTrue: [
		Cursor normal showWhile: [
			target perform: actionSelector withArguments: (Array with: (delta * self factor))]].
	old := new.

]

{ #category : #drawing }
WheelMorph >> drawOn: aCanvas [
	| interval delta frame x0 x1 y0 y1 deltaX deltaY  hilitColor shadowColor |
	super drawOn: aCanvas.		"border & background"
	borderColor isColor
		ifTrue: [hilitColor := shadowColor := borderColor]
		ifFalse: [hilitColor := color lighter lighter.
			shadowColor := color darker darker].
	frame := self innerBounds insetBy: 2.
	aCanvas frameAndFillRectangle: frame fillColor: color
		borderWidth: 1 topLeftColor: hilitColor bottomRightColor: shadowColor.
	frame := frame insetBy: (borderColor isColor ifTrue: [1] ifFalse: [2]).
	x0 := frame origin x.
	x1 := frame corner x.
	y0 := frame origin y.
	y1 := frame corner y.
	deltaX := (x1 - x0) / 2.
	deltaY := (y1 - y0) / 2.
	interval := 10.
	delta := self angle \\ interval.
	1 to: (self maxAngle / (2 * interval)) rounded do: [ :i |
		| x y |
		self isHorizontal ifTrue: [
			x := x0 + deltaX - (((i * interval + delta) * (2 * Float pi / 360.0)) cos * deltaX).
			aCanvas fillRectangle: (Rectangle origin: (x-1)@y0 corner: x@y1) color: hilitColor.
			borderColor isColor ifFalse:
				 [aCanvas fillRectangle: (Rectangle origin: x@y0 corner: (x+1)@y1) color: shadowColor]]
		ifFalse: [
			y := y0 + deltaY - (((i * interval + delta) * (2 * Float pi / 360.0)) cos * deltaY).
			aCanvas fillRectangle: (Rectangle origin: x0@(y-1) corner: x1@y) color: hilitColor.
			borderColor isColor ifFalse:
				 [aCanvas fillRectangle: (Rectangle origin: x0@y corner: x1@(y+1)) color: shadowColor]]]
]

{ #category : #accessing }
WheelMorph >> factor [
	^factor
]

{ #category : #accessing }
WheelMorph >> factor: aFloat [
	factor := aFloat
]

{ #category : #'event handling' }
WheelMorph >> handlesMouseDown: evt [
	^true

]

{ #category : #initialization }
WheelMorph >> initialize [
	super initialize.
	self target: nil.
	self actionSelector: #flash.
	self angle: 0.
	self maxAngle: 360.
	self factor: 1.0.
	self extent: 100@23.
	self beCircular.
	self borderColor: #raised.
	self borderWidth: 1.
	self color: Color lightGray.
	lastRedraw := 0.
]

{ #category : #properties }
WheelMorph >> isCircular [
	^circular
]

{ #category : #properties }
WheelMorph >> isHorizontal [
	^ bounds isWide
]

{ #category : #properties }
WheelMorph >> isLinear [
	^circular not
]

{ #category : #properties }
WheelMorph >> isVertical [
	^self isHorizontal not
]

{ #category : #accessing }
WheelMorph >> maxAngle [
	^maxAngle
]

{ #category : #accessing }
WheelMorph >> maxAngle: aNumber [
	maxAngle := aNumber
]

{ #category : #'event handling' }
WheelMorph >> mouseDown: evt [
	self isHorizontal
		ifTrue: [old := evt cursorPoint x]
		ifFalse: [old := evt cursorPoint y].
]

{ #category : #'event handling' }
WheelMorph >> mouseMove: evt [
	(evt anyButtonPressed)
		ifTrue: [self doTargetAction: evt cursorPoint]
]

{ #category : #accessing }
WheelMorph >> target [
	^target
]

{ #category : #accessing }
WheelMorph >> target: aTargetObject [
	target := aTargetObject
]
