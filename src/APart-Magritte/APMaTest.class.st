Class {
	#name : #APMaTest,
	#superclass : #APartWithForm,
	#instVars : [
		'boolean1',
		'multipleOptions',
		'singleOption',
		'someString',
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
		  aspect: (MAAspectAccessor aspectName: 'boolean1');
		  accessor: (MANullAccessor uuid:
					   #( 16 78 206 111 45 118 224 65 22 179 232 195 244 92 106 199 ));
		  label: 'label boolean';
		  default: true;
		  yourself
]

{ #category : #accessing }
APMaTest >> defineAspects [

	<generated>
	^ partInterface description createAllAspectsNamed:
		  #( text1 text2 boolean1 someString multipleOptions toOne singleOption )
]

{ #category : #accessing }
APMaTest >> initializeDefaultValues [

	<generated>
	text1 := 'default text'.
	boolean1 := true.
	multipleOptions := APartList onPart: self key: #multipleOptions.
	toOne := APartList onPart: self key: #toOne.
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
					   #( 113 36 31 141 138 143 60 4 93 167 242 224 9 70 48 94 ));
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
		  aspect: (MAAspectAccessor aspectName: 'singleOption');
		  accessor: (MANullAccessor uuid:
					   #( 23 13 201 41 106 218 60 174 93 243 103 71 28 243 104 252 ));
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
APMaTest >> someString [

	<generated>
	^ someString
]

{ #category : #accessing }
APMaTest >> someString: anObject [

	<generated>
	someString := anObject
]

{ #category : #'magritte descriptions' }
APMaTest >> someStringDescription [

	<magritteDescription>
	<generated>
	^ MAStringDescription new
		  accessor: (MANullAccessor uuid:
					   #( 178 35 34 240 146 245 91 215 178 50 122 25 233 230 17 51 ));
		  aspect: (MAAspectAccessor aspectName: #someString);
		  label: 'Some string';
		  placeholder: 'some placeholder';
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
					   #( 250 141 197 196 28 86 176 218 230 186 42 226 19 210 28 130 ));
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
					   #( 4 117 11 186 56 246 5 96 203 185 177 93 152 43 21 97 ));
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
		  aspect: (MAAspectAccessor aspectName: 'toOne');
		  accessor: (MANullAccessor uuid:
					   #( 84 145 36 162 228 162 123 84 35 67 169 93 150 248 161 106 ));
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
