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
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
APartPlatform >> allPragmasNamed: aSymbol under: parentClass [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> associationClassForDialogs [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> chooseFromList: newList values: newListValues part: aPartDialog label: aLabel messageString: messageString [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> chooseManyFromList: newList values: newListValues part: aPartDialog label: aLabel messageString: messageString [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> chooseReport: messageString labels: labels values: values default: defaultValue equalize: eqBoolean for: aVisualOrNil dialog: aPartDialog [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> closeAndUnschedule: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> computeSpecForConfiguration: clientConfiguration specKey: specKey in: anApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> containerChanging: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> handleDefaultAnnouncedState: anAnnouncedState in: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> installDoubleClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> installFocusInActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> installItemExpandedActionFrom: anInterface forTreeViewKey: aTreeViewKey in: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> installRequestSelectionChangedActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> installRightClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> interfaceFocusRequest: anAnnouncement from: anInterface in: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> itemStringRepresentationBlock: isrb itemIconRepresentationBlock: iirb forListViewKey: aListViewKey in: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> message: messageString wLabel: wLabel dialog: aPartDialog [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> multipleChoice: messageString labels: labelArray values: valueArray default: defaultValue wLabel: wLabel dialog: aDialog [

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
APartPlatform >> nativeValueHolderFrom: anObject [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> numberInputFrom: anObject [

	"used for processing of inputs from number input fields"

	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
APartPlatform >> openClientFor: aPart [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> openModal: aClass onPart: aPromptPart parentClient: aParentClient [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> ownerWindowOf: aGUIElement [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> postBuildTreeKey: aTreeViewKey in: aView interface: interface builder: anAspectBuilder [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> questionYesNo: messageString wLabel: wLabel labelYes: aYesLabel labelNo: aNoLabel dialog: aPartDialog [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> request: messageString initialAnswer: initialAnswer wLabel: wLabel dialog: aPartDialog [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> requestColorValue: aPromptPart [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> requestExistingFilename: aPromptPart [

	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
APartPlatform >> requestNewFilename: aPromptPart [

	self subclassResponsibility 
]

{ #category : #accessing }
APartPlatform >> setSubView: aSubView inSubCanvas: aSubCanvasKey in: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> setSubView: aSubView spec: aSpecSymbol inSubCanvas: aSubCanvasKey in: aPartApplicationModel [

	self subclassResponsibility
]

{ #category : #accessing }
APartPlatform >> subViewOn: aParentView from: aClass [

	self subclassResponsibility 
]
