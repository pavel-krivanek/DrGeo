"
I can browse Dr. Geo user scripts.
"
Class {
	#name : #DrGScriptBrowser,
	#superclass : #Object,
	#instVars : [
		'browser'
	],
	#category : #DrGeoII-Polymorph
}

{ #category : #'instance creation' }
DrGScriptBrowser class >> open [
	^ self open:  'Dr. Geo script browser' translated.
]

{ #category : #'instance creation' }
DrGScriptBrowser class >> open: title [
	^ self new open: title
]

{ #category : #building }
DrGScriptBrowser >> buildBrowser [
	browser := GLMTabulator new.
	browser initialExtent: 550@450.
	browser
		row: [ :aRow | aRow column: #scripts; column: #methods ];
		row: #source.
	browser transmit	to: #scripts; andShow: [ :a | 
			self scriptsIn: a ].
	browser transmit	from: #scripts;  to: #methods; andShow: [ :composite | 
			self methodsIn: composite ].
	browser transmit from: #methods; to: #source;  andShow: [ :composite | 
		self sourceIn: composite ].
	^ browser
]

{ #category : #submorphs-add/remove }
DrGScriptBrowser >> delete [
	browser ifNotNil: [ 
		browser window ifNotNil: [ :view | view delete ].
		browser := nil]
]

{ #category : #querying }
DrGScriptBrowser >> methodsIn: composite [  
	composite wrapper  title: 'Methods' translated;
		show: [ :wrapper |
			wrapper fastList 
				display: [ :aClass | aClass methods collect: [ :m | m asRingDefinition ]];
				format: [ :aCompiledMethod | aCompiledMethod selector asString ] ].
	composite wrapper title:  'Script data' translated;
		show: [ :wrapper |
			wrapper fastList 
				display: [ :aClass | aClass class methods collect: [ :m | m asRingDefinition ]];
				format: [ :aCompiledMethod | aCompiledMethod selector asString ] ].
	composite updateOn: MethodModified from: [ SystemAnnouncer uniqueInstance ].

	composite onChangeOfPort: #activePresentation act: [ :presentation | 
		(presentation pane port: #activePresentation) value ifNotNil: [ :activePresentation | 
			((browser paneNamed: #methods) port: #selection) value: (activePresentation defaultPane port: #selection) value ] ].

]

{ #category : #'instance creation' }
DrGScriptBrowser >> open: title [
	self buildBrowser.
	browser title:  title.
	browser openOn: self organizer.
]

{ #category : #querying }
DrGScriptBrowser >> organizer [
	^ DrGeoUserScript allSubclasses 
]

{ #category : #querying }
DrGScriptBrowser >> scriptsIn: constructor [
	constructor fastList
		title: 'Scripts' translated;
		display: [ :organiser |  organiser ];
		format: #scriptName;
		updateOn: MethodModified from: [ SystemAnnouncer uniqueInstance ].
]

{ #category : #querying }
DrGScriptBrowser >> sourceIn: composite [
	^ composite pharoMethod 
		title: 'Source code' translated;
		smalltalkClass: [ :each | each methodClass];
		display: [ :aCompiledMethod | aCompiledMethod sourceCode ];
		updateOn: MethodModified from: [ SystemAnnouncer uniqueInstance ];
		act: [ :presentation :compiledMethod |
			compiledMethod methodClass compile: presentation text.
			presentation update.] 
		on: $s 
		entitled: 'Save' translated
]
