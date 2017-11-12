"
I can browser *one* Dr. Geo user script, to view or/and to edit its contents.
"
Class {
	#name : #DrGScriptEditor,
	#superclass : #DrGScriptBrowser,
	#instVars : [
		'class'
	],
	#category : #DrGeoII-Polymorph
}

{ #category : #'instance creation' }
DrGScriptEditor class >> open [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
DrGScriptEditor class >> open: title [
	self shouldNotImplement 
]

{ #category : #'instance creation' }
DrGScriptEditor class >> openOnScript: scriptClass [
	^ self new open: scriptClass 
]

{ #category : #building }
DrGScriptEditor >> buildBrowser [
	browser := GLMTabulator new.
	browser initialExtent: 550@450.
	browser row:  #methods;  row: #source.
	browser transmit	to:  #methods; andShow: [ :composite | 
			self methodsIn: composite ].
	browser transmit from: #methods; to: #source;  andShow: [ :composite | 
		self sourceIn: composite ].
	^ browser
]

{ #category : #'instance creation' }
DrGScriptEditor >> open: scriptClass [
	self buildBrowser.
	browser title:  ('Edit script: {1}' translated format: {scriptClass scriptName}) .
	browser openOn: scriptClass 
]
