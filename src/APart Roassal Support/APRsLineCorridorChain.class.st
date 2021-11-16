"
An instance of APRsLineCorridorChain defines a concrete chain of specific line corridor instances (APRsLineCorridor subclasses). See **API chain definition** for how to easily set up a specific chain.
"
Class {
	#name : #APRsLineCorridorChain,
	#superclass : #Object,
	#instVars : [
		'lineOrientationKey',
		'restrictToOutletEast',
		'startRect',
		'endRectEast',
		'endRectSouth',
		'cornerSpace',
		'firstCorridor',
		'chainDefinition'
	],
	#category : #'APart Roassal Support-Paths'
}

{ #category : #'instance creation' }
APRsLineCorridorChain class >> corridorsFor: aLineOrientationKey from: aStartRect toEast: anEndRectEast orSouth: anEndRectSouth cornerSpace: aCornerSpace restrictToOutletEast: shallRestrictToOutletEast [

	| chainComputer |
	chainComputer := self new
				initOn: aLineOrientationKey
				from: aStartRect
				toEast: anEndRectEast
				orSouth: anEndRectSouth
				cornerSpace: aCornerSpace.
	chainComputer restrictToOutletEast: shallRestrictToOutletEast.
	^chainComputer computeCorridors
]

{ #category : #'API chain' }
APRsLineCorridorChain >> bestPathFromPoint: startingPoint avoiding: rectsToAvoid [

	firstCorridor cutCorridorsAvoidingAll: rectsToAvoid adaptToPrevious: #().
	^firstCorridor bestPathFromPoint: startingPoint avoiding: rectsToAvoid
]

{ #category : #'API chain' }
APRsLineCorridorChain >> chainDo: aBlock [

	firstCorridor chainDo: aBlock
]

{ #category : #'API chain' }
APRsLineCorridorChain >> chainDo: aBlock separatedBy: separatorBlock [

	firstCorridor chainDo: aBlock separatedBy: separatorBlock
]

{ #category : #private }
APRsLineCorridorChain >> chainSelectorsForLineOrientationKey [ 
	| fullResult |
	
	fullResult := self perform: lineOrientationKey.
	restrictToOutletEast ifTrue: [ | southSelectors |
		southSelectors := self selectorsStartingFromSouth.
		"In this case we also do not accept east-south, because it enters destination from the top."
		fullResult := fullResult reject: [ :sel | sel = #goSouthEastByES or: [southSelectors includes: sel] ].
	].
	^fullResult 
]

{ #category : #'initialize-release' }
APRsLineCorridorChain >> computeCorridors [
	"Computation of corridors is done on instance side because the corridors are tied to startRect and endRects.
	In the result, each headCorridor is connected to all others of his chain."

	| result |
	result := OrderedCollection new.
	self chainSelectorsForLineOrientationKey do: [:chainDefinitionSelector | | headCorridor |
		chainDefinitionSelector ifNotNil: [ 
			headCorridor := self class new
				initOn: lineOrientationKey
				from: startRect
				toEast: endRectEast
				orSouth: endRectSouth
				cornerSpace: cornerSpace.
			headCorridor restrictToOutletEast: restrictToOutletEast.
			headCorridor defineChainFor: chainDefinitionSelector.
			result add: headCorridor ]
	].
	^result
]

{ #category : #'initialize-release' }
APRsLineCorridorChain >> defineChainFor: chainDefinitionSelector [

	chainDefinition := chainDefinitionSelector.
	self perform: chainDefinition
]

{ #category : #'API chain' }
APRsLineCorridorChain >> forcePathAvoiding: rectsToAvoid [

	^firstCorridor forcePathAvoiding: rectsToAvoid
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goEastByE [

	self startEastOf: startRect straightTo: endRectEast
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goEastByENES [

	self
		startEastOf: startRect width: cornerSpace;
		thenGoNorthTo: (endRectSouth top min: startRect top) - cornerSpace
					- cornerSpace
			width: cornerSpace;
		thenGoEastTo: endRectSouth right bottom: endRectSouth top;
		thenGoSouthTo: endRectSouth top left: endRectSouth left
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goEastBySENE [

	self
		startSouthOf: startRect
			bottom: startRect bottom + (cornerSpace + cornerSpace);
		thenGoEastTo: endRectEast left - cornerSpace half top: endRectEast bottom;
		thenGoNorthTo: endRectEast top left: endRectEast left - cornerSpace;
		thenGoEastTo: endRectEast left bottom: endRectEast bottom
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goNorthByENWNE [

	self
		startEastOf: startRect width: cornerSpace + cornerSpace half;
		thenGoNorthTo: endRectEast bottom width: cornerSpace + cornerSpace half;
		thenGoWestTo: endRectEast left - cornerSpace - cornerSpace
			bottom: endRectEast bottom + cornerSpace + cornerSpace half;
		thenGoNorthTo: endRectEast top width: cornerSpace + cornerSpace half;
		thenGoEastTo: endRectEast left bottom: endRectEast bottom
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goNorthBySWNE [

	self
		startSouthOf: startRect height: cornerSpace + cornerSpace half;
		thenGoWestTo: (endRectEast left min: startRect left) - cornerSpace - cornerSpace
			top: startRect bottom + cornerSpace half;
		thenGoNorthTo: endRectEast top width: cornerSpace + cornerSpace;
		thenGoEastTo: endRectEast left bottom: endRectEast bottom
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goNorthEastByENE1 [

	self
		startEastOf: startRect right: endRectEast left - cornerSpace half;
		thenGoNorthTo: endRectEast top left: startRect right + cornerSpace half;
		thenGoEastTo: endRectEast left bottom: endRectEast bottom
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goNorthEastByENE2 [

	self
		startEastOf: startRect width: cornerSpace;
		thenGoNorthTo: endRectEast top width: cornerSpace;
		thenGoEastTo: endRectEast left bottom: endRectEast bottom
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goNorthEastByENWNE [

	self
		startEastOf: startRect width: cornerSpace;
		thenGoNorthTo: endRectEast bottom width: cornerSpace;
		thenGoWestTo: endRectEast left - cornerSpace - cornerSpace
			bottom: endRectEast bottom + cornerSpace + cornerSpace half;
		thenGoNorthTo: endRectEast top width: cornerSpace;
		thenGoEastTo: endRectEast left bottom: endRectEast bottom
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goNorthWestByENWNE [

	self
		startEastOf: startRect width: cornerSpace + cornerSpace;
		thenGoNorthTo: endRectEast bottom width: cornerSpace + cornerSpace;
		thenGoWestTo: endRectEast left - cornerSpace - cornerSpace
			bottom: endRectEast bottom + cornerSpace + cornerSpace;
		thenGoNorthTo: endRectEast top width: cornerSpace + cornerSpace;
		thenGoEastTo: endRectEast left bottom: endRectEast bottom
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goNorthWestBySWNE [

	self
		startSouthOf: startRect height: cornerSpace + cornerSpace half;
		thenGoWestTo: endRectEast left - cornerSpace - cornerSpace
			top: startRect bottom + cornerSpace half;
		thenGoNorthTo: endRectEast top width: cornerSpace + cornerSpace half;
		thenGoEastTo: endRectEast left bottom: endRectEast bottom
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthByESWS [

	self
		startEastOf: startRect
			right: (startRect right max: endRectSouth right) + cornerSpace + cornerSpace;
		thenGoSouthTo: endRectSouth top - cornerSpace left: endRectSouth left + cornerSpace;
		thenGoWestTo: endRectSouth left
			top: endRectSouth top - cornerSpace - cornerSpace half;
		thenGoSouthTo: endRectSouth top right: endRectSouth right
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthByS [

	self startSouthOf: startRect straightTo: endRectSouth.
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthBySE [

	self
		startSouthOf: startRect bottom: endRectSouth bottom;
		thenGoEastTo: endRectSouth left top: endRectSouth top
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthBySES [

	self
		startSouthOf: startRect bottom: startRect bottom + cornerSpace + cornerSpace;
		thenGoEastTo: endRectSouth right height: cornerSpace;
		thenGoSouthTo: endRectSouth top left: endRectSouth left
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthBySESWS [

	self
		startSouthOf: startRect bottom: startRect bottom + cornerSpace + cornerSpace;
		thenGoEastTo: endRectSouth right + cornerSpace height: cornerSpace;
		thenGoSouthTo: endRectSouth top - cornerSpace left: endRectSouth left;
		thenGoWestTo: endRectSouth left
			top: endRectSouth top - cornerSpace - cornerSpace;
		thenGoSouthTo: endRectSouth top right: endRectSouth right.
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthBySWS [

	self
		startSouthOf: startRect bottom: endRectEast top - cornerSpace half;
		thenGoWestTo: endRectEast left - cornerSpace top: startRect bottom + cornerSpace half;
		thenGoSouthTo: endRectEast bottom right: endRectEast left - cornerSpace
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthBySWSE [

	self
		startSouthOf: startRect bottom: endRectEast top - cornerSpace half;
		thenGoWestTo: endRectEast left - endRectEast width half
			top: startRect bottom + cornerSpace half;
		thenGoSouthTo: endRectEast bottom right: endRectEast left - cornerSpace;
		thenGoEastTo: endRectEast left top: endRectEast top.

]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthEastByES [

	self
		startEastOf: startRect right: endRectSouth right;
		thenGoSouthTo: endRectSouth top left: endRectSouth left.
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthEastByESE [
	self
		startEastOf: startRect right: endRectEast left - cornerSpace half;
		thenGoSouthTo: endRectSouth bottom left: startRect right + cornerSpace half;
		thenGoEastTo: endRectSouth left top: endRectEast top
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthEastBySE [

	self
		startSouthOf: startRect bottom: endRectEast bottom;
		thenGoEastTo: endRectEast left top: endRectEast top
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthEastBySENE [

	self
		startSouthOf: startRect bottom: startRect bottom + (cornerSpace * 5);
		thenGoEastTo: endRectEast left - cornerSpace top: endRectEast top;
		thenGoNorthTo: endRectEast top width: cornerSpace * 2;
		thenGoEastTo: endRectEast left bottom: endRectEast bottom
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthEastBySES [

	self
		startSouthOf: startRect bottom: endRectSouth top - cornerSpace;
		thenGoEastTo: endRectSouth right top: startRect bottom + cornerSpace;
		thenGoSouthTo: endRectSouth top left: endRectSouth left
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthWestBySWNE [

	self
		startSouthOf: startRect bottom: endRectEast bottom + cornerSpace + cornerSpace;
		thenGoWestTo: endRectEast left - cornerSpace - cornerSpace height: cornerSpace + cornerSpace half;
		thenGoNorthTo: endRectEast top right: endRectEast left - cornerSpace;
		thenGoEastTo: endRectEast left height: endRectEast height
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthWestBySWS [
	| maxWestCorridorHeight |
	
	maxWestCorridorHeight := 0 max: endRectEast top - cornerSpace - cornerSpace - startRect bottom.
	self
		startSouthOf: startRect height: maxWestCorridorHeight;
		thenGoWestTo: endRectSouth left height: maxWestCorridorHeight;
		thenGoSouthTo: endRectSouth top right: endRectSouth right
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goSouthWestBySWSE [

	| maxWestCorridorHeight |
	maxWestCorridorHeight := 0 max: endRectEast top - cornerSpace - cornerSpace - startRect bottom.
	self
		startSouthOf: startRect height: maxWestCorridorHeight;
		thenGoWestTo: endRectEast left - (cornerSpace * 3) height: maxWestCorridorHeight;
		thenGoSouthTo: endRectEast bottom right: endRectEast left - cornerSpace;
		thenGoEastTo: endRectEast left top: endRectEast top
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goWestByENWS [

	self
		startEastOf: startRect width: cornerSpace + cornerSpace;
		thenGoNorthTo: (startRect top min: endRectSouth top) - cornerSpace - cornerSpace
			left: startRect right;
		thenGoWestTo: endRectSouth left bottom: endRectSouth top - cornerSpace;
		thenGoSouthTo: endRectSouth top right: endRectSouth right.
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goWestByENWSE [

	self
		startEastOf: startRect width: cornerSpace + cornerSpace;
		thenGoNorthTo: (startRect top min: endRectEast top) - (cornerSpace * 3)
			left: startRect right;
		thenGoWestTo: endRectEast left - (cornerSpace * 3) bottom: endRectEast top;
		thenGoSouthTo: endRectEast bottom right: endRectEast left - cornerSpace;
		thenGoEastTo: endRectEast left top: endRectEast top
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> goWestBySWNE [

	self
		startSouthOf: startRect
			bottom: cornerSpace + cornerSpace + (startRect bottom max: endRectEast bottom);
		thenGoWestTo: endRectEast left - endRectEast width half
			top: (startRect bottom max: endRectEast bottom);
		thenGoNorthTo: endRectEast top right: endRectEast left - cornerSpace;
		thenGoEastTo: endRectEast left bottom: endRectEast bottom
]

{ #category : #'initialize-release' }
APRsLineCorridorChain >> initOn: aLineOrientationKey from: aStartRect toEast: anEndRectEast orSouth: anEndRectSouth cornerSpace: aCornerSpace [

	lineOrientationKey := aLineOrientationKey.
	startRect := aStartRect.
	endRectEast := anEndRectEast.
	endRectSouth := anEndRectSouth.
	cornerSpace := aCornerSpace
]

{ #category : #'initialize-release' }
APRsLineCorridorChain >> initialize [ 
	restrictToOutletEast := false
]

{ #category : #private }
APRsLineCorridorChain >> lastCorridor [

	^firstCorridor lastCorridor

]

{ #category : #'API directions' }
APRsLineCorridorChain >> lineOrientationEast [

	| secondTry |
	secondTry := endRectEast bottom < startRect center y
		ifTrue: [ #goNorthEastByENE1 ]
		ifFalse: [ #goSouthEastByESE ].
	^{ #goEastByE . secondTry . #goEastBySENE . #goEastByENES }
]

{ #category : #'API directions' }
APRsLineCorridorChain >> lineOrientationNorth [

	^#(#goNorthBySWNE #goNorthByENWNE)
]

{ #category : #'API directions' }
APRsLineCorridorChain >> lineOrientationNorthEast [

	^endRectEast left - startRect right > cornerSpace
		ifTrue: [#(#goNorthEastByENE1 #goNorthEastByENE2)]
		ifFalse: 
			[startRect top - cornerSpace > endRectEast bottom
				ifTrue: [#(#goNorthEastByENWNE)]
				ifFalse: [#(#goNorthEastByENE1)]]
]

{ #category : #'API directions' }
APRsLineCorridorChain >> lineOrientationNorthWest [

	^#(#goNorthWestBySWNE #goNorthWestByENWNE)
]

{ #category : #'API directions' }
APRsLineCorridorChain >> lineOrientationSouth [

	| definitionSet |
	definitionSet := #(#goSouthByS #goSouthBySE #goSouthBySES #goSouthBySWS #goSouthBySWSE #goSouthBySESWS #goSouthByESWS)
				copy.
	startRect right + (cornerSpace * 1.5) > endRectEast right
		ifTrue: 
			[definitionSet at: 2 put: nil.
			definitionSet at: 4 put: nil].
	^definitionSet
]

{ #category : #'API directions' }
APRsLineCorridorChain >> lineOrientationSouthEast [

	^endRectEast top - startRect bottom > (cornerSpace * 2)
		ifTrue: [#(#goSouthEastBySE #goSouthEastByES #goSouthEastByESE  #goSouthEastBySES)]
		ifFalse: [#(#goSouthEastBySE #goSouthEastByES #goSouthEastByESE #goSouthEastBySENE)]
]

{ #category : #'API directions' }
APRsLineCorridorChain >> lineOrientationSouthWest [

	^#(#goSouthWestBySWS #goSouthWestBySWSE #goSouthWestBySWNE)
]

{ #category : #'API directions' }
APRsLineCorridorChain >> lineOrientationWest [

	^#(#goWestBySWNE #goWestByENWS #goWestByENWSE)
]

{ #category : #printing }
APRsLineCorridorChain >> printOn: s [

	super printOn: s.
	lineOrientationKey notNil
		ifTrue: 
			[s
				nextPut: $[;
				nextPutAll: lineOrientationKey printString;
				nextPut: $]].
	chainDefinition notNil
		ifTrue: 
			[s
				nextPut: ${;
				nextPutAll: chainDefinition printString;
				nextPut: $}.
			^self].
	firstCorridor notNil ifTrue: [firstCorridor printDetailsOn: s]
]

{ #category : #accessing }
APRsLineCorridorChain >> restrictToOutletEast [
	^ restrictToOutletEast
]

{ #category : #accessing }
APRsLineCorridorChain >> restrictToOutletEast: anObject [
	restrictToOutletEast := anObject
]

{ #category : #'API chain definition' }
APRsLineCorridorChain >> selectorsStartingFromSouth [
	"Names are sorted to start with east and south selectors to be avoided because of setting requiring always to start from east position, thus always excluding south positions"
	
^	#(#goEastBySENE #goSouthByS #goSouthBySE #goSouthBySES #goSouthBySESWS #goSouthBySWS #goSouthBySWSE #goSouthEastBySE #goSouthEastBySENE #goSouthEastBySES #goSouthEastBySES #goSouthWestBySWS #goSouthWestBySWS #goWestBySWNE #goNorthBySWNE #goNorthWestBySWNE 
)
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> startEastOf: refRect right: x [

	firstCorridor := APRsLineCorridorEast
				withArea: (refRect right @ refRect top corner: x @ refRect bottom)
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> startEastOf: refRect straightTo: targetRect [
	"If we restrict to outlet east, we also force straight lines to start at vertical center point."
	
	| topRefToUse bottomRefToUse yTop yBottom |
	restrictToOutletEast ifTrue: [ 
		topRefToUse := (refRect top midpoint: refRect bottom) - (1/2).
		bottomRefToUse := topRefToUse + 1.
	] ifFalse: [
		topRefToUse := refRect top.
		bottomRefToUse := refRect bottom.
	].
	yTop := topRefToUse max: targetRect top + 1.
	"Avoid getting bottom smaller than top, because this would create a swapped rect of height > 0 which would be wrong"
	yBottom := (bottomRefToUse min: targetRect bottom - 1) max: yTop.
	
	firstCorridor := APRsLineCorridorEast withArea: (
		refRect right @ yTop corner: targetRect left @ yBottom
	)
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> startEastOf: refRect width: w [

	self startEastOf: refRect right: refRect right + w
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> startSouthOf: refRect bottom: y [

	firstCorridor := (APRsLineCorridorSouth
				withArea: (refRect left @ refRect bottom corner: refRect right @ y))
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> startSouthOf: refRect height: h [

	self startSouthOf: refRect bottom: refRect bottom + h
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> startSouthOf: refRect straightTo: targetRect [

	firstCorridor := (APRsLineCorridorSouth
				withArea: ((refRect left max: targetRect left) @ refRect bottom
						corner: (refRect right min: targetRect right) @ targetRect top))
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoEastTo: x bottom: y [

	self lastCorridor goEastTo: x bottom: y
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoEastTo: x height: h [

	self lastCorridor goEastTo: x height: h
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoEastTo: x top: y [

	self lastCorridor goEastTo: x top: y
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoNorthTo: y left: x [

	self lastCorridor goNorthTo: y left: x
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoNorthTo: y right: x [

	self lastCorridor goNorthTo: y right: x
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoNorthTo: y width: w [

	self lastCorridor goNorthTo: y width: w
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoSouthTo: y left: x [

	self lastCorridor goSouthTo: y left: x
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoSouthTo: y right: x [

	self lastCorridor goSouthTo: y right: x
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoSouthTo: y width: w [

	self lastCorridor goSouthTo: y width: w
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoWestTo: x bottom: y [

	self lastCorridor goWestTo: x bottom: y
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoWestTo: x height: h [

	self lastCorridor goWestTo: x height: h
]

{ #category : #'API corridor steps' }
APRsLineCorridorChain >> thenGoWestTo: x top: y [

	self lastCorridor goWestTo: x top: y
]

{ #category : #printing }
APRsLineCorridorChain >> title [

	^firstCorridor ifNotNil: [firstCorridor title] ifNil: ['']
]
