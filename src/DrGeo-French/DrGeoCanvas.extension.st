Extension { #name : #DrGeoCanvas }

{ #category : #'*DrGeo-French-value' }
DrGeoCanvas >> abscisseDe:  wrpPointOrWrpVectorOrPoint [
	^ self abscissaOf: wrpPointOrWrpVectorOrPoint 
]

{ #category : #'*DrGeo-French-processing' }
DrGeoCanvas >> actualiser [
	^ self update
]

{ #category : #'*DrGeo-French-user interface' }
DrGeoCanvas >> afficherAxes [
	^ self axesOn
]

{ #category : #'*DrGeo-French-user interface' }
DrGeoCanvas >> afficherGrille [
	^ self gridOn
]

{ #category : #'*DrGeo-French-value' }
DrGeoCanvas >> angleCentre: wrpPt1 de: wrpPt2 a: wrpPt3 [
	^ self angle: wrpPt2  to: wrpPt1  to: wrpPt3 
]

{ #category : #'*DrGeo-French-value' }
DrGeoCanvas >> angleVecteurs: wrpVecteur1 et: wrpVecteur2 [
	^ self angle: wrpVecteur1 to: wrpVecteur2 
]

{ #category : #'*DrGeo-French-curve finit' }
DrGeoCanvas >> arcCentre: wrpPt1 de: wrpPt2 a: wrpPt3 [
	^ self arcCenter: wrpPt1 from: wrpPt2 to: wrpPt3
]

{ #category : #'*DrGeo-French-curve finit' }
DrGeoCanvas >> arcDe: wrpPt1 a: wrpPt3 passantPar: wrpPt2 [
	^ self arc: wrpPt1 to: wrpPt2 to: wrpPt3
]

{ #category : #'*DrGeo-French-point' }
DrGeoCanvas >> autreIntersectionDe: wrpCurve1 et: wrpCurve2 [
	^ self altIntersectionOf: wrpCurve1 and: wrpCurve2 
]

{ #category : #'*DrGeo-French-curve' }
DrGeoCanvas >> bissectrice: wrpAngle [
	^ self angleBisector: wrpAngle
]

{ #category : #'*DrGeo-French-curve' }
DrGeoCanvas >> bissectriceSommet: wrpSummit cote1: wrpPt1 cote2: wrpPt2 [
	^ self angleBisectorSummit: wrpSummit side1: wrpPt1 side2: wrpPt2 
]

{ #category : #'*DrGeo-French-user interface' }
DrGeoCanvas >> centrerVueEn: aPoint [
	^ self centerTo: aPoint
]

{ #category : #'*DrGeo-French-curve filled' }
DrGeoCanvas >> cercleCentre: wrpCenter passantPar: wrpPt [
	^ self circleCenter: wrpCenter to: wrpPt
]

{ #category : #'*DrGeo-French-curve filled' }
DrGeoCanvas >> cercleCentre: wrpCenter rayon: wrpValue [
	^ self circleCenter: wrpCenter radius: wrpValue
]

{ #category : #'*DrGeo-French-curve filled' }
DrGeoCanvas >> cercleCentre: wrpCenter segment: wrpSegment [
	^ self circleCenter: wrpCenter segment: wrpSegment
]

{ #category : #'*DrGeo-French-helpers' }
DrGeoCanvas >> courbeDe: f de: x0 a: x1 [
	^ self plot: f from: x0 to: x1
]

{ #category : #'*DrGeo-French-helpers' }
DrGeoCanvas >> decimal: value a: aPoint min: startValue max: endValue [
	^ self float: value at: aPoint from: startValue to: endValue 
]

{ #category : #'*DrGeo-French-helpers' }
DrGeoCanvas >> decimal: value a: aPoint min: startValue max: endValue nom: name [
	^ self float: value at: aPoint from: startValue to: endValue name: name
]

{ #category : #'*DrGeo-French-helpers' }
DrGeoCanvas >> decimal: value a: aPoint min: startValue max: endValue nom: name afficherValeur: isValueDisplay [
	^ self float: value at: aPoint from: startValue to: endValue name: name showValue: isValueDisplay
]

{ #category : #'*DrGeo-French-curve' }
DrGeoCanvas >> demiDroiteOrigine: wrpPt1 passantPar: wrpPt2 [
	^ self ray: wrpPt1 to: wrpPt2 
]

{ #category : #'*DrGeo-French-value' }
DrGeoCanvas >> distanceDe: item1 a: item2 [
	^ self distance: item1 to: item2
]

{ #category : #'*DrGeo-French-curve' }
DrGeoCanvas >> droitePassantPar: wrpPt1 et: wrpPt2 [
	^ self line: wrpPt1 to: wrpPt2 
]

{ #category : #'*DrGeo-French-user interface' }
DrGeoCanvas >> echelle: anInteger [
	^ self scale: anInteger 
]

{ #category : #'*DrGeo-French-transformations' }
DrGeoCanvas >> echelleDe: wrpItem selonCentre: wrpCenter etFacteur: wrpValue [
	^ self scale: wrpItem center: wrpCenter factor: wrpValue
]

{ #category : #'*DrGeo-French-helpers' }
DrGeoCanvas >> entier: value a: aPoint min: startValue max: endValue [
	^ self integer: value at: aPoint from: startValue to: endValue 
]

{ #category : #'*DrGeo-French-helpers' }
DrGeoCanvas >> entier: value a: aPoint min: startValue max: endValue nom: name [
	^ self integer: value at: aPoint from: startValue to: endValue name: name
]

{ #category : #'*DrGeo-French-helpers' }
DrGeoCanvas >> entier: value a: aPoint min: startValue max: endValue nom: name afficherValeur: isValueDisplay [
	^ self integer: value at: aPoint from: startValue to: endValue name: name showValue: isValueDisplay
]

{ #category : #'*DrGeo-French-equation' }
DrGeoCanvas >> equationDe: wrpLineOrCircle [
	^ self equationOf: wrpLineOrCircle
]

{ #category : #'*DrGeo-French-helpers' }
DrGeoCanvas >> faire: aBlock [
	^ self do: aBlock
]

{ #category : #'*DrGeo-French-point' }
DrGeoCanvas >> intersectionDe: wrpCurve1 et: wrpCurve2 [
	^ self intersectionOf: wrpCurve1 and: wrpCurve2 
]

{ #category : #'*DrGeo-French-curve' }
DrGeoCanvas >> lieuDe: wrpPt1 lorsqueBouge: wrpPt2 [
	^ self locusOf: wrpPt1 when: wrpPt2 
]

{ #category : #'*DrGeo-French-value' }
DrGeoCanvas >> longueurDe: wrpItem [
	^ self lengthOf: wrpItem 
]

{ #category : #'*DrGeo-French-curve' }
DrGeoCanvas >> mediatrice: wrpSegment [
	^ self perpendicularBisector: wrpSegment
]

{ #category : #'*DrGeo-French-curve' }
DrGeoCanvas >> mediatrice: wrpPt1 a: wrpPt2 [
	^ self perpendicularBisector: wrpPt1 to: wrpPt2
]

{ #category : #'*DrGeo-French-point' }
DrGeoCanvas >> milieuDe: wrpSegment [
	^ self middleOf: wrpSegment 
]

{ #category : #'*DrGeo-French-point' }
DrGeoCanvas >> milieuDe: wrpPoint1 et: wrpPoint2 [
	^ self middleOf: wrpPoint1 and: wrpPoint2 
]

{ #category : #'*DrGeo-French-instance cretion' }
DrGeoCanvas class >> nouveau [
	^ self new
]

{ #category : #'*DrGeo-French-value' }
DrGeoCanvas >> ordonneeDe: wrpItem [
	^ self ordinateOf: wrpItem 
]

{ #category : #'*DrGeo-French-curve' }
DrGeoCanvas >> paralleleA: wrpDirection passantPar: wrpPtOrPoint [
	^ self parallel: wrpDirection at: wrpPtOrPoint
]

{ #category : #'*DrGeo-French-value' }
DrGeoCanvas >> penteDe: wrpLine [
	^ self slopeOf: wrpLine
]

{ #category : #'*DrGeo-French-curve' }
DrGeoCanvas >> perpendiculaireA: wrpDirection passantPar: wrpPtOrPoint [
	^ self perpendicular: wrpDirection at: wrpPtOrPoint
]

{ #category : #'*DrGeo-French-user interface' }
DrGeoCanvas >> pleinEcran [
	^ self fullscreen 
]

{ #category : #'*DrGeo-French-point' }
DrGeoCanvas >> pointSurCourbe: wrpCurve a: abscissa [
	^ self pointOnCurve: wrpCurve at: abscissa
]

{ #category : #'*DrGeo-French-curve filled' }
DrGeoCanvas >> polygone: collection [
	^ self polygon: collection
]

{ #category : #'*DrGeo-French-curve filled' }
DrGeoCanvas >> polygoneRegulierCentre: wrpCenter sommet: wrpVertex cotes: wrpValue [
	^ self regularPolygonCenter: wrpCenter vertex: wrpVertex sides: wrpValue
]

{ #category : #'*DrGeo-French-transformations' }
DrGeoCanvas >> rotationDe: wrpItem parCentre: wrpCenter etAngle: wrpValue [
	^ self rotate: wrpItem center: wrpCenter angle: wrpValue
]

{ #category : #'*DrGeo-French-curve finit' }
DrGeoCanvas >> segmentDe: wrpPt1 a: wrpPt2 [
	^ self segment: wrpPt1 to: wrpPt2 
]

{ #category : #'*DrGeo-French-transformations' }
DrGeoCanvas >> symetriqueDe: wrpItem selonAxe: wrpLine [
	^ self reflect: wrpItem axis: wrpLine
]

{ #category : #'*DrGeo-French-transformations' }
DrGeoCanvas >> symetriqueDe: wrpItem selonCentre: wrpCenter [
	^ self symmetry: wrpItem center: wrpCenter 
]

{ #category : #'*DrGeo-French-text' }
DrGeoCanvas >> texte: aText [
	^ self text: aText
]

{ #category : #'*DrGeo-French-text' }
DrGeoCanvas >> texte: aText a: aPosition [
	^ self text: aText at: aPosition
]

{ #category : #'*DrGeo-French-transformations' }
DrGeoCanvas >> translationDe: wrpItem parVecteur: wrpVecteur [
	^ self translate: wrpItem vector: wrpVecteur
]

{ #category : #'*DrGeo-French-value' }
DrGeoCanvas >> valeurLibre: aNumber [
	^ self freeValue: aNumber 
]

{ #category : #'*DrGeo-French-value' }
DrGeoCanvas >> valeurLibre: aNumber a: aPosition [
	^ self freeValue: aNumber at: aPosition
]

{ #category : #'*DrGeo-French-curve finit' }
DrGeoCanvas >> vecteur: wrpPt [
	^ self vector: wrpPt
]

{ #category : #'*DrGeo-French-curve finit' }
DrGeoCanvas >> vecteurOrigine: wrpPt1 extremite: wrpPt2 [
	^ self vector: wrpPt1 to: wrpPt2 
]
