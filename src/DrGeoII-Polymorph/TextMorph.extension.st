Extension { #name : #TextMorph }

{ #category : #'*DrGeoII-Polymorph-extentions' }
TextMorph >> drawDropShadowOn: aCanvas [
	| fauxBounds oldColor range|
	(self startingIndex > text size)
		ifTrue: [self drawNullTextOn: aCanvas].
	fauxBounds := self bounds topLeft corner: self innerBounds bottomRight.
	fauxBounds := fauxBounds translateBy: self shadowOffset.
	oldColor := self textColor.
	self textColor: self shadowColor.
	aCanvas paragraph: self paragraph bounds: fauxBounds color: self shadowColor.
	self textColor: oldColor.
]
