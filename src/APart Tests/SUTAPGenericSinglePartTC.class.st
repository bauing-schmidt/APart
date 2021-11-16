"
SUTAPGenericSinglePartTC ist die Basisklasse für generische TestCase-Implementationen. Generisch ist hierbei die Verknüpfung zwischen Test-Methode und Klasse des Root-Parts, der getestet wird (siehe #findRootPartClass). Die nötigen Initialisierungen von part und utClient werden jeweils beim #performTest automatisch durchgeführt.
"
Class {
	#name : #SUTAPGenericSinglePartTC,
	#superclass : #SUTAPAbstractTestCase,
	#category : #'APart Tests'
}

{ #category : #utilities }
SUTAPGenericSinglePartTC class >> choosePartClass [
	"self choosePartClass"

	^self choosePartClassUnder: APartExample
]

{ #category : #utilities }
SUTAPGenericSinglePartTC class >> choosePartClassUnder: aSuperclass [
	"self choosePartClassUnder: APartExample"

	| rootPart |
	rootPart := APartOnTheFly createWithClientRegistry.
	rootPart partInterface createAction: #selectPartClass
		do: 
			[(APConfirmationEnumValue onPart: rootPart)
				genericEnumeration: ((APEnumeration create)
							addAllEntriesForKeys: (aSuperclass allSubclasses collect: [:c | c name])
										asSortedCollection;
							textFromKeyBlock: [:k | k asString];
							yourself);
				title: #ChoosePartClass;
				message: #ChoosePartClassForUnitTestRecording;
				trigger: #confirmChoice
					withPartDo: [:promptPart | rootPart propertyAt: #selectedPartClass put: promptPart value];
				trigger: #cancelChoice
					withPartDo: [rootPart propertyAt: #selectedPartClass put: nil];
				openClientPrompt].
	rootPart execute: #selectPartClass ifDisabled: [].
	^(rootPart propertyAt: #selectedPartClass)
		ifNotNil: [:cName | Smalltalk at: cName]
]

{ #category : #utilities }
SUTAPGenericSinglePartTC class >> openPartForRecording [
	"self openPartForRecording"

	self openPartForRecordingUnder: APartExample
]

{ #category : #utilities }
SUTAPGenericSinglePartTC class >> openPartForRecordingUnder: partSuperclass [
	"self openPartForRecordingUnder: APartExample"

	(self choosePartClassUnder: partSuperclass)
		ifNotNil: [:partClass | 
			self new openPartForRecording: partClass]
]

{ #category : #private }
SUTAPGenericSinglePartTC >> clientClass [

	^APartGenericRecordingSUTClient
]

{ #category : #private }
SUTAPGenericSinglePartTC >> createPartAndClientFor: aPartClass [

	rootPartClass := aPartClass.
	self
		setupRootPart;
		setupClient
]

{ #category : #private }
SUTAPGenericSinglePartTC >> createPartAndClientFor: aPartClass preInit: preInitBlock [

	rootPartClass := aPartClass.
	self setupRootPartPreInit: preInitBlock.
	^self setupClient
]

{ #category : #private }
SUTAPGenericSinglePartTC >> findRootPartClass [
	"Kann in speziellen Subklassen überdefiniert werden"

	^nil
]

{ #category : #private }
SUTAPGenericSinglePartTC >> methodHeaderForCurrentTest [

	^super methodHeaderForCurrentTest , '	self createPartAndClientFor: '
		, self currentPart class name , '.'
		, self lineEndString
]

{ #category : #private }
SUTAPGenericSinglePartTC >> performTest [
	"If a rootPartClass is already set, it will be preserved. Otherwise, it is expected to be placed at the beginning of the #test*-method.
In this case, the class is reset at the end of the test run."

	| shallClearPartClass |
	shallClearPartClass := false.
	partStack size = 0
		ifTrue: 
			[rootPartClass isNil
				ifTrue: 
					[shallClearPartClass := true.
					rootPartClass := self findRootPartClass].
			rootPartClass notNil
				ifTrue: 
					[self
						setupRootPart;
						setupClient]].
	super performTest.
	shallClearPartClass ifTrue: [rootPartClass := nil]
]

{ #category : #running }
SUTAPGenericSinglePartTC >> tearDown [

	super tearDown.
"	testSelector := nil."
	utClientStack notNil
		ifTrue: [self currentUTClient isRecording ifFalse: [utClientStack := nil]].
	partStack := nil
]
