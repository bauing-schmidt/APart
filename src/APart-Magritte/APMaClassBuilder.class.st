"
desc := MAContainer new.
desc add: (MAStringDescription new
	aspect: (MAAspectAccessor new aspectName: 'textInputField1');
	yourself).

b := APMaClassBuilder new.
b name: #APMaTest.
b packageName: 'Apart-Magritte'.
b build.
b visit: desc.

"
Class {
	#name : #APMaClassBuilder,
	#superclass : #MAVisitor,
	#instVars : [
		'name',
		'packageName',
		'aspects',
		'builtClass',
		'ivars',
		'environment',
		'initializers'
	],
	#category : #'Apart-Magritte'
}

{ #category : #example }
APMaClassBuilder class >> defaultDescription [ 

	| desc |

	desc := MAPriorityContainer new.
	desc add: (MAStringDescription new
		label: 'label text 1';
		aspect: (MAAspectAccessor new aspectName: 'text1');
		default: 'default text';
		password: true;
		yourself).
	desc add: (MAStringDescription new
		aspect: (MAAspectAccessor new aspectName: 'text2');
		label: 'label text 2';
		placeholder: 'some placeholder';
		yourself).
	desc add: (MABooleanDescription new
		aspect: (MAAspectAccessor new aspectName: 'boolean1');
		default: true;
		label: 'label boolean';
		yourself).	
	desc add: (	
		MASingleOptionDescription  new
			aspect: (MAAspectAccessor new aspectName: 'singleOption');
			label: 'label single option';
			"reference: MAStringDescription new;"
			options: MAAccessor allSubclasses;
			priority: 200;
			yourself).
	desc add: (	
		MAMultipleOptionDescription  new
			aspect: (MAAspectAccessor new aspectName: 'multipleOptions');
			label: 'label multiple options';
			"reference: MAStringDescription new;"
			options: MAAccessor allSubclasses;
			priority: 200;
			yourself).
	desc add: (	
		MAToOneRelationDescription new
			aspect: (MAAspectAccessor new aspectName: 'toOne');
			label: 'label to one';
			"reference: MAStringDescription new;"
			classes: MAAccessor allSubclasses;
			priority: 200;
			yourself).

	^ desc
]

{ #category : #example }
APMaClassBuilder class >> example [ 

	<script>
	
	| desc b editorPart visitor app presenter json previewPart |
	
	desc := self defaultDescription.

	b := APMaClassBuilder new.
	b name: #APMaTest.
	b packageName: 'Apart-Magritte'.
	b buildClass.
	b visit: desc.
	b apply.

	editorPart := ApedFormEditorPart createWithClientRegistry.

	visitor := ApedMAVisitor new.
	visitor editor: editorPart.
	visitor visit: desc.

	app := APartSpecApplication new.
	app useBackend: #Gtk with: ApartGtkConfiguration new.
	editorPart locale: APartLocaleDeDE new.
	presenter := ApedFormEditor openOnPart: editorPart application: app.

	json := editorPart form printJson.

	previewPart := APMaTest createWithClientRegistry.
	previewPart loadFormFrom: json readStream.
	APartFormPresenter openOnPart: previewPart application: app.

]

{ #category : #example }
APMaClassBuilder class >> example2 [ 

	<script>
	
	| desc b editorPart visitor app presenter json previewPart aClass |
	
	aClass := APMaTest.
	desc := APMaTest basicNew magritteDescription.

	b := APMaClassBuilder new.
	b existingClass: APMaTest.
	b buildClass.
	b visit: desc.
	b apply.

	editorPart := ApedFormEditorPart createWithClientRegistry.

	visitor := ApedMAVisitor new.
	visitor editor: editorPart.
	visitor visit: desc.

	app := APartSpecApplication new.
	app useBackend: #Gtk with: ApartGtkConfiguration new.
	editorPart locale: APartLocaleDeDE new.
	presenter := ApedFormEditor openOnPart: editorPart application: app.

	json := editorPart form printJson.

	previewPart := APMaTest createWithClientRegistry.
	previewPart loadFormFrom: json readStream.
	APartFormPresenter openOnPart: previewPart application: app.

]

{ #category : #example }
APMaClassBuilder class >> exampleGenerationPlusLayout [

	"class generation + layout"

	<script>
	
	| desc b editorPart visitor app presenter  |

	desc := self defaultDescription.

	b := APMaClassBuilder new.
	b name: #APMaTest.
	b packageName: 'Apart-Magritte'.
	b buildClass.
	b visit: desc.
	b apply.

	editorPart := ApedFormEditorPart createWithClientRegistry.

	visitor := ApedMAVisitor new.
	visitor editor: editorPart.
	visitor visit: desc.

	app := APartSpecApplication new.
	app useBackend: #Gtk with: ApartGtkConfiguration new.
	editorPart locale: APartLocaleDeDE new.
	presenter := ApedFormEditor openOnPart: editorPart application: app.

]

{ #category : #example }
APMaClassBuilder class >> exampleJustGeneration [

	<script>
	
	| desc b |

	desc := self defaultDescription.

	b := APMaClassBuilder new.
	b name: #APMaTest.
	b packageName: 'Apart-Magritte'.
	b buildClass.
	b visit: desc.
	b apply.
]

{ #category : #accessing }
APMaClassBuilder >> addInitializer: aCode [ 

	self assert: (aCode trimBoth endsWith: '.').

	initializers add: aCode
]

{ #category : #accessing }
APMaClassBuilder >> apply [ 

	self defineAspects.
	self defineDefaultValues.

	environment apply
]

{ #category : #accessing }
APMaClassBuilder >> buildClass [ 

	builtClass := environment createClassNamed: self name asSymbol superclass: APartWithForm traitNames: #() slots: #() in: self packageName overwrite: false.
		
]

{ #category : #accessing }
APMaClassBuilder >> defineAspects [

	| src aspectNames |
	
	aspectNames := aspects joinUsing: ' '.

	src := 'defineAspects  <generated> ^ partInterface description createAllAspectsNamed: #(', aspectNames, ')'.
	
	environment compile: src in: builtClass classified: 'accessing'.
	
]

{ #category : #accessing }
APMaClassBuilder >> defineDefaultValues [

	| src |
	
	src := 'initializeDefaultValues  <generated> ', (initializers joinUsing: ' ').
	environment compile: src in: builtClass classified: 'accessing'.
	
	src := 'initializeValues  <generated> self initializeDefaultValues'.
	environment compile: src in: builtClass classified: 'accessing'.		

]

{ #category : #accessing }
APMaClassBuilder >> existingClass: aClass [ 

	self name: aClass name.
	self packageName: aClass package name.
]

{ #category : #accessing }
APMaClassBuilder >> generateBasicMethodsFor: aDescription [
	
	| aName |
	
	aDescription aspect ifNil: [ 
		^ self ].
	
	aName := aDescription aspect aspectName.
	
	self generateSlotNamed: aName.
	aspects add: aName.
		
	self generateSimpleAccessorsNamed: aName.
	self generateDescriptionMethodFor: aDescription.
		
	

]

{ #category : #accessing }
APMaClassBuilder >> generateDescriptionMethodFor: aDescription [
	
	| aName src |
	
	aName := aDescription aspect aspectName.
	
	src := aName, 'Description <magritteDescription> <generated>  ^ ', aDescription storeString.
	src := environment compile: src in: builtClass classified: 'magritte descriptions'.
]

{ #category : #accessing }
APMaClassBuilder >> generateSimpleAccessorsNamed: aName [

	| src |
		
	src := aName, ' <generated> ^ ', aName.
	src := environment compile: src in: builtClass classified: 'accessing'.

	src := aName asSymbol asMutator, ' anObject <generated> ', aName, ' := anObject'.
	src := environment compile: src in: builtClass classified: 'accessing'.
]

{ #category : #accessing }
APMaClassBuilder >> generateSimpleMethodsFor: aDescription [
	
	| aName |
	
	aDescription aspect ifNil: [ 
		^ self ].
	
	aName := aDescription aspect aspectName.
	
	self generateSlotNamed: aName.
	aspects add: aName.
		
	self generateSimpleAccessorsNamed: aName.
	self generateDescriptionMethodFor: aDescription.
		
	aDescription default ifNotNil: [ :aValue |
		self addInitializer: (aName, ' := ', aValue printString, '.') ].
	
	

]

{ #category : #accessing }
APMaClassBuilder >> generateSlotNamed: aName [
	
	builtClass layout addSlot: (RGInstanceVariableSlot named: aName asSymbol parent: builtClass)
	

]

{ #category : #accessing }
APMaClassBuilder >> initialize [ 

	super initialize.
	
	environment := APMaRealRingEnvironment new.
	self prepareEnvironment.
	aspects := OrderedCollection new.
	initializers :=  OrderedCollection new.
]

{ #category : #accessing }
APMaClassBuilder >> name [

	^ name
]

{ #category : #accessing }
APMaClassBuilder >> name: anObject [

	name := anObject
]

{ #category : #accessing }
APMaClassBuilder >> packageName [

	^ packageName
]

{ #category : #accessing }
APMaClassBuilder >> packageName: anObject [

	packageName := anObject
]

{ #category : #accessing }
APMaClassBuilder >> prepareEnvironment [

	| knownClassNames |

	knownClassNames := 'Magritte-Model' asPackage definedClasses collect: #name.

	knownClassNames do: [ :each | 
		environment ringEnvironment ensureClassNamed: each ].
]

{ #category : #accessing }
APMaClassBuilder >> visitBooleanDescription: aDescription [
	
	self generateSimpleMethodsFor: aDescription
]

{ #category : #accessing }
APMaClassBuilder >> visitContainer: aContainer [

	aContainer do: [ :each |
		self visit: each copy ]
]

{ #category : #accessing }
APMaClassBuilder >> visitMultipleOptionDescription: aDescription [

	| aName |

	self generateBasicMethodsFor: aDescription.
	
	aName := aDescription aspect aspectName.

	self addInitializer: ('{1} := APartList onPart: self key: #{1}.' format: { aName. aName }).

	
]

{ #category : #accessing }
APMaClassBuilder >> visitSingleOptionDescription: aDescription [

	| aName |

	self generateBasicMethodsFor: aDescription.
	
	aName := aDescription aspect aspectName.

	self addInitializer: ('{1} := APartList onPart: self key: #{1}.' format: { aName. aName }).

	
]

{ #category : #accessing }
APMaClassBuilder >> visitStringDescription: aDescription [
	
	self generateSimpleMethodsFor: aDescription
]

{ #category : #accessing }
APMaClassBuilder >> visitToOneRelationDescription: aDescription [

	| aName |

	self generateBasicMethodsFor: aDescription.
	
	aName := aDescription aspect aspectName.

	self addInitializer: ('{1} := APartList onPart: self key: #{1}.' format: { aName. aName }).

	
]
