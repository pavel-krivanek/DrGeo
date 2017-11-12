"
A DrGArcMorph is sampling an arc defined by
- its center
- its radius
- a starting point
- a signer length
"
Class {
	#name : #DrGArcMorph,
	#superclass : #DrGPolylineMorph,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGArcMorph >> center: aPoint radius: aFloat origin: anOrigin length: aLength [
|step costep sinstep csteX csteY mobile|
	vertices := OrderedCollection new.
	aFloat ~= 0 
		ifTrue: [
			step := 5 / aFloat * aLength sign.
			step  ~= 0 ifTrue: [
				(aLength / step) abs > 100 ifTrue: [step := aLength / 100].
				costep := step cos.	sinstep := step sin.
				csteX := aPoint x * (1 - costep) + (aPoint y * sinstep).
				csteY := aPoint y * (1 - costep) - (aPoint x * sinstep).
				mobile := aPoint + (aFloat * (anOrigin cos @ anOrigin sin)).
				vertices add: mobile.
				0 to: (aLength / step) truncated -1  do: [:i|
					mobile := (mobile x * costep - (mobile y * sinstep) + csteX)
						@(mobile x * sinstep + (mobile y * costep) + csteY).
					vertices add: mobile]].
			mobile := aPoint + (aFloat * ((anOrigin + aLength) cos @ (anOrigin + aLength) sin)).
			vertices add: mobile]
		ifFalse: [vertices add: aPoint].
	self computeBounds
]

{ #category : #accessing }
DrGArcMorph >> color: aColor [
	|theColor|
	costume style 
		ifNotNil: [theColor := costume style isTranslucent ifTrue: [aColor alpha: 0.3] ifFalse: [aColor]]
	 	ifNil: [theColor := aColor].
	super color: theColor
]
