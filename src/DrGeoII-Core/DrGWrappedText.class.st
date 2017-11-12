Class {
	#name : #DrGWrappedText,
	#superclass : #DrGWrappedItem,
	#category : #DrGeoII-Core-Script
}

{ #category : #accessing }
DrGWrappedText >> backgroundColor: aColor [
	costume style backgroundColor: aColor
]

{ #category : #updating }
DrGWrappedText >> moveTo: aPoint [
	self mathItem position: aPoint    
]

{ #category : #updating }
DrGWrappedText >> text: aText [
	self mathItem text: aText asText.
	costume updateMyText.
	"Ugly from Athens support for text, to check more carefully XXX "
	costume morph color: Color cyan.
	costume color: costume style color.
]
