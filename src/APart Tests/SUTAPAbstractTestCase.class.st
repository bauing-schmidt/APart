"
SUTAPxAbstractTestCase ist die Basisklasse für spezifische TestCases von Szenarien im Framework aPart. Subklassen sollten folgendem Namensschema folgen:

	SUT<part class name><test variant name>TC

<test variant name> steht hierbei für die Differenzierung der Varianten von Tests, sofern es mehrere Testklassen für denselben Client geben sollte.
Falls Tests für einzeln startbare Parts geschrieben werden sollen, kann auch mit einer Subklasse von SUTAPGenericSinglePartTC gearbeitet werden. Diese Klasse ermöglicht es, den zu testenden Part zu Beginn jedes Tests zu setzen, siehe Beispiele in SUTAPxGenericTC, in denen Tests für verschiedene APx*-Parts enthalten sind.

Client-Klassen für Unit-Tests sollten von APartUnitTestClient erben und folgendem Namensschema folgen:

	SUT<GUIClientClassName>

In den meisten Fällen wird es jedoch nicht nötig sein, eine spezielle Klasse für UnitTest-Clients zu implementieren. Stattdessen kann die folgende generische Klasse verwendet werden (siehe auch Referenzen darauf):

	APartGenericRecordingSUTClient

Für den Ablauf von Unit-Tests ist es in der Regel unerheblich, ob ein GUI-Client parallel zum UnitTestClient geöffnet ist. Anstatt Testmethoden komplett manuell zu schreiben, ist es jedoch sinnvoll, einmalig einen GUI-Client zusammen mit einem UnitTest-Client im Recorder-Modus zu starten und das Ergebnis des Recording als Code für die Testmethode zu verwenden. Ein so aufgenommener Testlauf kann anschließend mit oder ohne GUI-Client gestartet werden. Beispiel für das Recording: Siehe implementors von #openPartForRecording.
"
Class {
	#name : #SUTAPAbstractTestCase,
	#superclass : #SUTAPTestCase,
	#instVars : [
		'rootPartClass',
		'partStack',
		'utClientStack',
		'codePrinter',
		'log',
		'shallShowLog',
		'lastDate',
		'promptResultQueue'
	],
	#category : #'APart Tests'
}

