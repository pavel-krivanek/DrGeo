"
Preferences for Android tablet
"
Class {
	#name : #DrGAndroid,
	#superclass : #DrGTablet,
	#category : #DrGeoII-Core-Resources
}

{ #category : #initialize-release }
DrGAndroid >> initialize [
	canWeDisplayLoader := true.
	WorldState desktopMenuTitle: 'Dr. Geo'.
	WorldState desktopMenuPragmaKeyword:  'drgeoMenu'.
	PolymorphSystemSettings uiThemeClass:  DrGeoTheme.
	UITheme currentSettings fastDragging: true.
	UITheme currentSettings fadedBackgroundWindows: false.
	SystemWindow fullscreenMargin: 0.
	UITheme currentSettings preferRoundCorner: false.

	TaskbarMorph showTaskbar: false.
	World color: Color white.
]

{ #category : #testing }
DrGAndroid >> isAndroid [
	^ true
]

{ #category : #path }
DrGAndroid >> mySketchesPath [
	^ ((Smalltalk at: #Android) getSDCardRoot), '/MySketches'.
]

{ #category : #'as yet unclassified' }
DrGAndroid >> openURI: string [
	(Smalltalk at: #Android) openURI: string
]

{ #category : #path }
DrGAndroid >> rootPath [
	^  FileLocator imageDirectory
]

{ #category : #'user interface' }
DrGAndroid >> showVirtualKeyboard: boolean [
	(Smalltalk at: #Android) onScreenKbd: (boolean ifTrue: [1] ifFalse: [0])
]

{ #category : #initialize-release }
DrGAndroid >> startUp [ 
	super startUp.
	(Smalltalk at: #Android) setVMTimerInterval: 100
]
