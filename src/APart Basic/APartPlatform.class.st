"
nativeValueHolderFor: anObject

	self subclassResponsibility 
"
Class {
	#name : #APartPlatform,
	#superclass : #Object,
	#classVars : [
		'Current'
	],
	#category : #'APart Basic-Platform'
}

{ #category : #accessing }
APartPlatform class >> current [
	^ Current ifNil: [ Current := self detectPlatform ]
]

{ #category : #accessing }
APartPlatform class >> detectPlatform [
	| matches mostSpecific |
	matches := self allSubclasses 
		select: [ :class | class isResponsibleForCurrentPlatform ].
	mostSpecific := matches first.
	matches do: [ :class |
		class allSubclasses size < mostSpecific allSubclasses size ifTrue: [
			mostSpecific := class ] ].
	
	^ mostSpecific new
]

{ #category : #accessing }
APartPlatform class >> isResponsibleForCurrentPlatform [
	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
APartPlatform >> allPragmasNamed: aSymbol under: parentClass [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> associationClassForDialogs [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> chooseFromList: newList values: newListValues part: aPartDialog label: aLabel messageString: messageString [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> chooseManyFromList: newList values: newListValues part: aPartDialog label: aLabel messageString: messageString [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> chooseReport: messageString labels: labels values: values default: defaultValue equalize: eqBoolean for: aVisualOrNil dialog: aPartDialog [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> closeAndUnschedule: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> computeSpecForConfiguration: clientConfiguration specKey: specKey in: anApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> containerChanging: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> handleDefaultAnnouncedState: anAnnouncedState in: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> installDoubleClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> installFocusInActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> installItemExpandedActionFrom: anInterface forTreeViewKey: aTreeViewKey in: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> installRequestSelectionChangedActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> installRightClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> interfaceFocusRequest: anAnnouncement from: anInterface in: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> itemStringRepresentationBlock: isrb itemIconRepresentationBlock: iirb forListViewKey: aListViewKey in: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> message: messageString wLabel: wLabel dialog: aPartDialog [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> multipleChoice: messageString labels: labelArray values: valueArray default: defaultValue wLabel: wLabel dialog: aDialog [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
APartPlatform >> nativeValueHolderFrom: anObject [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> numberInputFrom: anObject [

	"used for processing of inputs from number input fields"

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
APartPlatform >> openClientFor: aPart [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> openModal: aClass onPart: aPromptPart parentClient: aParentClient [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> ownerWindowOf: aGUIElement [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> postBuildTreeKey: aTreeViewKey in: aView interface: interface builder: anAspectBuilder [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> questionYesNo: messageString wLabel: wLabel labelYes: aYesLabel labelNo: aNoLabel dialog: aPartDialog [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> request: messageString initialAnswer: initialAnswer wLabel: wLabel dialog: aPartDialog [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> requestColorValue: aPromptPart [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> requestExistingFilename: aPromptPart [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
APartPlatform >> requestNewFilename: aPromptPart [

	<ignoreForCoverage>
	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> setSubView: aSubView inSubCanvas: aSubCanvasKey in: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> setSubView: aSubView spec: aSpecSymbol inSubCanvas: aSubCanvasKey in: aPartApplicationModel [

	<ignoreForCoverage>
	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> subViewOn: aParentView from: aClass [

	<ignoreForCoverage>
	self subclassResponsibility 
]