{ #category : #'VisualWorks metadata' }
SUTAPAbstractTestCase class >> visualWorksMetadata [

	^ #(
		'superclassNamespace' 'XProgramming.SUnit'
	)

]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> afterDoing: testAction expectStates: statesBlock [

	self
		afterDoing: testAction
		expectStates: statesBlock
		expectValues: []
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> afterDoing: testAction expectStates: statesBlock expectValues: valuesBlock [

	| expectedStates |
	testAction value.
	"Nötig, falls keine Action ausgeführt, sondern nur Part-Setter aufgerufen wurden"
	self currentPart scopeUpdate.
	expectedStates := statesBlock value.
	(expectedStates findExpectationMismatchUsingClient: self currentUTClient)
		ifNotNil: [:diffText | self assert: false description: diffText].
	valuesBlock value
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> afterDoing: testAction expectStates: statesBlock log: descriptionString [

	self
		afterDoing: testAction
		expectStates: statesBlock
		expectValues: [].
	self logStep: descriptionString
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> callOperator: anOperator [

	anOperator operateOnPart: self currentPart testCase: self.
	self currentPart rootUpdate.
]

{ #category : #private }
SUTAPAbstractTestCase >> clientClass [
	"Default, damit keine Standardinitialisierung erfolgt"

	^nil
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> closePartAndClients [

	self assert: self currentPart partInterface requestForPartClose
		description: 'Closing failed'.
	self logStep: 'Closing part ' , self currentPart printString
]

{ #category : #announcements }
SUTAPAbstractTestCase >> continueWith: testContinuationKey afterExpectedStates: expectedStates [
]

{ #category : #private }
SUTAPAbstractTestCase >> createCodePrinter [

	^SUTAPInteractionPrinter on: (WriteStream on: String new) indent: 1
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> createGenericClientOnCurrentPart [

	| utc |
	utc := APartGenericRecordingSUTClient on: self currentPart partInterface
				useTest: self.
	utc partInterface updateAndAnnounceAll.
	^utc
]

{ #category : #'API code printing' }
SUTAPAbstractTestCase >> createStartInteraction [

	^APRecordedInteraction special: #printString
		value: 'self ' , #currentPart , ' ' , #openClient
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> currentPart [

	^partStack ifNotNil: [partStack last]
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> currentUTClient [

	^utClientStack last
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> execute: actionKey [

	| result |
	result := self currentPart execute: actionKey
		ifDisabled: 
			[self assert: false
				description: 'Trying to execute disabled action ' , actionKey printString].
	self logStep: 'Action ' , actionKey printString , ' finished'.
	^result
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> execute: actionKey preparing: preparationBlock [

	| result |
	preparationBlock value.
	self currentPart scopeUpdate.
	result := self currentPart execute: actionKey
		ifDisabled: 
			[self assert: false
				description: 'Trying to execute disabled action ' , actionKey printString].
	self logStep: 'Action ' , actionKey printString, ' finished'.
	^result.
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> execute: actionKey with: anArgument [

	| result |
	result := self currentPart
		execute: actionKey
		with: anArgument
		ifDisabled: 
			[self assert: false
				description: 'Trying to execute disabled action ' , actionKey printString].
	self
		logStep: 'Action ' , actionKey printString , ' with '
				, anArgument printString , ' finished'.
	^result.
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> execute: actionKey with: anArgument preparing: preparationBlock [

	| result |
	preparationBlock value.
	result := self currentPart
				execute: actionKey
				with: anArgument
				ifDisabled: 
					[self assert: false
						description: 'Trying to execute disabled action ' , actionKey printString].
	self
		logStep: 'Action ' , actionKey printString , ' with '
				, anArgument printString , ' finished'.
	^result
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> expectExtraAnnouncement: anAnnouncementTestBlock [

	self assert: self currentUTClient extraAnnouncementStack notEmpty
		description: 'Extra announcement stack is empty'.
	self assert: (anAnnouncementTestBlock
				value: self currentUTClient extraAnnouncementStack last)
		description: 'Announcement did not match expectation'.
	self currentUTClient extraAnnouncementStack removeLast
]

{ #category : #'API prompts' }
SUTAPAbstractTestCase >> fetchNextPromptResultCheckingAgainst: aPromptPart [

	| nextResult |
	nextResult := promptResultQueue removeFirst.
	nextResult promptKey = aPromptPart key
		ifFalse: 
			[self assert: false
				description: 'Prompt key mismatch in unit test: Got prompt with key: '
						, aPromptPart key printString , ', expected: '
						, nextResult promptKey printString].
	^nextResult
]

{ #category : #'API code printing' }
SUTAPAbstractTestCase >> finalizeRecordings [

	APartPlatform current clipboardText: (codePrinter ifNotNil: [codePrinter resultString] ifNil: ['codePrinter is nil']).
	codePrinter := nil
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> forTrigger: aTriggerKey prepare: preparationBlock [
	"Sofern zwei Aufrufe dieser Art in einem TestCase direkt hintereinander stehen, deutet das auf folgendes Problem hin:
	- Es wurde ein Trigger aufgerufen, der durch einen Prompt abgesichert ist. Der Prompt wurde nicht mit ok quittiert (Beispiel: Selektionswechsel).
		Deshalb fehlt zum #forTrigger:prepare: der nachfolgende #callOperator: (z.B. SUTAPOperatorSelectionChange).
	- Unmittelbar danach dem abgelehnten Trigger wurde erneut ein ähnlicher oder gleicher Aufruf versucht, diesmal jedoch mit ok quittiert.
		Der zum eigentlichen Trigger gehörige Operator-Aufruf (z.B. SUTAPOperatorSelectionChange) folgt daher direkt auf den zweiten #forTrigger:prepare.
		Intern wurde jedoch das erste vorbereitete (negative) Prompt-Ergebnis nicht verwertet, da hierfür kein Operator-Aufruf
		existierte. Von daher muss nun der SUTAPOperatorSelectionChange mit dem ersten Prompt-Resultat weiterarbeiten,
		was in den meisten Fällen zum Scheitern des Tests führen dürfte.
	Abhilfe: Testfälle vermeiden, in denen reine Trigger-Aktionen (wie z.B. Selektionswechsel in Listen) unmittelbar nacheinander
	zuerst per Prompt abgelehnt und dann erlaubt werden. Alternativ dazu kann auch der Testcode korrigiert werden, indem der
	erste von zwei direkt aufeinander folgenden Trigger-Aufrufen gelöscht wird.
	"

	preparationBlock value
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> inPrompt: aKey do: promptTestBlock [

	self preparePromptResult: ((APUnitTestPromptResult controllingFor: aKey)
				value: promptTestBlock;
				yourself)
]

{ #category : #'initialize-release' }
SUTAPAbstractTestCase >> initPartStackWith: aPart [

	partStack := OrderedCollection with: aPart
]

{ #category : #'initialize-release' }
SUTAPAbstractTestCase >> initUTClientStackWith: aClient [

	utClientStack := OrderedCollection with: aClient
]

{ #category : #'initialize-release' }
SUTAPAbstractTestCase >> initialize [

	super initialize.
	shallShowLog := true.
	lastDate := nil.
	log := WriteStream on: String new.
	promptResultQueue := OrderedCollection new.
	^self
]

{ #category : #private }
SUTAPAbstractTestCase >> isPartPushedTwice [

	partStack size > 1 ifFalse: [^false].
	^(partStack at: partStack size - 1) == partStack last
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> isRecording [

	^codePrinter notNil
]

{ #category : #private }
SUTAPAbstractTestCase >> lineEndString [

	^String with: Character cr
]

{ #category : #logging }
SUTAPAbstractTestCase >> logIndented: indentLevel step: descriptionText [

	| now nowDate |
	log isNil ifTrue: [^self].
	now := Timestamp now.
	nowDate := now asDate.
	(lastDate notNil and: [lastDate = nowDate])
		ifFalse: 
			[log nextPut: $[.
			now printOn: log.
			log
				nextPut: $];
				cr.
			lastDate := nowDate].
	self logLines: descriptionText indentedBy: indentLevel.
	log nextPutAll: ' ['.
	now printOn: log.
	log
		nextPut: $];
		cr
]

{ #category : #logging }
SUTAPAbstractTestCase >> logLines: aMultiLineString indentedBy: indentLevel [

	| lines |
	indentLevel = 0
		ifTrue: 
			[log nextPutAll: aMultiLineString.
			^self].
	lines := aMultiLineString tokensBasedOn: Character cr.
	lines do: 
			[:eachLine |
			indentLevel timesRepeat: [log tab].
			log nextPutAll: eachLine]
		separatedBy: [log cr]
]

{ #category : #logging }
SUTAPAbstractTestCase >> logStep: descriptionText [

	self logIndented: 0 step: descriptionText
]

{ #category : #private }
SUTAPAbstractTestCase >> methodHeaderForCurrentTest [

	^'test' , partStack first class name , self lineEndString
		, self lineEndString
]

{ #category : #'API prompts' }
SUTAPAbstractTestCase >> noticeExecutionOfTrigger: aTriggerKey forPrompt: aPromptPart weight: anInteger [

	| lastPromptResult s |
	lastPromptResult := APUnitTestPromptResult for: aPromptPart key
				whenClosedExecute: aTriggerKey.
	s := 'Prompt ' , aPromptPart key printString.
	aTriggerKey isNil
		ifTrue: 
			[aPromptPart isSimplePrompt
				ifTrue: [s := s , ' cancelled']
				ifFalse: [s := s , ' executed']]
		ifFalse: 
			[s := s , ' continued with: ' , aTriggerKey printString.
			lastPromptResult notNil
				ifTrue: 
					[aPromptPart value
						ifNotNil: 
							[:v |
							s := s , ' [value: ' , v printString , ']'.
							lastPromptResult value: v]]].
	self logIndented: 1 step: s.
	^lastPromptResult
]

{ #category : #running }
SUTAPAbstractTestCase >> openPartForRecording: aPartClass [

	rootPartClass := aPartClass.
	self
		setupRootPart;
		setupClient.
	self currentUTClient isRecording: true.
	self currentPart openClient
]

{ #category : #private }
SUTAPAbstractTestCase >> performTest [

	self logStep: '*** Starting ', testSelector, ' ***'.
	super performTest.
	self logStep: '*** Finished ' , testSelector , ' ***'.
]

{ #category : #'API prompts' }
SUTAPAbstractTestCase >> popPromptPart [

	self isPartPushedTwice ifFalse: [utClientStack removeLast].
	partStack removeLast
]

{ #category : #'API prompts' }
SUTAPAbstractTestCase >> preparePromptResult: aPromptResult [

	promptResultQueue add: aPromptResult
]

{ #category : #'API code printing' }
SUTAPAbstractTestCase >> printCodeForInteractions: interactionSequence [

	
	[| tailing |
	tailing := ''.
	(interactionSequence
		detect: [:ri | ri type = #special and: [ri key = #finishedClosing]]
		ifNone: [])
			ifNotNil: 
				[:closingIA |
				interactionSequence remove: closingIA.
				tailing := '	self ' , #closePartAndClients].
	codePrinter
		printCodeForInteractions: interactionSequence
		head: self methodHeaderForCurrentTest
		tail: tailing]
			on: Error
			do: 
				[:ex |
				codePrinter notNil ifTrue: [codePrinter printException: ex].
				ex return: true]
]

{ #category : #printing }
SUTAPAbstractTestCase >> printOn: s [

	testSelector notNil ifTrue: [^super printOn: s].
	s
		nextPutAll: 'a ';
		nextPutAll: self class printString
]

{ #category : #'API prompts' }
SUTAPAbstractTestCase >> pushPromptPart: aPart [

	partStack add: aPart.
	self isPartPushedTwice ifTrue: [^self].
	utClientStack add: self createGenericClientOnCurrentPart
]

{ #category : #private }
SUTAPAbstractTestCase >> rootPartClass [
	"Default nil, damit keine Standardinitialisierung erfolgt"

	^rootPartClass
]

{ #category : #'initialize-release' }
SUTAPAbstractTestCase >> rootPartClass: anObject [

	rootPartClass := anObject
]

{ #category : #'API testing' }
SUTAPAbstractTestCase >> setAspect: setterKey value: aValue [

	self
		logStep: 'Setting ' , setterKey printString , ': ' , aValue printString.
	(self currentPart partInterface description aspectFor: setterKey
		ifAbsent: 
			[self assert: false
				description: 'Undefined aspect: ' , setterKey printString])
			value: aValue
]

{ #category : #running }
SUTAPAbstractTestCase >> setUp [

	self initialize.
	self logStep: '*** Setup for ' , self class name , ' ***'.
	super setUp.
	self
		setupRootPart;
		setupClient
]

{ #category : #private }
SUTAPAbstractTestCase >> setupClient [

	| client |
	self clientClass
		ifNotNil: 
			[:cc |
			self currentPart
				ifNotNil: 
					[:currentPart |
					self initUTClientStackWith: (client := cc on: currentPart partInterface
										useTest: self)]].
	^client
]

{ #category : #private }
SUTAPAbstractTestCase >> setupRootPart [

	self setupRootPartPreInit: nil
]

{ #category : #private }
SUTAPAbstractTestCase >> setupRootPartPreInit: preInitBlock [

	self rootPartClass
		ifNotNil: [:rpc | self initPartStackWith: (rpc preInit: preInitBlock)]
]

{ #category : #logging }
SUTAPAbstractTestCase >> showLog [

	Transcript
		cr;
		show: log contents;
		cr
]

{ #category : #'API code printing' }
SUTAPAbstractTestCase >> startPrintingCode [

	codePrinter isNil ifTrue: [codePrinter := self createCodePrinter]
]

{ #category : #running }
SUTAPAbstractTestCase >> tearDown [

	lastDate := nil.
	super tearDown.
	shallShowLog ifTrue: [self showLog]
]

{ #category : #'API prompts' }
SUTAPAbstractTestCase >> weightForExecutingPrompt: aPromptPart [

	| matchingResultEntry |
	matchingResultEntry := promptResultQueue
				detect: [:pr | pr promptKey = aPromptPart key]
				ifNone: [^0].
	^matchingResultEntry isControlling ifTrue: [2] ifFalse: [0]
]

{ #category : #'API prompts' }
SUTAPAbstractTestCase >> with: aPart compute: aBlock [

	| resultValue |
	aBlock isNil ifTrue: [^nil].
	self pushPromptPart: aPart.
	resultValue := aBlock value.
	self popPromptPart.
	^resultValue
]
