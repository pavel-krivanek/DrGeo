"
A Theme for tablet, without dialog and window decoration.
"
Class {
	#name : #DrGeoTheme,
	#superclass : #UIThemeWatery,
	#category : #DrGeoII-Polymorph
}

{ #category : #'as yet unclassified' }
DrGeoTheme >> configureWindowBorderFor: aWindow [
	aWindow borderWidth: 0
]

{ #category : #'as yet unclassified' }
DrGeoTheme >> createCloseBoxFor: aSystemWindow [
	^ MultistateButtonMorph new extent: 0@0
]

{ #category : #'as yet unclassified' }
DrGeoTheme >> createCollapseBoxFor: aSystemWindow [
	^ MultistateButtonMorph new extent: 0@0
]

{ #category : #'as yet unclassified' }
DrGeoTheme >> createExpandBoxFor: aSystemWindow [
	^ MultistateButtonMorph new extent: 0@0
]

{ #category : #'as yet unclassified' }
DrGeoTheme >> createMenuBoxFor: aSystemWindow [
	^ MultistateButtonMorph new extent: 0@0
]

{ #category : #'as yet unclassified' }
DrGeoTheme >> initialize [
	"Initialize the receiver."

	super initialize.
	self windowActiveDropShadowStyle: #nodiffuse
]

{ #category : #'as yet unclassified' }
DrGeoTheme >> newToolSpacerIn: aThemedMorph [
	"Answer a new tool spacer."

	^Morph new
		borderWidth: 0;
		color: Color transparent;
		extent: 6@6
]
