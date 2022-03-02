Class {
	#name : #APMaTest,
	#superclass : #APartWithForm,
	#instVars : [
		'boolean1',
		'multipleOptions',
		'singleOption',
		'text1',
		'text2',
		'toOne'
	],
	#category : #'Apart-Magritte'
}

{ #category : #accessing }
APMaTest >> boolean1 [

	<generated>
	^ boolean1
]

{ #category : #accessing }
APMaTest >> boolean1: anObject [

	<generated>
	boolean1 := anObject
]

{ #category : #'magritte descriptions' }
APMaTest >> boolean1Description [

	<magritteDescription>
	<generated>
	^ MABooleanDescription new
		  accessor: (MANullAccessor uuid:
					   #( 246 74 75 117 2 50 216 138 254 153 117 25 10 12 116 165 ));
		  aspect: (MAAspectAccessor aspectName: 'boolean1');
		  label: 'label boolean';
		  default: true;
		  yourself
]

{ #category : #accessing }
APMaTest >> defineAspects [

	<generated>
	^ partInterface description createAllAspectsNamed:
		  #( text2 boolean1 text1 toOne multipleOptions singleOption )
]

{ #category : #accessing }
APMaTest >> initializeDefaultValues [

	<generated>
	boolean1 := true.
	text1 := 'default text'.
	toOne := APartList onPart: self key: #toOne.
	multipleOptions := APartList onPart: self key: #multipleOptions.
	singleOption := APartList onPart: self key: #singleOption
]

{ #category : #accessing }
APMaTest >> initializeValues [

	<generated>
	self initializeDefaultValues
]

{ #category : #accessing }
APMaTest >> multipleOptions [

	<generated>
	^ multipleOptions
]

{ #category : #accessing }
APMaTest >> multipleOptions: anObject [

	<generated>
	multipleOptions := anObject
]

{ #category : #'magritte descriptions' }
APMaTest >> multipleOptionsDescription [

	<magritteDescription>
	<generated>
	^ MAMultipleOptionDescription new
		  accessor: (MANullAccessor uuid:
					   #( 229 103 191 197 86 101 204 141 67 148 118 24 5 14 121 138 ));
		  aspect: (MAAspectAccessor aspectName: 'multipleOptions');
		  label: 'label multiple options';
		  priority: 200;
		  optionsTextual: 'MADelegatorAccessor
MADictionaryAccessor
MAIdentityAccessor
MANullAccessor
MAPluggableAccessor
MASelectorAccessor
MAVariableAccessor
MAAspectAccessor
MAChainAccessor
MAPropertyAccessor';
		  yourself
]

{ #category : #accessing }
APMaTest >> singleOption [

	<generated>
	^ singleOption
]

{ #category : #accessing }
APMaTest >> singleOption: anObject [

	<generated>
	singleOption := anObject
]

{ #category : #'magritte descriptions' }
APMaTest >> singleOptionDescription [

	<magritteDescription>
	<generated>
	^ MASingleOptionDescription new
		  accessor: (MANullAccessor uuid:
					   #( 229 8 193 27 39 224 184 234 27 123 229 70 184 172 194 96 ));
		  aspect: (MAAspectAccessor aspectName: 'singleOption');
		  label: 'label single option';
		  priority: 200;
		  optionsTextual: 'MADelegatorAccessor
MADictionaryAccessor
MAIdentityAccessor
MANullAccessor
MAPluggableAccessor
MASelectorAccessor
MAVariableAccessor
MAAspectAccessor
MAChainAccessor
MAPropertyAccessor';
		  yourself
]

{ #category : #accessing }
APMaTest >> text1 [

	<generated>
	^ text1
]

{ #category : #accessing }
APMaTest >> text1: anObject [

	<generated>
	text1 := anObject
]

{ #category : #'magritte descriptions' }
APMaTest >> text1Description [

	<magritteDescription>
	<generated>
	^ MAStringDescription new
		  accessor: (MANullAccessor uuid:
					   #( 247 73 236 216 100 118 204 243 16 185 46 219 24 104 47 156 ));
		  aspect: (MAAspectAccessor aspectName: 'text1');
		  label: 'label text 1';
		  default: 'default text';
		  password: true;
		  yourself
]

{ #category : #accessing }
APMaTest >> text2 [

	<generated>
	^ text2
]

{ #category : #accessing }
APMaTest >> text2: anObject [

	<generated>
	text2 := anObject
]

{ #category : #'magritte descriptions' }
APMaTest >> text2Description [

	<magritteDescription>
	<generated>
	^ MAStringDescription new
		  accessor: (MANullAccessor uuid:
					   #( 55 106 10 29 73 106 124 156 154 109 98 8 66 68 3 229 ));
		  aspect: (MAAspectAccessor aspectName: 'text2');
		  label: 'label text 2';
		  placeholder: 'some placeholder';
		  yourself
]

{ #category : #accessing }
APMaTest >> toOne [

	<generated>
	^ toOne
]

{ #category : #accessing }
APMaTest >> toOne: anObject [

	<generated>
	toOne := anObject
]

{ #category : #'magritte descriptions' }
APMaTest >> toOneDescription [

	<magritteDescription>
	<generated>
	^ MAToOneRelationDescription new
		  accessor: (MANullAccessor uuid:
					   #( 6 216 201 212 34 139 27 127 66 90 226 168 224 35 225 170 ));
		  aspect: (MAAspectAccessor aspectName: 'toOne');
		  label: 'label to one';
		  priority: 200;
		  classes: (OrderedCollection new
				   add: MADelegatorAccessor;
				   add: MADictionaryAccessor;
				   add: MAIdentityAccessor;
				   add: MANullAccessor;
				   add: MAPluggableAccessor;
				   add: MASelectorAccessor;
				   add: MAVariableAccessor;
				   add: MAAspectAccessor;
				   add: MAChainAccessor;
				   add: MAPropertyAccessor;
				   yourself);
		  yourself
]
