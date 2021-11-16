Class {
	#name : #APMaRingEnvironment,
	#superclass : #Object,
	#instVars : [
		'ringEnvironment'
	],
	#category : #'APart-Magritte'
}

{ #category : #accessing }
APMaRingEnvironment >> apply [

	"do nothing"
]

{ #category : #accessing }
APMaRingEnvironment >> basicGroupSuperclass [

	^ self ringEnvironment ensureClassNamed: self builder configuration basicGroupSuperclassName
]

{ #category : #accessing }
APMaRingEnvironment >> basicModelSuperclass [

	^ self ringEnvironment ensureClassNamed: self builder configuration basicModelSuperclassName
]

{ #category : #accessing }
APMaRingEnvironment >> basicSuperclass [

	^ self ringEnvironment ensureClassNamed: self builder configuration basicSuperclassName
]

{ #category : #accessing }
APMaRingEnvironment >> basicTrait [

	^ self ringEnvironment ensureClassNamed: #Trait
]

{ #category : #initialization }
APMaRingEnvironment >> classNamed: aClassName [

	^ self ringEnvironment ask behaviorNamed: aClassName
]

{ #category : #accessing }
APMaRingEnvironment >> compile: aSource in: aClass classified: aProtocol [

	| formatted |
	
	formatted := (RBParser parseMethod: aSource) formattedCode.
	aClass compile: formatted classified: aProtocol.
]

{ #category : #accessing }
APMaRingEnvironment >> compile: aSource in: aClass classified: aProtocol package: aPackageName [

	| selector |
	
	selector := aClass compile: aSource classified: aProtocol.
	(aClass methodNamed: selector) package: (aClass environment ensurePackageNamed: aPackageName).
]

{ #category : #initialization }
APMaRingEnvironment >> createClassNamed: aClassName superclass: aSuperclass traitNames: traitNames slots: slots in: packageName overwrite: shouldOverwrite [

	| aClass existingClass composition |
	
	existingClass := self ringEnvironment ask
		behaviorNamed: aClassName asSymbol.
	
	(existingClass isNotNil and: [ shouldOverwrite not ])
		ifTrue: [ ^ existingClass ].
	
	aClass := self ringEnvironment ensureClassNamed: aClassName.
	aClass
		superclass: (self ringEnvironment ensureClassNamed: aSuperclass name).
	
	composition := RGTraitComposition parent: aClass.
	aClass traitComposition: composition.
	
	traitNames
		do: [ :each | 
			composition
				addTransformation: (self ringEnvironment ensureTraitNamed: each) ].
	
	aClass
		package: (self ringEnvironment ensurePackageNamed: packageName).
	aClass layout makeResolved.
	
	slots
		do: [ :slotInBadEnvironment | 
			| slot |
			slot := slotInBadEnvironment isSpecial
				ifTrue: [ (RGUnknownSlot
						named: slotInBadEnvironment name
						parent: aClass layout)
						expression: slotInBadEnvironment expression;
						yourself ]
				ifFalse: [ RGInstanceVariableSlot
						named: slotInBadEnvironment name
						parent: aClass layout ].
			aClass layout addSlot: slot.
			slot propertyNamed: #isGenerated put: true ].


	^ aClass
]

{ #category : #initialization }
APMaRingEnvironment >> createTraitNamed: traitName uses: traitNames slots: slots in: packageName overwrite: shouldOverwrite [

	| aPackage aTrait existingClass composition |
	
	existingClass := self ringEnvironment ask
		behaviorNamed: traitName asSymbol.
	(existingClass isNotNil and: [ shouldOverwrite not ])
		ifTrue: [ ^ existingClass ].
	
	aPackage := self ringEnvironment ensurePackageNamed: packageName.
	
	aTrait := ringEnvironment ensureTraitNamed: traitName.
	aTrait superclass: self basicTrait.
	
	composition := RGTraitComposition parent: aTrait.
	aTrait traitComposition: composition.
	
	traitNames
		do: [ :each | 
			composition
				addTransformation: (self ringEnvironment ensureTraitNamed: each) ].
	
	aTrait package: aPackage.
	aTrait layout makeResolved.
	
	slots
		do: [ :slotInBadEnvironment | 
			| slot |
			slot := slotInBadEnvironment isSpecial
				ifTrue: [ (RGUnknownSlot
						named: slotInBadEnvironment name
						parent: aTrait layout)
						expression: slotInBadEnvironment expression;
						yourself ]
				ifFalse: [ RGInstanceVariableSlot
						named: slotInBadEnvironment name
						parent: aTrait layout ].
			aTrait layout addSlot: slot.
			slot propertyNamed: #isGenerated put: true ].
	
	^ aTrait
]

{ #category : #initialization }
APMaRingEnvironment >> hasBehaviorNamed: aClassName [

	^ self ringEnvironment ask includesClassNamed: aClassName
]

{ #category : #initialization }
APMaRingEnvironment >> initialize [

	super initialize.
	
	ringEnvironment := RGEnvironment new.
	ringEnvironment version: 7.
	ringEnvironment ensureClassNamed: #FMOne.
	ringEnvironment ensureClassNamed: #FMMany.		

]

{ #category : #'public registration' }
APMaRingEnvironment >> registerPackage: aPackageName [

	^ self ringEnvironment ensurePackageNamed: aPackageName.

]

{ #category : #accessing }
APMaRingEnvironment >> ringEnvironment [
	^ ringEnvironment
]

{ #category : #initialization }
APMaRingEnvironment >> setComment: aString for: aClass [

	aClass comment content: aString
]

{ #category : #initialization }
APMaRingEnvironment >> slotNamed: slotName [
	^ (RGUnknownSlot named: slotName asSymbol) expression: #FMProperty
]

{ #category : #initialization }
APMaRingEnvironment >> slotNamed: slotName cardinality: cardinality type: type opposite: oppositeName [

	| cardinalityClassName |
	
	cardinalityClassName := cardinality = #one
		ifTrue: [ #FMOne ]
		ifFalse: [ #FMMany ].
		
	^ (RGUnknownSlot named: slotName asSymbol)
		 expression: ('{1} type: #{2} opposite: #{3}' 
			format: { cardinalityClassName. type. oppositeName}) 
]
