"
APartValueAdaptor replaces the use of a PluggableAdaptor in the simpleAspects of the APartInterface.
This class avoids the #changedAspectValue: messages coming from the part within a #value: call that cause duplicate updates on dependencies of the active instance.

--

DE:APartValueAdaptor ersetzt den Gebrauch eines PluggableAdaptors in den simpleAspects des APartInterface.
In dieser Klasse wird vermieden, dass innerhalb eines #value:-Aufrufs die vom Part kommenden #changedAspectValue:-Nachrichten zu doppelten updates bei Dependents der aktiven Instanz führen.
"
Class {
	#name : #APValueAdaptor,
	#superclass : #APModelWithValue,
	#instVars : [
		'part',
		'aspectKey',
		'shallIgnoreChanges',
		'validationBlock'
	],
	#category : #'APart Basic-Core'
}

{ #category : #'instance creation' }
APValueAdaptor class >> on: aPart key: anAspectKey [

	^self new initOn: aPart key: anAspectKey
]

{ #category : #'VisualWorks metadata' }
APValueAdaptor class >> visualWorksMetadata [

	^ #(
		'superclassNamespace' 'UI'
	)

]

{ #category : #accessing }
APValueAdaptor >> aspectKey [

	^aspectKey
]

{ #category : #changing }
APValueAdaptor >> changed: anAspectSymbol [

	shallIgnoreChanges ifTrue: [^self].
	super changed: anAspectSymbol
]

{ #category : #changing }
APValueAdaptor >> changedWithoutIngoring: anAspectSymbol [

	super changed: anAspectSymbol
]

{ #category : #private }
APValueAdaptor >> ignoreChangesWhile: aBlock [

	shallIgnoreChanges := true.
	aBlock ensure: [shallIgnoreChanges := false]
]

{ #category : #'initialize-release' }
APValueAdaptor >> initOn: aPart key: anAspectKey [

	self initialize.
	part := aPart.
	aspectKey := anAspectKey
]

{ #category : #'initialize-release' }
APValueAdaptor >> initialize [

	super initialize.
	shallIgnoreChanges := false
]

{ #category : #testing }
APValueAdaptor >> isAPValueAdaptor [

	^ true
]

{ #category : #accessing }
APValueAdaptor >> model [

	^part
]

{ #category : #accessing }
APValueAdaptor >> noticeInvalidValue [

	part noticeInvalidValueForAspect: aspectKey
]

{ #category : #printing }
APValueAdaptor >> printOn: s [

	super printOn: s.
	aspectKey notNil
		ifTrue: 
			[s
				nextPut: $(;
				nextPutAll: aspectKey printString;
				nextPut: $)]
]

{ #category : #'Dataset API' }
APValueAdaptor >> renderingValueUsingSubject: aSubject [
	"Die Methode wird nur von der DataSetColum genutzt, um alle Rows des DataSet darzustellen, ohne jedoch jede Row einzeln zu selektieren."

	^self valueUsingSubject: aSubject
]

{ #category : #accessing }
APValueAdaptor >> reworkAspectAdaptor: anAspectAdaptor [

	^part ifNotNil: [part reworkAspectAdaptor: anAspectAdaptor]
]

{ #category : #accessing }
APValueAdaptor >> setValue: newValue [

	(part mayCallSetterFor: aspectKey)
		ifTrue: [part aPartPerform: aspectKey with: newValue]
]

{ #category : #accessing }
APValueAdaptor >> setValueWithoutConditionCheck: newValue [

	part aPartPerform: aspectKey with: newValue
]

{ #category : #accessing }
APValueAdaptor >> shallIgnoreChanges [ 
	
	^ shallIgnoreChanges
]

{ #category : #'Dataset API' }
APValueAdaptor >> subject [

	^part
]

{ #category : #'Dataset API' }
APValueAdaptor >> subject: aSubject [
	"The method is only used by the DataSetColum when opening a CellEditor.
Since the row is already selected for changes anyway, the whole works without an action. "
	"DE:Die Methode wird nur von der DataSetColum genutzt, wenn ein CellEditor geöffnet wird.
	Da für Änderungen die Row sowieso schon selektiert ist, funktioniert das ganze auch ohne eine Aktion."
]

{ #category : #accessing }
APValueAdaptor >> subjectChannel [ 
	
	^ self
]

{ #category : #updating }
APValueAdaptor >> update: anAspect with: parameter from: sender [
	"Propagate change if the sender is the receiver's subject and anAspect is the receiver's aspect."

	(sender subject == self subject and: [anAspect = #value])
		ifTrue: [dependents update: #value with: parameter from: self]
		ifFalse: [super update: anAspect with: parameter from: sender]
]

{ #category : #changing }
APValueAdaptor >> validate: newValue [

	^validationBlock value: newValue
]

{ #category : #accessing }
APValueAdaptor >> validationBlock [

	^validationBlock
]

{ #category : #accessing }
APValueAdaptor >> validationBlock: aOneArgBlock [
	"Usually reached by call from APart>>at:validate:.
	aOneArgBlock will be called with the new value directly fetched from the editor widget (might be nil if edit string cannot be converted to value).
	Execution of block must yield a Boolean.
	validationBlock is executed when #validate: is called for this aspect, typically originating directly from the GUI. Look for implementations sending #validate: and
	furthermore for senders of the selector of those implementations to find out what to do on the GUI side to call validations."

	validationBlock := aOneArgBlock
]

{ #category : #accessing }
APValueAdaptor >> value [

	^part aPartPerform: aspectKey
]

{ #category : #accessing }
APValueAdaptor >> value: newValue [

	"prevent repeated updates"
	shallIgnoreChanges ifTrue: [^self].
	
	self ignoreChangesWhile: [
		self setValue: newValue.
		"use super call to avoid 'ignoreChanges' check"
		super changed: #value].
]

{ #category : #accessing }
APValueAdaptor >> valueUsingSubject: aSubject [
	"The method is only used by the DataSetColum."

	aSubject == nil ifTrue: [^nil].
	^part == aSubject
		ifTrue: [self value]
		ifFalse: [super valueUsingSubject: aSubject]
]

{ #category : #accessing }
APValueAdaptor >> valueWithoutConditionCheck: newValue [

	self ignoreChangesWhile: [self setValueWithoutConditionCheck: newValue].
	self changed: #value
]
